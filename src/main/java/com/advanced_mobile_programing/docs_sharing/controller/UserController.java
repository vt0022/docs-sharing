package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.request_model.PasswordRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.request_model.PasswordResetRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.UserResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.IRoleService;
import com.advanced_mobile_programing.docs_sharing.service.IUserService;
import com.advanced_mobile_programing.docs_sharing.util.PasswordCheck;
import com.advanced_mobile_programing.docs_sharing.util.StringHandler;
import io.swagger.v3.oas.annotations.Operation;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users")
public class UserController {
    private final IUserService userService;
    private final IRoleService roleService;
    private final ModelMapper modelMapper;
    private final PasswordEncoder passwordEncoder;
    private final StringHandler stringHandler;

    @Autowired
    public UserController(IUserService userService, IRoleService roleService, ModelMapper modelMapper, PasswordEncoder passwordEncoder, StringHandler stringHandler) {
        this.userService = userService;
        this.roleService = roleService;
        this.modelMapper = modelMapper;
        this.passwordEncoder = passwordEncoder;
        this.stringHandler = stringHandler;
    }

    @Operation(summary = "Cập nhật mật khẩu",
            description = "Người dùng kiểm tra và cập nhật mật khẩu")
    @PutMapping("/password")
    public ResponseEntity<?> changePassword(@RequestBody PasswordRequestModel passwordRequestModel) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not found"));

        if (passwordEncoder.matches(passwordRequestModel.getOldPassword(), user.getPassword())) {
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
        User user = userService.findByEmailAndIsDisabled(passwordResetRequestModel.getEmail(), false).orElseThrow(() -> new RuntimeException("User not found"));

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

}
