package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.Comment;
import com.advanced_mobile_programing.docs_sharing.entity.CommentLike;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.entity.UserComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ICommentLikeRepository extends JpaRepository<CommentLike, UserComment> {

    Optional<CommentLike> findByUserAndComment(User user, Comment comment);
}
