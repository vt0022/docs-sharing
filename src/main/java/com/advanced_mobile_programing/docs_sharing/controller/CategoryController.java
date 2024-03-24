package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.Category;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.request_model.CategoryRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.CategoryResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.ICategoryService;
import com.advanced_mobile_programing.docs_sharing.service.IUserService;
import io.swagger.v3.oas.annotations.Operation;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/v1/category")
@RestController
public class CategoryController {
    private final ICategoryService categoryService;
    private final IUserService userService;
    private final ModelMapper modelMapper;

    @Autowired
    public CategoryController(ICategoryService categoryService, IUserService userService, ModelMapper modelMapper) {
        this.categoryService = categoryService;
        this.userService = userService;
        this.modelMapper = modelMapper;
    }

    @Operation(summary = "Xem danh sách danh mục",
            description = "Trả về danh sách tất cả danh mục")
    @GetMapping("/all")
    public ResponseEntity<?> getAllCategories(@RequestParam(defaultValue = "0") int page,
                                              @RequestParam(defaultValue = "10") int size) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<Category> categories = categoryService.findAll(pageable);
        Page<CategoryResponseModel> categoryResponseModels = categories.map(this::convertToCategoryResponseModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get all categories successfully")
                .data(categoryResponseModels)
                .build());
    }

    @Operation(summary = "Xem 1 danh mục cụ thể",
            description = "Xem 1 danh mục cụ thể")
    @GetMapping("/{categoryId}")
    public ResponseEntity<?> getCategory(@PathVariable int categoryId) {
        Category category = categoryService.findById(categoryId).orElseThrow(() -> new RuntimeException("Category not found"));
        CategoryResponseModel categoryResponseModel = convertToCategoryResponseModel(category);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .data(categoryResponseModel)
                .build());
    }

    @Operation(summary = "Tìm kiếm danh mục",
            description = "Trả về danh sách tất cả danh mục tìm được kèm với sắp xếp (newest, oldest, mostUses)")
    @GetMapping("/search")
    public ResponseEntity<?> searchCategory(@RequestParam(defaultValue = "0") int page,
                                            @RequestParam(defaultValue = "10") int size,
                                            @RequestParam(defaultValue = "") String q,
                                            @RequestParam(defaultValue = "newest") String order) {
        // Order can be newest, mostUses, oldest
        Pageable pageable = PageRequest.of(page, size);

        Page<Category> categories = categoryService.searchAll(q, order, pageable);
        Page<CategoryResponseModel> categoryResponseModels = categories.map(this::convertToCategoryResponseModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Search all category successfully")
                .data(categoryResponseModels)
                .build());
    }

    @Operation(summary = "Thêm danh mục mới",
            description = "Thêm danh mục mới. Chỉ Admin có quyền thực hiện")
    @PostMapping("/create")
    public ResponseEntity<?> createCategory(@RequestBody CategoryRequestModel categoryRequestModel) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền thêm danh mục hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to create category");
        }

        // Kiểm tra xem name của category mới có trong database chưa
        String categoryName = categoryRequestModel.getCategoryName();
        boolean exists = categoryService.existsByCategoryName(categoryName);

        if (exists) {
            return ResponseEntity.ok(ResponseModel
                    .builder()
                    .status(400)
                    .error(true)
                    .message("Category name already exists")
                    .build());
        }

        // Nếu chưa thì tạo mới và lưu lại
        Category category = new Category();
        category.setCategoryName(categoryName);
        category.setDisabled(categoryRequestModel.isDisabled());

        categoryService.save(category);

        CategoryResponseModel categoryResponseModel = convertToCategoryResponseModel(category);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Category created successfully")
                .data(categoryResponseModel)
                .build());
    }

    @Operation(summary = "Chỉnh sửa danh mục",
            description = "Chỉnh sửa thông tin của một danh mục. Chỉ Admin có quyền thực hiện")
    @PutMapping("/{categoryId}")
    public ResponseEntity<?> updateCategory(@PathVariable int categoryId, @RequestBody CategoryRequestModel categoryRequestModel) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền chỉnh sửa danh mục hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to update category");
        }

        // Kiểm tra xem danh mục có tồn tại hay không
        Category category = categoryService.findById(categoryId).orElseThrow(() -> new RuntimeException("Category not found"));

        // Kiểm tra xem tên mới có bị trùng với bất kỳ tên nào trong database không, nếu trùng tên cũ của chính nó thì vẫn được chấp nhận
        String newCategoryName = categoryRequestModel.getCategoryName();
        boolean exists = categoryService.existsByCategoryName(newCategoryName);

        if (exists && !newCategoryName.equals(category.getCategoryName())) {
            return ResponseEntity.ok(ResponseModel
                    .builder()
                    .status(400)
                    .error(true)
                    .message("Category name already exists")
                    .build());
        }

        // Cập nhật thông tin danh mục
        category.setCategoryName(newCategoryName);
        category.setDisabled(categoryRequestModel.isDisabled());

        // Lưu lại danh mục đã chỉnh sửa
        categoryService.save(category);

        CategoryResponseModel categoryResponseModel = convertToCategoryResponseModel(category);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Category updated successfully")
                .data(categoryResponseModel)
                .build());
    }

    @Operation(summary = "Xóa danh mục",
            description = "Xóa một danh mục. Chỉ Admin có quyền thực hiện")
    @DeleteMapping("/{categoryId}")
    public ResponseEntity<?> deleteCategory(@PathVariable int categoryId) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền xóa danh mục hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to delete category");
        }

        // Kiểm tra xem danh mục có tồn tại hay không
        Category category = categoryService.findById(categoryId).orElseThrow(() -> new RuntimeException("Category not found"));

        // Xóa danh mục
        categoryService.delete(category);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Category deleted successfully")
                .build());
    }




    private CategoryResponseModel convertToCategoryResponseModel(Category category) {

        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        CategoryResponseModel categoryResponseModel = modelMapper.map(category, CategoryResponseModel.class);
        int totalUses = category.getDocuments().size();
        categoryResponseModel.setTotalUses(totalUses);

        return categoryResponseModel;
    }
}
