package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface ICategoryService {
    Optional<Category> findById(Integer integer);

    Page<Category> findAll(Pageable pageable);

    Page<Category> searchAll(String q, String order, Pageable pageable);

    boolean existsByCategoryName(String categoryName);

    void save(Category category);

    void delete(Category category);

    long countAll();

    long countByCreatedAtYearAndMonth(int year, int month);

    long countByCreatedAtYear(int year);
}
