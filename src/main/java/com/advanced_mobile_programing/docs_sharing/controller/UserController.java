package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.Role;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.FileModel;
import com.advanced_mobile_programing.docs_sharing.model.request_model.PasswordRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.request_model.PasswordResetRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.request_model.UserProfileRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.request_model.UserRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.UserResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.IRoleService;
import com.advanced_mobile_programing.docs_sharing.service.IUserService;
import com.advanced_mobile_programing.docs_sharing.util.GoogleDriveUpload;
import com.advanced_mobile_programing.docs_sharing.util.PasswordCheck;
import io.swagger.v3.oas.annotations.Operation;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RestController
@RequestMapping("/api/v1/users")
public class UserController {
    private final IUserService userService;
    private final IRoleService roleService;
    private final GoogleDriveUpload googleDriveUpload;
    private final ModelMapper modelMapper;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserController(IUserService userService, IRoleService roleService, GoogleDriveUpload googleDriveUpload, ModelMapper modelMapper, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.roleService = roleService;
        this.googleDriveUpload = googleDriveUpload;
        this.modelMapper = modelMapper;
        this.passwordEncoder = passwordEncoder;
    }

    @Operation(summary = "Cập nhật mật khẩu",
            description = "Người dùng kiểm tra và cập nhật mật khẩu")
    @PutMapping("/password")
    public ResponseEntity<?> changePassword(@RequestBody PasswordRequestModel passwordRequestModel) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not found"));

