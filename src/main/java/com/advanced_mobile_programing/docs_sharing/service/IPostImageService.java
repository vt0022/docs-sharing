package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.PostImage;

import java.util.Optional;

public interface IPostImageService {
    <S extends PostImage> S save(S entity);

    Optional<PostImage> findById(int id);

    void deleteById(Integer integer);
}
