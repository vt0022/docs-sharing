package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Comment;
import com.advanced_mobile_programing.docs_sharing.entity.Post;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface ICommentService {
    Page<Comment> findAll(Pageable pageable);

    Optional<Comment> findById(Integer id);

    void save(Comment comment);

    void delete(int commentId);

    Page<Comment> findAllByPost(Post post, Pageable pageable);
}
