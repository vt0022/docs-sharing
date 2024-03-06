package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Category;

import java.util.Optional;

public interface ICategoryService {
    Optional<Category> findById(Integer integer);
}
