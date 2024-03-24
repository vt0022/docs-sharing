package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.Field;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.request_model.FieldRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.FieldResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.IFieldService;
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

@RequestMapping("/api/v1/field")
@RestController
public class FieldController {
    private final IFieldService fieldService;
    private final IUserService userService;
    private final ModelMapper modelMapper;

    @Autowired
    public FieldController(IFieldService fieldService, IUserService userService, ModelMapper modelMapper) {
        this.fieldService = fieldService;
        this.userService = userService;
        this.modelMapper = modelMapper;
    }

    @Operation(summary = "Xem danh sách lĩnh vực",
            description = "Trả về danh sách tất cả lĩnh vực")
    @GetMapping("/all")
    public ResponseEntity<?> getAllFields(@RequestParam(defaultValue = "0") int page,
                                              @RequestParam(defaultValue = "10") int size) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<Field> fields = fieldService.findAll(pageable);
        Page<FieldResponseModel> fieldResponseModels = fields.map(this::convertToFieldResponseModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get all fields successfully")
                .data(fieldResponseModels)
                .build());
    }

    @Operation(summary = "Xem 1 lĩnh vực cụ thể",
            description = "Xem 1 lĩnh vực cụ thể")
    @GetMapping("/{fieldId}")
    public ResponseEntity<?> getField(@PathVariable int fieldId) {
        Field field = fieldService.findById(fieldId).orElseThrow(() -> new RuntimeException("Field not found"));
        FieldResponseModel fieldResponseModel = convertToFieldResponseModel(field);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .data(fieldResponseModel)
                .build());
    }

    @Operation(summary = "Tìm kiếm lĩnh vực",
            description = "Trả về danh sách tất cả lĩnh vực tìm được kèm với sắp xếp (newest, oldest, mostUses)")
    @GetMapping("/search")
    public ResponseEntity<?> searchField(@RequestParam(defaultValue = "0") int page,
                                            @RequestParam(defaultValue = "10") int size,
                                            @RequestParam(defaultValue = "") String q,
                                            @RequestParam(defaultValue = "newest") String order) {
        // Order can be newest, mostUses, oldest
        Pageable pageable = PageRequest.of(page, size);

        Page<Field> fields = fieldService.searchAll(q, order, pageable);
        Page<FieldResponseModel> fieldResponseModels = fields.map(this::convertToFieldResponseModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Search all fields successfully")
                .data(fieldResponseModels)
                .build());
    }

    @Operation(summary = "Thêm lĩnh vực mới",
            description = "Thêm lĩnh vực mới. Chỉ Admin có quyền thực hiện")
    @PostMapping("/create")
    public ResponseEntity<?> createField(@RequestBody FieldRequestModel fieldRequestModel) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền thêm lĩnh vực hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to create field");
        }

        // Kiểm tra xem name của field mới có trong database chưa
        String fieldName = fieldRequestModel.getFieldName();
        boolean exists = fieldService.existsByFieldName(fieldName);

        if (exists) {
            return ResponseEntity.ok(ResponseModel
                    .builder()
                    .status(400)
                    .error(true)
                    .message("Field name already exists")
                    .build());
        }

        // Nếu chưa thì tạo mới và lưu lại
        Field field = new Field();
        field.setFieldName(fieldName);
        field.setDisabled(fieldRequestModel.isDisabled());

        fieldService.save(field);

        FieldResponseModel fieldResponseModel = convertToFieldResponseModel(field);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Field created successfully")
                .data(fieldResponseModel)
                .build());
    }

    @Operation(summary = "Chỉnh sửa lĩnh vực",
            description = "Chỉnh sửa thông tin của một lĩnh vực. Chỉ Admin có quyền thực hiện")
    @PutMapping("/{fieldId}")
    public ResponseEntity<?> updateField(@PathVariable int fieldId, @RequestBody FieldRequestModel fieldRequestModel) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền chỉnh sửa lĩnh vực hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to update field");
        }

        // Kiểm tra xem lĩnh vực có tồn tại hay không
        Field field = fieldService.findById(fieldId).orElseThrow(() -> new RuntimeException("Field not found"));

        // Kiểm tra xem tên mới có bị trùng với bất kỳ tên nào trong database không, nếu trùng tên cũ của chính nó thì vẫn được chấp nhận
        String newFieldName = fieldRequestModel.getFieldName();
        boolean exists = fieldService.existsByFieldName(newFieldName);

        if (exists && !newFieldName.equals(field.getFieldName())) {
            return ResponseEntity.ok(ResponseModel
                    .builder()
                    .status(400)
                    .error(true)
                    .message("Field name already exists")
                    .build());
        }

        // Cập nhật thông tin lĩnh vực
        field.setFieldName(newFieldName);
        field.setDisabled(fieldRequestModel.isDisabled());

        // Lưu lại lĩnh vực đã chỉnh sửa
        fieldService.save(field);

        FieldResponseModel fieldResponseModel = convertToFieldResponseModel(field);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Field updated successfully")
                .data(fieldResponseModel)
                .build());
    }

    @Operation(summary = "Xóa lĩnh vực",
            description = "Xóa một lĩnh vực. Chỉ Admin có quyền thực hiện")
    @DeleteMapping("/{fieldId}")
    public ResponseEntity<?> deleteField(@PathVariable int fieldId) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền xóa lĩnh vực hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to delete field");
        }

        // Kiểm tra xem lĩnh vực có tồn tại hay không
        Field field = fieldService.findById(fieldId).orElseThrow(() -> new RuntimeException("Field not found"));

        // Xóa lĩnh vực
        fieldService.delete(field);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Field deleted successfully")
                .build());
    }

    private FieldResponseModel convertToFieldResponseModel(Field field) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        FieldResponseModel fieldResponseModel = modelMapper.map(field, FieldResponseModel.class);
        int totalUses = field.getDocuments().size();
        fieldResponseModel.setTotalUses(totalUses);

        return fieldResponseModel;
    }
}
