package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.Category;
import com.advanced_mobile_programing.docs_sharing.entity.Tag;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.request_model.CategoryRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.request_model.TagRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.CategoryResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.TagResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.ICategoryService;
import com.advanced_mobile_programing.docs_sharing.service.ITagService;
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

@RequestMapping("/api/v1/tag")
@RestController
public class TagController {
    private final ITagService tagService;
    private final IUserService userService;
    private final ModelMapper modelMapper;

    @Autowired
    public TagController(ITagService tagService, IUserService userService, ModelMapper modelMapper) {
        this.tagService = tagService;
        this.userService = userService;
        this.modelMapper = modelMapper;
    }

    @Operation(summary = "Xem danh sách thẻ",
            description = "Trả về danh sách tất cả thẻ")
    @GetMapping("/all")
    public ResponseEntity<?> getAllTags(@RequestParam(defaultValue = "0") int page,
                                              @RequestParam(defaultValue = "10") int size) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<Tag> tags = tagService.findAll(pageable);
        Page<TagResponseModel> tagResponseModels = tags.map(this::convertToTagResponseModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get all tags successfully")
                .data(tagResponseModels)
                .build());
    }

    @Operation(summary = "Xem 1 thẻ cụ thể",
            description = "Xem 1 thẻ cụ thể")
    @GetMapping("/{tagId}")
    public ResponseEntity<?> getTag(@PathVariable int tagId) {
        Tag tag = tagService.findById(tagId).orElseThrow(() -> new RuntimeException("Tag not found"));
        TagResponseModel tagResponseModel = convertToTagResponseModel(tag);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .data(tagResponseModel)
                .build());
    }

    @Operation(summary = "Tìm kiếm thẻ",
            description = "Trả về danh sách tất cả thẻ tìm được kèm với sắp xếp (newest, oldest, mostUses)")
    @GetMapping("/search")
    public ResponseEntity<?> searchTag(@RequestParam(defaultValue = "0") int page,
                                            @RequestParam(defaultValue = "10") int size,
                                            @RequestParam(defaultValue = "") String q,
                                            @RequestParam(defaultValue = "newest") String order) {
        // Order can be newest, mostUses, oldest
        Pageable pageable = PageRequest.of(page, size);

        Page<Tag> tags = tagService.searchAll(q, order, pageable);
        Page<TagResponseModel> tagResponseModels = tags.map(this::convertToTagResponseModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Search all tag successfully")
                .data(tagResponseModels)
                .build());
    }

    @Operation(summary = "Thêm thẻ mới",
            description = "Thêm thẻ mới. Chỉ Admin có quyền thực hiện")
    @PostMapping("/create")
    public ResponseEntity<?> createTag(@RequestBody TagRequestModel tagRequestModel) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền thêm thẻ hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to create tag");
        }

        // Kiểm tra xem name của tag mới có trong database chưa
        String name = tagRequestModel.getName();
        boolean exists = tagService.existsByName(name);

        if (exists) {
            return ResponseEntity.ok(ResponseModel
                    .builder()
                    .status(400)
                    .error(true)
                    .message("Tag name already exists")
                    .build());
        }

        // Nếu chưa thì tạo mới và lưu lại
        Tag tag = new Tag();
        tag.setName(name);

        tagService.save(tag);

        TagResponseModel tagResponseModel = convertToTagResponseModel(tag);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Tag created successfully")
                .data(tagResponseModel)
                .build());
    }

    @Operation(summary = "Chỉnh sửa thẻ",
            description = "Chỉnh sửa thông tin của một thẻ. Chỉ Admin có quyền thực hiện")
    @PutMapping("/{tagId}")
    public ResponseEntity<?> updateTag(@PathVariable int tagId, @RequestBody TagRequestModel tagRequestModel) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền chỉnh sửa thẻ hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to update tag");
        }

        // Kiểm tra xem thẻ có tồn tại hay không
        Tag tag = tagService.findById(tagId).orElseThrow(() -> new RuntimeException("Tag not found"));

        // Kiểm tra xem tên mới có bị trùng với bất kỳ tên nào trong database không, nếu trùng tên cũ của chính nó thì vẫn được chấp nhận
        String newTagName = tagRequestModel.getName();
        boolean exists = tagService.existsByName(newTagName);

        if (exists && !newTagName.equals(tag.getName())) {
            return ResponseEntity.ok(ResponseModel
                    .builder()
                    .status(400)
                    .error(true)
                    .message("Tag name already exists")
                    .build());
        }

        // Cập nhật thông tin thẻ
        tag.setName(newTagName);

        // Lưu lại thẻ đã chỉnh sửa
        tagService.save(tag);

        TagResponseModel tagResponseModel = convertToTagResponseModel(tag);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Tag updated successfully")
                .data(tagResponseModel)
                .build());
    }

    @Operation(summary = "Xóa thẻ",
            description = "Xóa một thẻ. Chỉ Admin có quyền thực hiện")
    @DeleteMapping("/{tagId}")
    public ResponseEntity<?> deleteTag(@PathVariable int tagId) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền xóa thẻ hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1))) {
            throw new RuntimeException("You don't have permission to delete tag");
        }

        // Kiểm tra xem thẻ có tồn tại hay không
        Tag tag = tagService.findById(tagId).orElseThrow(() -> new RuntimeException("Tag not found"));

        // Xóa thẻ
        tagService.delete(tag);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Tag deleted successfully")
                .build());
    }

    private TagResponseModel convertToTagResponseModel(Tag tag) {

        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        TagResponseModel tagResponseModel = modelMapper.map(tag, TagResponseModel.class);
        int totalUses = tag.getPosts().size();
        tagResponseModel.setTotalUses(totalUses);

        return tagResponseModel;
    }
}
