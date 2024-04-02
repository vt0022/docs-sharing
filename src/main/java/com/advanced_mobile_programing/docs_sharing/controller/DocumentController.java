package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.*;
import com.advanced_mobile_programing.docs_sharing.model.FileModel;
import com.advanced_mobile_programing.docs_sharing.model.request_model.DocumentRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.DocumentResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.*;
import com.advanced_mobile_programing.docs_sharing.util.GoogleDriveUpload;
import io.swagger.v3.oas.annotations.Operation;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RequestMapping("/api/v1/document")
@RestController
public class DocumentController {
    private final IDocumentService documentService;
    private final IDocumentLikeService documentLikeService;
    private final IUserService userService;
    private final ICategoryService categoryService;
    private final IFieldService fieldService;
    private final INotificationService notificationService;
    private final GoogleDriveUpload googleDriveUpload;
    private final ModelMapper modelMapper;


    public DocumentController(IDocumentService documentService, IDocumentLikeService documentLikeService, IUserService userService, ICategoryService categoryService, IFieldService fieldService, INotificationService notificationService, GoogleDriveUpload googleDriveUpload, ModelMapper modelMapper) {
        this.documentService = documentService;
        this.documentLikeService = documentLikeService;
        this.userService = userService;
        this.categoryService = categoryService;
        this.fieldService = fieldService;
        this.notificationService = notificationService;
        this.googleDriveUpload = googleDriveUpload;
        this.modelMapper = modelMapper;
    }

