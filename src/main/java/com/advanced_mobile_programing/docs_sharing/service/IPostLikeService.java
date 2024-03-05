package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Post;
import com.advanced_mobile_programing.docs_sharing.entity.PostLike;
import com.advanced_mobile_programing.docs_sharing.entity.User;

import java.util.Optional;

public interface IPostLikeService {
    Optional<PostLike> findByUserAndPost(User user, Post post);

    <S extends PostLike> S save(S entity);

    void delete(PostLike entity);
}
