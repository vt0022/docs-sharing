package com.advanced_mobile_programing.docs_sharing.controller;

import com.advanced_mobile_programing.docs_sharing.entity.Post;
import com.advanced_mobile_programing.docs_sharing.entity.PostLike;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.request_model.PostRequestModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.PostResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.ResponseModel;
import com.advanced_mobile_programing.docs_sharing.service.IPostLikeService;
import com.advanced_mobile_programing.docs_sharing.service.IPostService;
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

import java.util.Optional;

@RequestMapping("/api/v1/post")
@RestController
public class PostController {
    private final IPostService postService;
    private final IPostLikeService postLikeService;
    private IUserService userService;
    private final ModelMapper modelMapper;

    @Autowired
    public PostController(IPostService postService, IPostLikeService postLikeService, IUserService userService, ModelMapper modelMapper) {
        this.postService = postService;
        this.postLikeService = postLikeService;
        this.userService = userService;
        this.modelMapper = modelMapper;
    }

    @Operation(summary = "Xem danh sách bài đăng",
            description = "Trả về danh sách tất cả bài đăng")
    @GetMapping("/all")
    public ResponseEntity<?> getAllPost(@RequestParam(defaultValue = "0") int page,
                                        @RequestParam(defaultValue = "10") int size) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<Post> posts = postService.findAll(pageable);
        Page<PostResponseModel> postResponseModels = posts.map(this::convertToDocumentModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Get all post successfully")
                .data(postResponseModels)
                .build());
    }

    @Operation(summary = "Tìm kiếm bài đăng",
            description = "Trả về danh sách tất cả bài đăng tìm được kèm với sắp xếp")
    @GetMapping("/search")
    public ResponseEntity<?> searchPost(@RequestParam(defaultValue = "0") int page,
                                        @RequestParam(defaultValue = "10") int size,
                                        @RequestParam(defaultValue = "") String q,
                                        @RequestParam(defaultValue = "newest") String order) {
        // Order can be newest, mostLikes
        Pageable pageable = PageRequest.of(page, size);

        Page<Post> posts = postService.searchAll(order, q, pageable);
        Page<PostResponseModel> postResponseModels = posts.map(this::convertToDocumentModel);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Search all post successfully")
                .data(postResponseModels)
                .build());
    }

    @Operation(summary = "Thích bài đăng",
            description = "Nhấn thích/bỏ thích một bài đăng")
    @GetMapping("/{postId}/like")
    public ResponseEntity<?> likePost(@PathVariable int postId) {
        Post post = postService.findById(postId).orElseThrow(() -> new RuntimeException("Post not found for post"));
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        boolean isLiked = false;

        Optional<PostLike> postLike = postLikeService.findByUserAndPost(user, post);
        if (postLike.isPresent()) {
            // Bỏ thích
            postLikeService.delete(postLike.get());
            isLiked = true;
        } else {
            PostLike like = new PostLike();
            like.setUser(user);
            like.setPost(post);
            postLikeService.save(like);
        }

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message(isLiked ? "Unlike" : "Like" + " post successfully")
                .build());
    }

    @Operation(summary = "Xem 1 bài đăng cụ thể",
            description = "Xem 1 bài đăng cụ thể")
    @GetMapping("/{postId}")
    public ResponseEntity<?> getPost(@PathVariable int postId) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        Post post = postService.findById(postId).orElseThrow(() -> new RuntimeException("Post not found"));

        PostResponseModel postResponseModels = convertToDocumentModel(post);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .data(postResponseModels)
                .build());
    }

    @Operation(summary = "Đăng bài viết mới",
            description = "Tạo một bài viết mới")
    @PostMapping("/create")
    public ResponseEntity<?> createPost(@RequestBody PostRequestModel postRequestModel) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));

        Post post = new Post();
        post.setTitle(postRequestModel.getTitle());
        post.setContent(postRequestModel.getContent());
        post.setUser(user);

        postService.save(post);

        PostResponseModel postResponseModels = convertToDocumentModel(post);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Post created successfully")
                .data(postResponseModels)
                .build());
    }

    @Operation(summary = "Chỉnh sửa bài đăng",
            description = "Người dùng chỉ có quyền chỉnh sửa bài đăng của mình")
    @PutMapping("/{postId}")
    public ResponseEntity<?> updatePost(@PathVariable int postId, @RequestBody PostRequestModel postRequestModel) {
        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Post post = postService.findById(postId).orElseThrow(() -> new RuntimeException("Post not found"));

        // Kiểm tra xem người dùng có quyền chỉnh sửa bài đăng hay không
        if (!(post.getUser().equals(user))) {
            throw new RuntimeException("You don't have permission to update this post");
        }

        // Cập nhật thông tin bài đăng
        post.setTitle(postRequestModel.getTitle());
        post.setContent(postRequestModel.getContent());
        postService.save(post);

        PostResponseModel postResponseModels = convertToDocumentModel(post);

        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Post updated successfully")
                .data(postResponseModels)
                .build());
    }


    @Operation(summary = "Xóa bài đăng",
            description = "Người dùng chỉ có quyền xóa bài đăng của mình. Admin có quyền xóa bất kỳ bài đăng nào.")
    @DeleteMapping("/{postId}")
    public ResponseEntity<?> deletePost(@PathVariable int postId) {
        User loggedInUser = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        Post post = postService.findById(postId).orElseThrow(() -> new RuntimeException("Post not found"));

        // Kiểm tra xem người dùng đã đăng nhập và có quyền xóa bài viết hay không
        if (!(loggedInUser != null && (loggedInUser.getRole().getId() == 1 || post.getUser().equals(loggedInUser)))) {
            throw new RuntimeException("You don't have permission to delete this post");
        }

        // Xóa bài viết nếu người dùng đã đăng nhập và có quyền xóa bài viết
        postService.delete(postId);
        return ResponseEntity.ok(ResponseModel
                .builder()
                .status(200)
                .error(false)
                .message("Post deleted successfully")
                .build());
    }

    private PostResponseModel convertToDocumentModel(Post post) {
        PostResponseModel postResponseModel = modelMapper.map(post, PostResponseModel.class);

        int totalLikes = post.getPostLikes().size();
        int totalComments = post.getComments().size();
        postResponseModel.setTotalLikes(totalLikes);
        postResponseModel.setTotalComments(totalComments);

        User user = userService.findLoggedInUser().orElseThrow(() -> new RuntimeException("User not logged in"));
        boolean isLiked = postLikeService.findByUserAndPost(user, post).isPresent() ? true : false;
        postResponseModel.setLiked(isLiked);

        return postResponseModel;
    }
}