    @Operation(summary = "Lấy tất cả tài liệu của người dùng hiện tại",
            description = "Trả về danh sách tất cả tài liệu của người dùng hiện tại")
    @GetMapping("/user/documents")
    public ResponseEntity<?> getDocumentsByLoggedInUser(@RequestParam(defaultValue = "0") int page,
                                                        @RequestParam(defaultValue = "10") int size) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Sort sort = Sort.by(Sort.Direction.DESC, "uploadedAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<Document> documents = documentService.findByUser(user, pageable);
        Page<DocumentResponseModel> documentResponseModels = documents.map(this::convertToDocumentModel);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get documents by current user successfully")
                .data(documentResponseModels)
                .build());
    }

    @Operation(summary = "Lấy tất cả tài liệu của một người dùng",
            description = "Trả về danh sách tất cả tài liệu của một người dùng")
    @GetMapping("/user/{userId}")
    public ResponseEntity<?> getDocumentsByUser(@PathVariable int userId,
                                                @RequestParam(defaultValue = "0") int page,
                                                @RequestParam(defaultValue = "10") int size) {
        User user = userService.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        Sort sort = Sort.by(Sort.Direction.DESC, "uploadedAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<Document> documents = documentService.findByUser(user, pageable);
        Page<DocumentResponseModel> documentResponseModels = documents.map(this::convertToDocumentModel);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get documents by user successfully")
                .data(documentResponseModels)
                .build());
    }

    @Operation(summary = "Xem danh sách tài liệu",
            description = "Trả về danh sách tất cả tài liệu")
    @GetMapping("/all")
    public ResponseEntity<?> getAllDocument(@RequestParam(defaultValue = "0") int page,
                                            @RequestParam(defaultValue = "10") int size) {
        Sort sort = Sort.by(Sort.Direction.DESC, "uploadedAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<Document> documents = documentService.findAll(pageable);
        Page<DocumentResponseModel> documentResponseModels = documents.map(this::convertToDocumentModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get all document successfully")
                .data(documentResponseModels)
                .build());
    }

    @Operation(summary = "Tìm kiếm tài liệu",
            description = "Trả về danh sách tất cả tài liệu tìm được kèm với sắp xếp")
    @GetMapping("/search")
    public ResponseEntity<?> searchDocument(@RequestParam(defaultValue = "0") int page,
                                            @RequestParam(defaultValue = "10") int size,
                                            @RequestParam(defaultValue = "") String q,
                                            @RequestParam(defaultValue = "", required = false) List<Integer> categories,
                                            @RequestParam(defaultValue = "", required = false) List<Integer> fields,
                                            @RequestParam(defaultValue = "newest") String order) {
        // Order can be newest, mostLikes, mostViews
        Pageable pageable = PageRequest.of(page, size);

        Page<Document> documents = documentService.searchAll(q, categories, fields, order, pageable);
        Page<DocumentResponseModel> documentResponseModels = documents.map(this::convertToDocumentModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Search all document successfully")
                .data(documentResponseModels)
                .build());
    }

    @Operation(summary = "Thích tài liệu",
            description = "Nhấn thích/bỏ thích một tài liệu")
    @GetMapping("/{docId}/like")
    public ResponseEntity<?> likeDocument(@PathVariable int docId) {
        Document document = documentService.findById(docId).orElseThrow(() -> new RuntimeException("Document not found for document"));
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        boolean isLiked = false;

        Optional<DocumentLike> documentLike = documentLikeService.findByUserAndDocument(user, document);
        if (documentLike.isPresent()) {
            // Bỏ thích
            documentLikeService.delete(documentLike.get());
            isLiked = true;
        } else {
            DocumentLike like = new DocumentLike();
            like.setUser(user);
            like.setDocument(document);
            documentLikeService.save(like);

            Notification notification = new Notification();
            notification.setType("DOC_LIKE");
            notification.setReferredId(document.getDocId());
            notification.setUserReceived(document.getUser());
            notification.setUserTriggered(user);
            notification = notificationService.save(notification);
            notificationService.notifyUser(document.getUser().getEmail(), notification);
        }

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message((isLiked ? "Unlike" : "Like") + " document successfully")
                .build());
    }

    @Operation(summary = "Xem 1 tài liệu cụ thể",
            description = "Xem 1 tài liệu cụ thể")
    @GetMapping("/{docId}")
    public ResponseEntity<?> getDocument(@PathVariable int docId) {
        Document document = documentService.findById(docId).orElseThrow(() -> new RuntimeException("Document not found"));
        DocumentResponseModel documentResponseModel = convertToDocumentModel(document);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .data(documentResponseModel)
                .build());
    }

    @Operation(summary = "Đăng tài liệu mới",
            description = "Tạo một tài liệu mới")
    @PostMapping(path = "/create", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> createDocument(@RequestPart("doc") DocumentRequestModel documentRequestModel,
                                            @RequestPart("file") MultipartFile multipartFile) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        FileModel gd = googleDriveUpload.uploadFile(multipartFile, documentRequestModel.getDocName(), null);
        Category category = categoryService.findById(documentRequestModel.getCategoryId()).orElseThrow(() -> new RuntimeException("Category not found"));
        Field field = fieldService.findById(documentRequestModel.getFieldId()).orElseThrow(() -> new RuntimeException("Field not found"));

        Document document = modelMapper.map(documentRequestModel, Document.class);
        document.setViewUrl(gd.getViewUrl());
        document.setDownloadUrl(gd.getDownloadUrl());
        document.setUser(user);
        document.setCategory(category);
        document.setField(field);

        documentService.save(document);

        DocumentResponseModel documentResponseModel = convertToDocumentModel(document);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Document created successfully")
                .data(documentResponseModel)
                .build());
    }


    @Operation(summary = "Chỉnh sửa tài liệu",
            description = "Người dùng chỉ có quyền chỉnh sửa tài liệu của mình")
    @PutMapping(path = "/{docId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> updateDocument(@PathVariable int docId,
                                            @RequestPart("doc") DocumentRequestModel documentRequestModel,
                                            @RequestPart(name = "file", required = false) MultipartFile multipartFile) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Document document = documentService.findById(docId).orElseThrow(() -> new RuntimeException("Document not found"));

        // Kiểm tra xem người dùng có quyền chỉnh sửa tài liệu hay không
        if (!(document.getUser().equals(user))) {
            throw new RuntimeException("You don't have permission to update this document");
        }

        Category category = categoryService.findById(documentRequestModel.getCategoryId()).orElseThrow(() -> new RuntimeException("Category not found"));
        Field field = fieldService.findById(documentRequestModel.getFieldId()).orElseThrow(() -> new RuntimeException("Field not found"));

        if (multipartFile != null) {
            // Get id of old file and thumbnail file
            String fileId = document.getViewUrl() != null ? getFileId(document.getViewUrl()) : null;
            // Upload file
            FileModel gd = googleDriveUpload.uploadFile(multipartFile, documentRequestModel.getDocName(), fileId);
            // Update file properties for document without overwriting existing properties
            document.setViewUrl(gd.getViewUrl());
            document.setDownloadUrl(gd.getDownloadUrl());
        }

        // Cập nhật thông tin tài liệu
        document.setDocName(documentRequestModel.getDocName());
        document.setDocIntroduction(documentRequestModel.getDocIntroduction());
        document.setCategory(category);
        document.setField(field);
        documentService.save(document);

        DocumentResponseModel documentResponseModel = convertToDocumentModel(document);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Document updated successfully")
                .data(documentResponseModel)
                .build());
    }

    @Operation(summary = "Xóa tài liệu",
            description = "Người dùng chỉ có quyền xóa tài liệu của mình. Admin có quyền xóa bất kỳ tài liệu nào.")
    @DeleteMapping("/{docId}")
    public ResponseEntity<?> deleteDocument(@PathVariable int docId) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Document document = documentService.findById(docId).orElseThrow(() -> new RuntimeException("Document not found"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền xóa tài liệu hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1 || document.getUser().equals(loggedInUser)))) {
            throw new RuntimeException("You don't have permission to delete this document");
        }

        // Xóa tài liệu nếu người dùng đã đăng nhập và có quyền xóa tài liệu
        documentService.delete(docId);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Document deleted successfully")
                .build());
    }

    public DocumentResponseModel convertToDocumentModel(Document document) {
        DocumentResponseModel documentResponseModel = modelMapper.map(document, DocumentResponseModel.class);

        int totalLikes = document.getDocumentLikes().size();
        documentResponseModel.setTotalLikes(totalLikes);

        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        boolean isLiked = documentLikeService.findByUserAndDocument(user, document).isPresent() ? true : false;
        documentResponseModel.setLiked(isLiked);

        return documentResponseModel;
    }

    public String getFileId(String url) {
        String regex = "/file/d/([^/]+)/";
        Pattern pattern = Pattern.compile(regex);

        Matcher matcher = pattern.matcher(url);

        if (matcher.find()) {
            String fileId = matcher.group(1);
            return fileId;
        } else {
            return null;
        }
    }
}
