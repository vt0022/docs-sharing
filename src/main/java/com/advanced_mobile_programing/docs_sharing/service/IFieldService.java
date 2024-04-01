package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Field;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface IFieldService {
    Optional<Field> findById(Integer integer);

    Page<Field> findAll(Pageable pageable);

    Page<Field> searchAll(String q, String order, Pageable pageable);

    boolean existsByFieldName(String fieldName);

    void save(Field field);

    void delete(Field field);

    long countAll();

    long countByCreatedAtYearAndMonth(int year, int month);

    long countByCreatedAtYear(int year);
}
