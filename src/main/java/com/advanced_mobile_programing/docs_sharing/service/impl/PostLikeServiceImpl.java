package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Post;
import com.advanced_mobile_programing.docs_sharing.entity.PostLike;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.repository.IPostLikeRepository;
import com.advanced_mobile_programing.docs_sharing.service.IPostLikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class PostLikeServiceImpl implements IPostLikeService {
    private final IPostLikeRepository postLikeRepository;

    @Autowired
    public PostLikeServiceImpl(IPostLikeRepository postLikeRepository) {
        this.postLikeRepository = postLikeRepository;
    }

    @Override
    public Optional<PostLike> findByUserAndPost(User user, Post post) {
        return postLikeRepository.findByUserAndPost(user, post);
    }

    @Override
    public <S extends PostLike> S save(S entity) {
        return postLikeRepository.save(entity);
    }

    @Override
    public void delete(PostLike entity) {
        postLikeRepository.delete(entity);
    }
}
