package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Comment;
import com.advanced_mobile_programing.docs_sharing.entity.Post;
import com.advanced_mobile_programing.docs_sharing.repository.ICommentRepository;
import com.advanced_mobile_programing.docs_sharing.service.ICommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CommentServiceImpl implements ICommentService {
    private final ICommentRepository commentRepository;

    @Autowired
    public CommentServiceImpl(ICommentRepository commentRepository) {
        this.commentRepository = commentRepository;
    }

    @Override
    public Page<Comment> findAll(Pageable pageable) {
        return commentRepository.findAll(pageable);
    }

    @Override
    public Optional<Comment> findById(Integer id) {
        return commentRepository.findById(id);
    }

    @Override
    public void save(Comment comment) {
        commentRepository.save(comment);
    }

    @Override
    public void delete(int commentId) {
        commentRepository.deleteById(commentId);
    }

    @Override
    public Page<Comment> findAllByPost(Post post, Pageable pageable) {
        return commentRepository.findAllByPostAndParentCommentIsNullOrderByCreatedAtAsc(post, pageable);
    }
}
