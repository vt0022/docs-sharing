package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Post;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface IPostService {
    Page<Post> findAll(Pageable pageable);

    Page<Post> searchAll(String order, String q, Pageable pageable);

    Optional<Post> findById(Integer integer);

    void save(Post post);

    void delete(int postId);

    long countByCreatedAtYearAndMonth(int year, int month);

    long countAll();

    long countByCreatedAtYear(int year);
}
