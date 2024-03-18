package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Comment;
import com.advanced_mobile_programing.docs_sharing.entity.CommentLike;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.repository.ICommentLikeRepository;
import com.advanced_mobile_programing.docs_sharing.service.ICommentLikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CommentLikeServiceImpl implements ICommentLikeService {
    private final ICommentLikeRepository commentLikeRepository;

    @Autowired
    public CommentLikeServiceImpl(ICommentLikeRepository commentLikeRepository) {
        this.commentLikeRepository = commentLikeRepository;
    }

    @Override
    public Optional<CommentLike> findByUserAndComment(User user, Comment comment) {
        return commentLikeRepository.findByUserAndComment(user, comment);
    }
}
