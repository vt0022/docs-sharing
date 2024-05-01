package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Post;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface IPostService {
    Page<Post> findAll(Pageable pageable);

    Page<Post> searchAll(String order, String q, Pageable pageable);

    Optional<Post> findById(Integer integer);

    <S extends Post> S save(S entity);

    void delete(int postId);

    long countByCreatedAtYearAndMonth(int year, int month);

    long countAll();

    long countByCreatedAtYear(int year);

    Page<Post> findByUserOrderByCreatedAtDesc(User user, Pageable pageable);

    @Query("SELECT p FROM Post p " +
            "JOIN p.postLikes l " +
            "WHERE l.user = :user " +
            "ORDER BY l.likedAt DESC")
    Page<Post> findByUserLike(User user, Pageable pageable);

    Page<Post> searchWithTag(String q, int tagId, String order, Pageable pageable);
}
