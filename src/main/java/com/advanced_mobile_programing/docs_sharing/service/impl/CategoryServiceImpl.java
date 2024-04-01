package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Category;
import com.advanced_mobile_programing.docs_sharing.repository.ICategoryRepository;
import com.advanced_mobile_programing.docs_sharing.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class CategoryServiceImpl implements ICategoryService {
    private final ICategoryRepository categoryRepository;

    @Autowired
    public CategoryServiceImpl(ICategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public Optional<Category> findById(Integer integer) {
        return categoryRepository.findById(integer);
    }

    @Override
    public Page<Category> findAll(Pageable pageable) {
        return categoryRepository.findAll(pageable);
    }

    @Override
    public Page<Category> searchAll(String q, String order, Pageable pageable) {
        String query = '%' + q.toLowerCase() + '%';
        Page<Category> categories;

        if (order.equals("mostUses")) {
            categories = categoryRepository.findAllOrderByMostUsesAndNewest(query, pageable);
        } else {
            Sort sort;
            if (order.equals("oldest")) {
                sort = Sort.by(Sort.Direction.ASC, "createdAt");
            } else { // newest
                sort = Sort.by(Sort.Direction.DESC, "createdAt");
            }
            pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
            categories = categoryRepository.findAll(query, pageable);
        }

        return categories;
    }

    @Override
    public boolean existsByCategoryName(String categoryName) {
        return categoryRepository.existsByCategoryName(categoryName);
    }

    @Override
    public void save(Category category) {
        categoryRepository.save(category);
    }

    @Override
    public void delete(Category category) {
        categoryRepository.delete(category);
    }

    @Override
    public long countAll() {
        return categoryRepository.count();
    }

    @Override
    public long countByCreatedAtYearAndMonth(int year, int month) {
        LocalDateTime start = LocalDateTime.of(year, month, 1, 0, 0);
        LocalDateTime end = start.plusMonths(1);
        return categoryRepository.countByCreatedAtBetween(start, end);
    }

    @Override
    public long countByCreatedAtYear(int year) {
        return categoryRepository.countByCreatedAtYear(year);
    }

}
