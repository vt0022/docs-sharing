package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.*;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/api/v1/stats")
@RestController
public class StatsController {
    private final IDocumentService documentService;
    private final IPostService postService;
    private final IUserService userService;
    private final ITagService tagService;
    private final ICategoryService categoryService;
    private final IFieldService fieldService;
    private final IPostReportService postReportService;
    private final IDocumentReportService documentReportService;

    @Autowired
    public StatsController(IDocumentService documentService, IPostService postService, IUserService userService, ITagService tagService, ICategoryService categoryService, IFieldService fieldService, IPostReportService postReportService, IDocumentReportService documentReportService) {
        this.documentService = documentService;
        this.postService = postService;
        this.userService = userService;
        this.tagService = tagService;
        this.categoryService = categoryService;
        this.fieldService = fieldService;
        this.postReportService = postReportService;
        this.documentReportService = documentReportService;
    }


    @Operation(summary = "Lấy tóm tắt thống kê tổng số các mục theo tháng này, năm này, tất cả",
            description = "Lấy tóm tắt thống kê tổng số các mục theo tháng này, năm này, tất cả (thisMonth, thisYear, all). Chỉ Admin có quyền xem.")
    @GetMapping("/stats/summary")
    public ResponseEntity<?> getStatsSummary(@RequestParam(required = false) String period) {

        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not found"));
        // Kiểm tra xem người dùng đã đăng nhập và có quyền xem thống kê không
        if (!(user != null && (user.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to view stats");
        }

        Map<String, Object> stats = new HashMap<>();

        // Lấy tháng, năm hiện tại
        LocalDateTime now = LocalDateTime.now();
        int currentMonth = now.getMonthValue();
        int currentYear = now.getYear();

        if(period == null || "all".equals(period)) {
        // Tính toán cho tổng cộng
            stats.put("totalDocuments", documentService.countAll());

            stats.put("totalPosts", postService.countAll());

            stats.put("totalUsers", userService.countAll());

            stats.put("totalTags", tagService.countAll());

            stats.put("totalCategories", categoryService.countAll());

            stats.put("totalFields", fieldService.countAll());

            stats.put("totalPostReports", postReportService.countAll());

            stats.put("totalDocumentReports", documentReportService.countAll());
        } else if("thisMonth".equals(period)) {
        // Tính toán cho tháng này
            stats.put("totalDocuments", documentService.countByUploadedAtYearAndMonth(currentYear, currentMonth));

            stats.put("totalPosts", postService.countByCreatedAtYearAndMonth(currentYear, currentMonth));

            stats.put("totalUsers", userService.countByCreatedAtYearAndMonth(currentYear, currentMonth));

            stats.put("totalTags", tagService.countByCreatedAtYearAndMonth(currentYear, currentMonth));

            stats.put("totalCategories", categoryService.countByCreatedAtYearAndMonth(currentYear, currentMonth));

            stats.put("totalFields", fieldService.countByCreatedAtYearAndMonth(currentYear, currentMonth));

            stats.put("totalPostReports", postReportService.countByReportedAtYearAndMonth(currentYear, currentMonth));

            stats.put("totalDocumentReports", documentReportService.countByReportedAtYearAndMonth(currentYear, currentMonth));
        } else if("thisYear".equals(period)) {
        // Tính toán cho năm này
            stats.put("totalDocuments", documentService.countByUploadedAtYear(currentYear));

            stats.put("totalPosts", postService.countByCreatedAtYear(currentYear));

            stats.put("totalUsers", userService.countByCreatedAtYear(currentYear));

            stats.put("totalTags", tagService.countByCreatedAtYear(currentYear));

            stats.put("totalCategories", categoryService.countByCreatedAtYear(currentYear));

            stats.put("totalFields", fieldService.countByCreatedAtYear(currentYear));

            stats.put("totalPostReports", postReportService.countByReportedAtYear(currentYear));

            stats.put("totalDocumentReports", documentReportService.countByReportedAtYear(currentYear));
        }

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get the summary of stats successfully")
                .data(stats)
                .build());

    }

    @Operation(summary = "Lấy thống kê tài liệu được đăng trong 6 tháng gần nhất",
            description = "Lấy thống kê tài liệu được đăng trong 6 tháng gần nhất. Chỉ Admin có quyền xem.")
    @GetMapping("/document/6month")
    public ResponseEntity<?> getDocumentStats() {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not found"));
        // Kiểm tra xem người dùng đã đăng nhập và có quyền xem thống kê không
        if (!(user != null && (user.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to view stats");
        }

        List<Long> documentStats = new ArrayList<>();
        for (int i = 5; i >= 0; i--) {
            LocalDateTime now = LocalDateTime.now().minusMonths(i);
            int year = now.getYear();
            int month = now.getMonthValue();
            long count = documentService.countByUploadedAtYearAndMonth(year, month);
            documentStats.add(count);
        }
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get document stats successfully")
                .data(documentStats)
                .build());
    }

    @Operation(summary = "Lấy thống kê bài viết được đăng trong 6 tháng gần nhất",
            description = "Lấy thống kê bài viết được đăng trong 6 tháng gần nhất. Chỉ Admin có quyền xem.")
    @GetMapping("/post/6month")
    public ResponseEntity<?> getPostStats() {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not found"));
        // Kiểm tra xem người dùng đã đăng nhập và có quyền xem thống kê không
        if (!(user != null && (user.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to view stats");
        }

        List<Long> postStats = new ArrayList<>();
        for (int i = 5; i >= 0; i--) {
            LocalDateTime now = LocalDateTime.now().minusMonths(i);
            int year = now.getYear();
            int month = now.getMonthValue();
            long count = postService.countByCreatedAtYearAndMonth(year, month);
            postStats.add(count);
        }
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get post stats successfully")
                .data(postStats)
                .build());
    }

    @Operation(summary = "Lấy thống kê người dùng đăng ký trong 6 tháng gần nhất",
            description = "Lấy thống kê người dùng đăng ký trong 6 tháng gần nhất. Chỉ Admin có quyền xem.")
    @GetMapping("/registration/6month")
    public ResponseEntity<?> getRegistrationStats() {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not found"));
        // Kiểm tra xem người dùng đã đăng nhập và có quyền xem thống kê không
        if (!(user != null && (user.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to view stats");
        }

        List<Long> registrationStats = new ArrayList<>();
        for (int i = 5; i >= 0; i--) {
            LocalDateTime now = LocalDateTime.now().minusMonths(i);
            int year = now.getYear();
            int month = now.getMonthValue();
            long count = userService.countByCreatedAtYearAndMonth(year, month);
            registrationStats.add(count);
        }
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get registration stats successfully")
                .data(registrationStats)
                .build());
    }
}
