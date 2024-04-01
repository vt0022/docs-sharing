package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface ICategoryRepository extends JpaRepository<Category, Integer> {
    @Query("SELECT c FROM Category c WHERE LOWER(c.categoryName) LIKE :query ORDER BY SIZE(c.documents) DESC, c.createdAt DESC")
    Page<Category> findAllOrderByMostUsesAndNewest(@Param("query") String query, Pageable pageable);

    @Query("SELECT c FROM Category c WHERE LOWER(c.categoryName) LIKE :query")
    Page<Category> findAll(@Param("query") String query, Pageable pageable);

    boolean existsByCategoryName(String categoryName);

    @Query("SELECT COUNT(c) FROM Category c WHERE c.createdAt >= :start AND c.createdAt < :end")
    long countByCreatedAtBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT COUNT(c) FROM Category c WHERE YEAR(c.createdAt) = :year")
    long countByCreatedAtYear(@Param("year") int year);
}
