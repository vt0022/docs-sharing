package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.constant.Constants;
import com.advanced_mobile_programing.docs_sharing.entity.*;
import com.advanced_mobile_programing.docs_sharing.model.request_model.DocumentReportRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.request_model.PostReportRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.DocumentReportResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.PostReportResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ReportTypeResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.*;
import io.swagger.v3.oas.annotations.Operation;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/reports")
public class ReportController {
    private final IReportTypeService reportTypeService;
    private final IDocumentReportService documentReportService;
    private final IPostReportService postReportService;
    private final IUserService userService;
    private final IDocumentService documentService;
    private final IPostService postService;
    private final ModelMapper modelMapper;

    @Autowired
    public ReportController(IReportTypeService reportTypeService, IDocumentReportService documentReportService, IPostReportService postReportService, IUserService userService, IDocumentService documentService, IPostService postService, ModelMapper modelMapper) {
        this.reportTypeService = reportTypeService;
        this.documentReportService = documentReportService;
        this.postReportService = postReportService;
        this.userService = userService;
        this.documentService = documentService;
        this.postService = postService;
        this.modelMapper = modelMapper;
    }

    @Operation(summary = "Xem danh sách lý do báo cáo tài liệu",
            description = "Trả về danh sách lý do báo cáo tài liệu")
    @GetMapping("/types/document")
    public ResponseEntity<?> getDocumentReports() {
        List<ReportType> reportTypes = reportTypeService.findByType(Constants.DOCUMENT_REPORT);

        List<ReportTypeResponseModel> reportTypeResponseModels = modelMapper.map(reportTypes, new TypeToken<List<ReportTypeResponseModel>>() {
        }.getType());
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get report reasons for document successfully")
                .data(reportTypeResponseModels)
                .build());
    }

    @Operation(summary = "Xem danh sách lý do báo cáo bài đăng",
            description = "Trả về danh sách lý do báo cáo bài đăng")
    @GetMapping("/types/post")
    public ResponseEntity<?> getPostReports() {
        List<ReportType> reportTypes = reportTypeService.findByType(Constants.POST_REPORT);

        List<ReportTypeResponseModel> reportTypeResponseModels = modelMapper.map(reportTypes, new TypeToken<List<ReportTypeResponseModel>>() {
        }.getType());
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get report reasons for post successfully")
                .data(reportTypeResponseModels)
                .build());
    }

    @Operation(summary = "Xem danh sách báo cáo tài liệu",
            description = "Trả về danh sách tất cả báo cáo tài liệu")
    @GetMapping("/document")
    public ResponseEntity<?> getDocumentReports(@RequestParam(defaultValue = "0") int page,
                                                @RequestParam(defaultValue = "10") int size,
                                                @RequestParam(required = false) Boolean isRead) {
        Sort sort = Sort.by(Sort.Direction.DESC, "reportedAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<DocumentReport> documentReports = Page.empty();
        if (isRead == null)
            documentReports = documentReportService.findAll(pageable);
        else
            documentReports = documentReportService.findByIsRead(isRead, pageable);

        Page<DocumentReportResponseModel> documentReportResponseModels = documentReports.map(this::convertToDocumentReportModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get document reports successfully")
                .data(documentReportResponseModels)
                .build());
    }

    @Operation(summary = "Xem danh sách báo cáo bài đăng",
            description = "Trả về danh sách tất cả báo cáo bài đăng")
    @GetMapping("/post")
    public ResponseEntity<?> getPostReports(@RequestParam(defaultValue = "0") int page,
                                            @RequestParam(defaultValue = "10") int size,
                                            @RequestParam(required = false) Boolean isRead) {
        Sort sort = Sort.by(Sort.Direction.DESC, "reportedAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<PostReport> postReports = Page.empty();
        if (isRead == null)
            postReports = postReportService.findAll(pageable);
        else
            postReports = postReportService.findByIsRead(isRead, pageable);

        Page<PostReportResponseModel> postReportResponseModels = postReports.map(this::convertToPostReportModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get post reports successfully")
                .data(postReportResponseModels)
                .build());
    }

    @Operation(summary = "Báo cáo bài đăng",
            description = "Trả về báo cáo bài đăng đã tạo")
    @PostMapping("/post")
    public ResponseEntity<?> reportPost(@RequestBody PostReportRequestModel postReportRequestModel) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Post post = postService.findById(postReportRequestModel.getPostId()).orElseThrow(() -> new RuntimeException("Post not found"));
        ReportType reportType = reportTypeService.findById(postReportRequestModel.getTypeId()).orElseThrow(() -> new RuntimeException("Report type not found"));

        PostReport postReport = new PostReport();
        postReport.setPost(post);
        postReport.setUser(user);
        postReport.setReportType(reportType);
        postReport.setReason(postReportRequestModel.getReason());
        postReport = postReportService.save(postReport);

        PostReportResponseModel postReportResponseModels = modelMapper.map(postReport, PostReportResponseModel.class);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Report post successfully")
                .data(postReportResponseModels)
                .build());
    }

    @Operation(summary = "Báo cáo tài liệu",
            description = "Trả về báo cáo tài liệu đã tạo")
    @PostMapping("/document")
    public ResponseEntity<?> reportDocument(@RequestBody DocumentReportRequestModel documentReportRequestModel) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Document document = documentService.findById(documentReportRequestModel.getDocId()).orElseThrow(() -> new RuntimeException("Document not found"));
        ReportType reportType = reportTypeService.findById(documentReportRequestModel.getTypeId()).orElseThrow(() -> new RuntimeException("Report type not found"));

        DocumentReport documentReport = new DocumentReport();
        documentReport.setDocument(document);
        documentReport.setReportType(reportType);
        documentReport.setUser(user);
        documentReport.setReason(documentReportRequestModel.getReason());
        documentReport = documentReportService.save(documentReport);

        DocumentReportResponseModel documentReportResponseModel = modelMapper.map(documentReport, DocumentReportResponseModel.class);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Report document successfully")
                .data(documentReportResponseModel)
                .build());
    }

    @Operation(summary = "Xem báo cáo tài liệu",
            description = "Trả về báo cáo tài liệu")
    @GetMapping("/document/{reportId}")
    public ResponseEntity<?> viewDocumentReport(@PathVariable int reportId) {
        DocumentReport documentReport = documentReportService.findById(reportId).orElseThrow(() -> new RuntimeException("Report not found"));

        documentReport.setRead(true);
        documentReport = documentReportService.save(documentReport);

        DocumentReportResponseModel documentReportResponseModel = modelMapper.map(documentReport, DocumentReportResponseModel.class);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get document report successfully")
                .data(documentReportResponseModel)
                .build());
    }

    @Operation(summary = "Xem báo cáo bài đăng",
            description = "Trả về báo cáo bài đăng")
    @GetMapping("/post/{reportId}")
    public ResponseEntity<?> viewPostReport(@PathVariable int reportId) {
        PostReport postReport = postReportService.findById(reportId).orElseThrow(() -> new RuntimeException("Report not found"));

        postReport.setRead(true);
        postReport = postReportService.save(postReport);

        PostReportResponseModel postReportResponseModels = modelMapper.map(postReport, PostReportResponseModel.class);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get post report successfully")
                .data(postReportResponseModels)
                .build());
    }

    private DocumentReportResponseModel convertToDocumentReportModel(DocumentReport documentReport) {
        DocumentReportResponseModel documentReportResponseModel = modelMapper.map(documentReport, DocumentReportResponseModel.class);

        return documentReportResponseModel;
    }

    private PostReportResponseModel convertToPostReportModel(PostReport postReport) {
        PostReportResponseModel postReportResponseModel = modelMapper.map(postReport, PostReportResponseModel.class);

        return postReportResponseModel;
    }
}
