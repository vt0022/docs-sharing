package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.PostImage;
import com.advanced_mobile_programing.docs_sharing.repository.IPostImageRepository;
import com.advanced_mobile_programing.docs_sharing.service.IPostImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class PostImageServiceImpl implements IPostImageService {
    private final IPostImageRepository postImageRepository;

    @Autowired
    public PostImageServiceImpl(IPostImageRepository postImageRepository) {
        this.postImageRepository = postImageRepository;
    }

    @Override
    public <S extends PostImage> S save(S entity) {
        return postImageRepository.save(entity);
    }

    @Override
    public Optional<PostImage> findById(int id) {
        return postImageRepository.findById(id);
    }

    @Override
    public void deleteById(Integer integer) {
        postImageRepository.deleteById(integer);
    }


}