        if (passwordEncoder.matches(passwordRequestModel.getOldPassword(), user.getPassword())) {
            if (!new PasswordCheck().validatePassword(passwordRequestModel.getNewPassword())) {
                throw new RuntimeException("Invalid password format");
            }

            if (passwordRequestModel.getNewPassword().equals(passwordRequestModel.getConfirmPassword())) {
                user.setPassword(passwordRequestModel.getNewPassword());
                user = userService.save(user);
                UserResponseModel userResponseModel = modelMapper.map(user, UserResponseModel.class);
                return ResponseEntity.ok(new ResponseModel().builder()
                        .status(200)
                        .error(false)
                        .message("Password changed successfully")
                        .data(userResponseModel)
                        .build());
            } else {
                throw new RuntimeException("Passwords not match");
            }
        } else {
            throw new RuntimeException("Password incorrect");
        }
    }

    @Operation(summary = "Khôi phục mật khẩu",
            description = "Người dùng khôi phục mật khẩu")
    @PutMapping("/password/reset")
    public ResponseEntity<?> resetPassword(@RequestBody PasswordResetRequestModel passwordResetRequestModel) {
        User user = userService.findByEmailAndIsDisabledAndIsAuthenticated(passwordResetRequestModel.getEmail(), false, true).orElseThrow(() -> new RuntimeException("User not found"));

        if (!new PasswordCheck().validatePassword(passwordResetRequestModel.getNewPassword())) {
            throw new RuntimeException("Invalid password format");
        }

        if (passwordResetRequestModel.getNewPassword().equals(passwordResetRequestModel.getConfirmPassword())) {
            user.setPassword(passwordResetRequestModel.getNewPassword());
            userService.save(user);
            return ResponseEntity.ok(new ResponseModel().builder()
                    .status(200)
                    .error(false)
                    .message("Password reset successfully")
                    .build());
        } else {
            throw new RuntimeException("Passwords not matched");
        }

    }

    @Operation(summary = "Lấy thông tin cá nhân")
    @GetMapping("/profile")
    public ResponseEntity<?> getProfile() {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not found"));
        UserResponseModel userResponseModel = convertToUserModel(user);

        return ResponseEntity.ok(ResponseModel.builder()
                .status(200)
                .error(false)
                .message("Get profile successfully")
                .data(userResponseModel)
                .build());
    }

    @Operation(summary = "Cập nhật thông tin cá nhân")
    @PutMapping("/profile")
    public ResponseEntity<?> updateProfile(@RequestBody UserProfileRequestModel userProfileRequestModel) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not found"));

        Optional<User> tempUser = userService.findByEmail(userProfileRequestModel.getEmail());
        if (tempUser.isPresent())
            if (tempUser.get().getUserId() != user.getUserId())
                throw new RuntimeException("Email already registered");

        user.setFirstName(userProfileRequestModel.getFirstName());
        user.setLastName(userProfileRequestModel.getLastName());
        user.setDateOfBirth(userProfileRequestModel.getDateOfBirth());
        user.setGender(userProfileRequestModel.getGender());
        user.setEmail(userProfileRequestModel.getEmail());

        user = userService.update(user);

        UserResponseModel userResponseModel = convertToUserModel(user);
        return ResponseEntity.ok(ResponseModel.builder()
                .status(200)
                .error(false)
                .message("Update profile successfully")
                .data(userResponseModel)
                .build());
    }

    @Operation(summary = "Cập nhật ảnh đại diện")
    @PutMapping(value = "/avatar", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> updateAvatar(@RequestPart("avatar") MultipartFile file) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not found"));

        if (user.getImage() != null) {
            FileModel gd = googleDriveUpload.uploadImage(file, getEmailUsername(user.getEmail()), getFileId(user.getImage()), "avatar");
            user.setImage(gd.getViewUrl());
        } else {
            FileModel gd = googleDriveUpload.uploadImage(file, getEmailUsername(user.getEmail()), null, "avatar");
            user.setImage(gd.getViewUrl());
        }

        user = userService.update(user);
        UserResponseModel userResponseModel = modelMapper.map(user, UserResponseModel.class);
        return ResponseEntity.ok(ResponseModel.builder()
                .status(200)
                .error(false)
                .message("Update profile successfully")
                .data(userResponseModel)
                .build());
    }

    @Operation(summary = "Tạo người dùng")
    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> createUser(@RequestPart("file") MultipartFile file,
                                        @RequestPart("user") UserRequestModel userRequestModel) {
        Optional<User> user = userService.findByEmail(userRequestModel.getEmail());
        if (user.isPresent()) {
            throw new RuntimeException("Email already registered");
        }
        User newUser = modelMapper.map(userRequestModel, User.class);

        Role role = roleService.findById(userRequestModel.getRoleId()).orElseThrow(
                () -> new RuntimeException("Role not found"));
        newUser.setRole(role);

        if (!userRequestModel.getPassword().equals(userRequestModel.getConfirmPassword())) {
            throw new RuntimeException("Password not match");
        }

        if (!new PasswordCheck().validatePassword(userRequestModel.getPassword())) {
            throw new RuntimeException("Invalid password format");
        }

        FileModel gd = googleDriveUpload.uploadImage(file, getEmailUsername(newUser.getEmail()), null, "avatar");
        newUser.setImage(gd.getViewUrl());

        newUser.setAuthenticated(true);

        newUser = userService.save(newUser);

        UserResponseModel userResponseModel = convertToUserModel(newUser);
        return ResponseEntity.ok(ResponseModel.builder()
                .status(200)
                .error(false)
                .message("Create user successfully")
                .data(userResponseModel)
                .build());
    }

    @Operation(summary = "Cập nhật người dùng")
    @PutMapping(value = "/{userId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> updateUser(@PathVariable int userId,
                                        @RequestPart(value = "file", required = false) MultipartFile file,
                                        @RequestPart(value = "user") UserRequestModel userRequestModel) {
        User user = userService.findById(userId).orElseThrow(
                () -> new RuntimeException("User not found"));

        Optional<User> tempUser = userService.findByEmail(userRequestModel.getEmail());
        if (tempUser.isPresent())
            if (tempUser.get().getUserId() != user.getUserId())
                throw new RuntimeException("Email already registered");

        user.setFirstName(userRequestModel.getFirstName());
        user.setLastName(userRequestModel.getLastName());
        user.setDateOfBirth(userRequestModel.getDateOfBirth());
        user.setGender(userRequestModel.getGender());
        user.setEmail(userRequestModel.getEmail());

        Role role = roleService.findById(userRequestModel.getRoleId()).orElseThrow(
                () -> new RuntimeException("Role not found"));
        user.setRole(role);

        if (file != null) {
            if (user.getImage() != null) {
                FileModel gd = googleDriveUpload.uploadImage(file, getEmailUsername(user.getEmail()), getFileId(user.getImage()), "avatar");
                user.setImage(gd.getViewUrl());
            } else {
                FileModel gd = googleDriveUpload.uploadImage(file, getEmailUsername(user.getEmail()), null, "avatar");
                user.setImage(gd.getViewUrl());
            }
        }

        // Password changed
        if (userRequestModel.getPassword().trim() == "") {
            user = userService.update(user);
        } else {
            if (!new PasswordCheck().validatePassword(userRequestModel.getPassword())) {
                throw new RuntimeException("Invalid password format");
            } else if (!userRequestModel.getPassword().equals(userRequestModel.getConfirmPassword())) {
                throw new RuntimeException("Passwords not match");
            } else {
                user.setPassword(userRequestModel.getPassword());
                user = userService.save(user);
            }
        }

        UserResponseModel userResponseModel = convertToUserModel(user);
        return ResponseEntity.ok(ResponseModel.builder()
                .status(200)
                .error(false)
                .message("Update user successfully")
                .data(userResponseModel)
                .build());
    }

    @Operation(summary = "Xoá người dùng")
    @DeleteMapping("/{userId}")
    public ResponseEntity<?> deleteUser(@PathVariable int userId) {
        User user = userService.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        if (user.getDocuments().size() > 0 || user.getPosts().size() > 0) {
            user.setDisabled(true);
            userService.update(user);
        } else {
            userService.deleteById(userId);
        }
        return ResponseEntity.ok(ResponseModel.builder()
                .status(200)
                .error(false)
                .message("Delete user successfully")
                .build());
    }

    @Operation(summary = "Lấy danh sách người dùng")
    @GetMapping("/all")
    public ResponseEntity<?> getAllUsers(@RequestParam(defaultValue = "0") int page,
                                         @RequestParam(defaultValue = "10") int size) {
//        @RequestParam(defaultValue = "newest") String order
//        @RequestParam(defaultValue = "") String query,
//        @RequestParam(defaultValue = "") Integer gender,
//        @RequestParam(defaultValue = "") Boolean disabled,
//        @RequestParam(defaultValue = "") Boolean authenticated,
//        @RequestParam(defaultValue = "") Integer role
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<User> users = userService.findAll(pageable);

        Page<UserResponseModel> userResponseModels = users.map(this::convertToUserModel);

        return ResponseEntity.ok(ResponseModel.builder()
                .status(200)
                .error(false)
                .message("Get user list successfully")
                .data(userResponseModels)
                .build());
    }

    public String getEmailUsername(String email) {
        return email.split("@")[0];

    }

    public String getFileId(String url) {
        String regex = "=([^&]+)";
        Pattern pattern = Pattern.compile(regex);

        Matcher matcher = pattern.matcher(url);

        if (matcher.find()) {
            String fileId = matcher.group(1);
            return fileId;
        } else {
            return null;
        }
    }

    public UserResponseModel convertToUserModel(User user) {
        UserResponseModel userResponseModel = modelMapper.map(user, UserResponseModel.class);

        int totalPosts = user.getPosts().size();
        int totalDocuments = user.getDocuments().size();
        int totalPostLikes = user.getPostLikes().size();
        int totalDocumentLikes = user.getDocumentLikes().size();
        int totalComments = user.getComments().size();

        userResponseModel.setTotalPosts(totalPosts);
        userResponseModel.setTotalDocuments(totalDocuments);
        userResponseModel.setTotalPostLikes(totalPostLikes);
        userResponseModel.setTotalDocumentLikes(totalDocumentLikes);
        userResponseModel.setTotalComments(totalComments);

        return userResponseModel;
    }
}
