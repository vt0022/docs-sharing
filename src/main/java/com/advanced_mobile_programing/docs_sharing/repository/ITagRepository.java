package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.Category;
import com.advanced_mobile_programing.docs_sharing.entity.Tag;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface ITagRepository extends JpaRepository<Tag, Integer> {
    @Query("SELECT t FROM Tag t WHERE LOWER(t.name) LIKE :query ORDER BY SIZE(t.posts) DESC, t.updatedAt DESC")
    Page<Tag> findAllOrderByMostUsesAndNewest(@Param("query") String query, Pageable pageable);

    @Query("SELECT t FROM Tag t WHERE LOWER(t.name) LIKE :query")
    Page<Tag> findAll(@Param("query") String query, Pageable pageable);

    boolean existsByName(String name);

    @Query("SELECT COUNT(t) FROM Tag t WHERE t.createdAt >= :start AND t.createdAt < :end")
    long countByCreatedAtBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT COUNT(t) FROM Tag t WHERE YEAR(t.createdAt) = :year")
    long countByCreatedAtYear(@Param("year") int year);
}
