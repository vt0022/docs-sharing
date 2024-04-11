package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.*;
import com.advanced_mobile_programing.docs_sharing.model.request_model.CommentRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.CommentResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.*;
import io.swagger.v3.oas.annotations.Operation;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RequestMapping("/api/v1/comment")
@RestController
public class CommentController {
    private final ICommentService commentService;
    private final ModelMapper modelMapper;
    private final IUserService userService;
    private final IPostService postService;
    private final ICommentLikeService commentLikeService;
    private final INotificationService notificationService;

    @Autowired
    public CommentController(ICommentService commentService, ModelMapper modelMapper,
                             IUserService userService, IPostService postService,
                             ICommentLikeService commentLikeService, INotificationService notificationService) {
        this.commentService = commentService;
        this.modelMapper = modelMapper;
        this.userService = userService;
        this.postService = postService;
        this.commentLikeService = commentLikeService;
        this.notificationService = notificationService;
    }

    @Operation(summary = "Xem danh sách bình luận",
            description = "Trả về danh sách tất cả bình luận")
    @GetMapping("/all")
    public ResponseEntity<?> getAllComments(@RequestParam(defaultValue = "0") int page,
                                            @RequestParam(defaultValue = "10") int size) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<Comment> comments = commentService.findAll(pageable);
        Page<CommentResponseModel> commentResponseModels = comments.map(this::convertToCommentResponseModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get all comments successfully")
                .data(commentResponseModels)
                .build());
    }

    @Operation(summary = "Lấy 1 bình luận theo ID",
            description = "Trả về 1 bình luận dựa trên id đã cung cấp.")
    @GetMapping("/{commentId}")
    public ResponseEntity<?> getCommentById(@PathVariable int commentId) {
        Comment comment = commentService.findById(commentId).orElseThrow(() -> new RuntimeException("Comment not found"));

        CommentResponseModel commentResponse = convertToCommentResponseModel(comment);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get comment successfully")
                .data(commentResponse)
                .build());
    }

    @Operation(summary = "Lấy những bình luận của một bài đăng cụ thể",
            description = "Trả về tất cả những bình luận cho một bài đăng cụ thể theo id được cung cấp.")
    @GetMapping("/posts/{postId}")
    public ResponseEntity<?> getCommentsByPostId(@PathVariable int postId,
                                                 @RequestParam(defaultValue = "0") int page,
                                                 @RequestParam(defaultValue = "10") int size) {
        Post post = postService.findById(postId).orElseThrow(() -> new RuntimeException("Post not found"));
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<Comment> comments = commentService.findAllByPost(post, pageable);

        Page<CommentResponseModel> commentResponseModels = comments.map(this::convertToCommentResponseModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get comments by post id successfully")
                .data(commentResponseModels)
                .build());
    }


    @Operation(summary = "Thêm một bình luận mới",
            description = "Cho phép người dùng thêm một bình luận/ phản hồi mới")
    @PostMapping
    public ResponseEntity<?> createComment(@RequestParam(required = false) Integer parentCommentId,
                                           @RequestBody CommentRequestModel commentRequest) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Post post = postService.findById(commentRequest.getPostId()).orElseThrow(() -> new RuntimeException("Post not found"));

        Comment parentComment = null;
        if (parentCommentId != null) {
            Optional<Comment> optionalParentComment = commentService.findById(parentCommentId);
            if (optionalParentComment.isPresent()) {
                parentComment = optionalParentComment.get();
            }
        }

        //nếu là null thì có nghĩa là bình luận gốc của post

        Comment comment = new Comment();
        comment.setPost(post);
        comment.setUser(user);
        comment.setParentComment(parentComment);
        comment.setContent(commentRequest.getContent());
        // createAt và UpdateAt được thêm tự động khi save

        commentService.save(comment);
        CommentResponseModel commentResponse = convertToCommentResponseModel(comment);

        Notification notification = new Notification();
        notification.setType("POST_COMMENT");
        notification.setReferredId(post.getPostId());
        notification.setUserReceived(post.getUser());
        notification.setUserTriggered(user);
        notification = notificationService.save(notification);
        notificationService.notifyUser(post.getUser().getEmail(), notification);

        return ResponseEntity.status(HttpStatus.CREATED).body(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Comment created successfully")
                .data(commentResponse)
                .build());
    }

    @Operation(summary = "Xóa một bình luận",
            description = "Cho phép người dùng xóa một bình luận/ phản hồi của mình. Admin có quyền xóa bất kỳ bình luận/ phản hồi nào")
    @DeleteMapping("/{commentId}")
    public ResponseEntity<?> deleteComment(@PathVariable int commentId) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Comment comment = commentService.findById(commentId).orElseThrow(() -> new RuntimeException("Comment not found"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền xóa bài viết hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1 || comment.getUser().equals(loggedInUser)))) {
            throw new RuntimeException("You don't have permission to delete this comment");
        }

        commentService.delete(commentId);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Comment deleted successfully")
                .build());
    }

    @Operation(summary = "Chỉnh sửa bình luận",
            description = "Cho phép người dùng chỉnh sửa bình luận/ phản hồi của họ.")
    @PutMapping("/{commentId}")
    public ResponseEntity<?> updateComment(@PathVariable int commentId, @RequestBody CommentRequestModel commentRequest) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Comment comment = commentService.findById(commentId).orElseThrow(() -> new RuntimeException("Comment not found"));

        // Kiểm tra xem người dùng có quyền chỉnh sửa bình luận này không
        if (!(comment.getUser().equals(user))) {
            throw new RuntimeException("You don't have permission to update this comment");
        }

        // Cập nhật thông tin bình luận
        comment.setContent(commentRequest.getContent());

        commentService.save(comment);
        CommentResponseModel commentResponse = convertToCommentResponseModel(comment);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Comment updated successfully")
                .data(commentResponse)
                .build());
    }

    @Operation(summary = "Thích bình luận",
            description = "Nhấn thích/bỏ thích một bình luận")
    @GetMapping("/{commentId}/like")
    public ResponseEntity<?> likeComment(@PathVariable int commentId) {
        Comment comment = commentService.findById(commentId).orElseThrow(() -> new RuntimeException("Comment not found"));
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        boolean isLiked = false;

        Optional<CommentLike> commentLike = commentLikeService.findByUserAndComment(user, comment);
        if (commentLike.isPresent()) {
            // Bỏ thích
            commentLikeService.delete(commentLike.get());
            isLiked = true;
        } else {
            CommentLike newCommentLike = new CommentLike();
            newCommentLike.setUser(user);
            newCommentLike.setComment(comment);
            commentLikeService.save(newCommentLike);

            Notification notification = new Notification();
            notification.setType("DOC_LIKE");
            notification.setReferredId(comment.getPost().getPostId());
            notification.setUserReceived(comment.getUser());
            notification.setUserTriggered(user);
            notification = notificationService.save(notification);
            notificationService.notifyUser(comment.getUser().getEmail(), notification);
        }

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message((isLiked ? "Unlike" : "Like") + " comment successfully")
                .build());
    }

    private CommentResponseModel convertToCommentResponseModel(Comment comment) {
        CommentResponseModel commentResponseModel = modelMapper.map(comment, CommentResponseModel.class);

        // Tính toán tổng số lượt thích cho comment
        int totalLikes = comment.getCommentLikes().size();
        commentResponseModel.setTotalLikes(totalLikes);

        // Tính toán tổng số bình luận con của comment (đệ quy)
        int totalResponses = comment.getChildComments().size();
        commentResponseModel.setTotalResponses(totalResponses);

        // Kiểm tra xem người dùng hiện tại đã bình luận cho comment hay chưa
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        boolean isCommented = comment.getUser().equals(user);
        commentResponseModel.setCommented(isCommented);

        // Kiểm tra xem người dùng hiện tại đã thích comment hay không
        boolean isLiked = commentLikeService.findByUserAndComment(user, comment).isPresent();
        commentResponseModel.setLiked(isLiked);

        // Map các comment con (đệ quy)
        List<CommentResponseModel> childCommentResponseModels = new ArrayList<>();
        for (Comment childComment : comment.getChildComments()) {
            CommentResponseModel childCommentResponseModel = convertToCommentResponseModel(childComment);
            childCommentResponseModels.add(childCommentResponseModel);
        }
        commentResponseModel.setChildComments(childCommentResponseModels);

        return commentResponseModel;
    }
}
