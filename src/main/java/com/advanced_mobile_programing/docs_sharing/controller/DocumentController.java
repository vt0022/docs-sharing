package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.Document;
import com.advanced_mobile_programing.docs_sharing.entity.DocumentLike;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.response_model.DocumentResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.IDocumentLikeService;
import com.advanced_mobile_programing.docs_sharing.service.IDocumentService;
import com.advanced_mobile_programing.docs_sharing.service.IUserService;
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
    private final ModelMapper modelMapper;


    public DocumentController(IDocumentService documentService, IDocumentLikeService documentLikeService, IUserService userService, ModelMapper modelMapper) {
        this.documentService = documentService;
        this.documentLikeService = documentLikeService;
        this.userService = userService;
        this.modelMapper = modelMapper;
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
