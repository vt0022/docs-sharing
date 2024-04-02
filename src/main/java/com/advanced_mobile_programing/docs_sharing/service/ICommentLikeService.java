package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Comment;
import com.advanced_mobile_programing.docs_sharing.entity.CommentLike;
import com.advanced_mobile_programing.docs_sharing.entity.User;

import java.util.Optional;

public interface ICommentLikeService {
    Optional<CommentLike> findByUserAndComment(User user, Comment comment);

    void delete(CommentLike entity);

    <S extends CommentLike> S save(S entity);
}
