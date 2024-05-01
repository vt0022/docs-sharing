package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.Post;
import com.advanced_mobile_programing.docs_sharing.entity.Tag;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface IPostRepository extends JpaRepository<Post, Integer> {
    Page<Post> findAll(Pageable pageable);

    Page<Post> findByTitleContainingIgnoreCaseOrContentContainingIgnoreCaseOrderByCreatedAtDesc(String q, String k, Pageable pageable);

    Page<Post> findByUserOrderByCreatedAtDesc(User user, Pageable pageable);

    @Query("SELECT p FROM Post p " +
            "WHERE LOWER(p.title) LIKE LOWER(CONCAT('%', :q, '%')) OR LOWER(p.content) LIKE LOWER(CONCAT('%', :q, '%')) " +
            "ORDER BY SIZE(p.postLikes) DESC")
    Page<Post> findAllOrderByLikes(String q, Pageable pageable);

    @Query("SELECT COUNT(p) FROM Post p WHERE p.createdAt >= :start AND p.createdAt < :end")
    long countByCreatedAtBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT COUNT(p) FROM Post p WHERE YEAR(p.createdAt) = :year")
    long countByCreatedAtYear(@Param("year") int year);

    @Query("SELECT p FROM Post p " +
            "JOIN p.postLikes l " +
            "WHERE l.user = :user " +
            "ORDER BY l.likedAt DESC")
    Page<Post> findByUserLike(User user, Pageable pageable);

    @Query("SELECT p FROM Post p " +
            "WHERE (LOWER(p.title) LIKE LOWER(CONCAT('%', :q, '%')) OR LOWER(p.content) LIKE LOWER(CONCAT('%', :q, '%'))) " +
            "AND :tag MEMBER OF p.tags")
    Page<Post> findAllByTags(String q, Tag tag, Pageable pageable);

    @Query("SELECT p FROM Post p " +
            "WHERE (LOWER(p.title) LIKE LOWER(CONCAT('%', :q, '%')) OR LOWER(p.content) LIKE LOWER(CONCAT('%', :q, '%'))) " +
            "AND :tag MEMBER OF p.tags " +
            "ORDER BY SIZE(p.postLikes) DESC")
    Page<Post> findAllByTagsOrderByLikes(String q, Tag tag, Pageable pageable);
}
