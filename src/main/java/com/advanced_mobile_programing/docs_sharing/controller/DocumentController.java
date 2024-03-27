package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.*;
import com.advanced_mobile_programing.docs_sharing.model.request_model.DocumentRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.DocumentResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.*;
import io.swagger.v3.oas.annotations.Operation;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RequestMapping("/api/v1/document")
@RestController
public class DocumentController {
    private final IDocumentService documentService;
    private final IDocumentLikeService documentLikeService;
    private final IUserService userService;
    private final ICategoryService categoryService;
    private final IFieldService fieldService;
    private final ModelMapper modelMapper;


    public DocumentController(IDocumentService documentService, IDocumentLikeService documentLikeService, IUserService userService, ICategoryService categoryService, IFieldService fieldService, ModelMapper modelMapper) {
        this.documentService = documentService;
        this.documentLikeService = documentLikeService;
        this.userService = userService;
        this.categoryService = categoryService;
        this.fieldService = fieldService;
        this.modelMapper = modelMapper;
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
        }

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message(isLiked ? "Unlike" : "Like" + " document successfully")
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
    @PostMapping("/create")
    public ResponseEntity<?> createDocument(@RequestBody DocumentRequestModel documentRequestModel) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        Category category = categoryService.findById(documentRequestModel.getCategoryId()).orElseThrow(() -> new RuntimeException("Category not found"));
        Field field = fieldService.findById(documentRequestModel.getFieldId()).orElseThrow(() -> new RuntimeException("Field not found"));

        Document document = new Document();
        document.setDocName(documentRequestModel.getDocName());
        document.setDocIntroduction(documentRequestModel.getDocIntroduction());
        document.setViewUrl(documentRequestModel.getViewUrl());
        document.setDownloadUrl(documentRequestModel.getDownloadUrl());
        document.setThumbnail(documentRequestModel.getThumbnail());
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
    @PutMapping("/{docId}")
    public ResponseEntity<?> updateDocument(@PathVariable int docId, @RequestBody DocumentRequestModel documentRequestModel) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Document document = documentService.findById(docId).orElseThrow(() -> new RuntimeException("Document not found"));

        // Kiểm tra xem người dùng có quyền chỉnh sửa tài liệu hay không
        if (!(document.getUser().equals(user))) {
            throw new RuntimeException("You don't have permission to update this document");
        }

        Category category = categoryService.findById(documentRequestModel.getCategoryId()).orElseThrow(() -> new RuntimeException("Category not found"));
        Field field = fieldService.findById(documentRequestModel.getFieldId()).orElseThrow(() -> new RuntimeException("Field not found"));

        // Cập nhật thông tin tài liệu
        document.setDocName(documentRequestModel.getDocName());
        document.setDocIntroduction(documentRequestModel.getDocIntroduction());
        document.setViewUrl(documentRequestModel.getViewUrl());
        document.setDownloadUrl(documentRequestModel.getDownloadUrl());
        document.setThumbnail(documentRequestModel.getThumbnail());
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

    private DocumentResponseModel convertToDocumentModel(Document document) {
        DocumentResponseModel documentResponseModel = modelMapper.map(document, DocumentResponseModel.class);

        int totalLikes = document.getDocumentLikes().size();
        documentResponseModel.setTotalLikes(totalLikes);

        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        boolean isLiked = documentLikeService.findByUserAndDocument(user, document).isPresent() ? true : false;
        documentResponseModel.setLiked(isLiked);

        return documentResponseModel;
    }
}
