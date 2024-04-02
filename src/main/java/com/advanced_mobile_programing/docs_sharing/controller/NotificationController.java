package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.Notification;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.request_model.NotificationRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.NotificationResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.*;
import io.swagger.v3.oas.annotations.Operation;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@RestController
@RequestMapping("/api/v1/notifications")
public class NotificationController {
    private final INotificationService notificationService;
    private final IPostService postService;
    private final ICommentService commentService;
    private final IDocumentService documentService;
    private final IUserService userService;
    private final ModelMapper modelMapper;

    @Autowired
    public NotificationController(INotificationService notificationService, IPostService postService, ICommentService commentService, IDocumentService documentService, IUserService userService, ModelMapper modelMapper) {
        this.notificationService = notificationService;
        this.postService = postService;
        this.commentService = commentService;
        this.documentService = documentService;
        this.userService = userService;
        this.modelMapper = modelMapper;
    }

    @MessageMapping("/notify/send-user")
    @SendToUser("/notify/send-back-user")
    public ResponseEntity<?> getPrivateMessage(NotificationRequestModel notificationRequestModel, Principal principal) throws InterruptedException {
        Thread.sleep(1000);
        notificationService.sendPrivateNotification(principal.getName());
        return ResponseEntity.ok().build(); // trả về fe
    }

    @PostMapping("/notify/{userId}")
    public ResponseEntity<?> sendNotification(@PathVariable int userId, @RequestBody NotificationRequestModel notificationRequestModel) {
        User user = userService.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        User userTriggered = userService.findById(notificationRequestModel.getUserTriggeredId()).orElseThrow(() -> new RuntimeException("User not found"));

        Notification notification = new Notification();
        notification.setUserTriggered(userTriggered);
        notification.setUserReceived(user);
        notification.setReferredId(notificationRequestModel.getReferredId());
        notification.setType(notificationRequestModel.getType());
        notification = notificationService.save(notification);

        NotificationResponseModel notificationResponseModel = modelMapper.map(notificationRequestModel, NotificationResponseModel.class);
        notificationService.notifyUser(user.getEmail(), notification);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Send notification successfully")
                .data(notificationResponseModel)
                .build());
    }

    @Operation(summary = "Trả về danh sách thông báo, trong đó referredId là id của post, doc hoặc comment liên quan")
    @GetMapping
    public ResponseEntity<?> getNotification(@RequestParam(defaultValue = "0") int page,
                                             @RequestParam(defaultValue = "10") int size) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        Pageable pageable = PageRequest.of(page, size);
        Page<Notification> notifications = notificationService.findAllByUserReceived(user, pageable);
        Page<NotificationResponseModel> responses = notifications.map(this::convertToNotificationResponseModel);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get notification successfully")
                .data(responses)
                .build());
    }

    private NotificationResponseModel convertToNotificationResponseModel(Notification notification) {
        NotificationResponseModel notificationResponseModel = modelMapper.map(notification, NotificationResponseModel.class);
        return notificationResponseModel;
    }
}
