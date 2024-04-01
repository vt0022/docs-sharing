package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.Field;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface IFieldRepository extends JpaRepository<Field, Integer> {
    @Query("SELECT f FROM Field f WHERE LOWER(f.fieldName) LIKE :query ORDER BY SIZE(f.documents) DESC, f.createdAt DESC")
    Page<Field> findAllOrderByMostUsesAndNewest(@Param("query") String query, Pageable pageable);

    @Query("SELECT f FROM Field f WHERE LOWER(f.fieldName) LIKE :query")
    Page<Field> findAll(@Param("query") String query, Pageable pageable);

    boolean existsByFieldName(String fieldName);

    @Query("SELECT COUNT(f) FROM Field f WHERE f.createdAt >= :start AND f.createdAt < :end")
    long countByCreatedAtBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT COUNT(f) FROM Field f WHERE YEAR(f.createdAt) = :year")
    int countByCreatedAtYear(@Param("year") int year);
}
