package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.Comment;
import com.advanced_mobile_programing.docs_sharing.entity.Post;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.request_model.CommentRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.CommentResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.ICommentLikeService;
import com.advanced_mobile_programing.docs_sharing.service.ICommentService;
import com.advanced_mobile_programing.docs_sharing.service.IPostService;
import com.advanced_mobile_programing.docs_sharing.service.IUserService;
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

import java.util.Optional;

@RequestMapping("/api/v1/comment")
@RestController
public class CommentController {
    private final ICommentService commentService;
    private final ModelMapper modelMapper;
    private final IUserService userService;
    private final IPostService postService;
    private final ICommentLikeService commentLikeService;

    @Autowired
    public CommentController(ICommentService commentService, ModelMapper modelMapper,
                             IUserService userService, IPostService postService,
                             ICommentLikeService commentLikeService) {
        this.commentService = commentService;
        this.modelMapper = modelMapper;
        this.userService = userService;
        this.postService = postService;
        this.commentLikeService = commentLikeService;
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
        if (parentCommentId != null){
            Optional<Comment> optionalParentComment = commentService.findById(parentCommentId);
            if(optionalParentComment.isPresent()){
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

    private CommentResponseModel convertToCommentResponseModel(Comment comment) {
        CommentResponseModel commentResponseModel = modelMapper.map(comment, CommentResponseModel.class);

        int totalResponses = comment.getChildComments().size();
        commentResponseModel.setTotalResponses(totalResponses);

        int totalLikes = comment.getCommentLikes().size();
        commentResponseModel.setTotalLikes(totalLikes);

        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        boolean isCommented = comment.getUser().equals(user);
        commentResponseModel.setCommented(isCommented);

        boolean isLiked = commentLikeService.findByUserAndComment(user, comment).isPresent();
        commentResponseModel.setLiked(isLiked);

        return commentResponseModel;
    }

}
