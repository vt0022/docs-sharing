package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Category;
import com.advanced_mobile_programing.docs_sharing.entity.Field;
import com.advanced_mobile_programing.docs_sharing.repository.IFieldRepository;
import com.advanced_mobile_programing.docs_sharing.service.IFieldService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class FieldServiceImpl implements IFieldService {
    private final IFieldRepository fieldRepository;

    @Autowired
    public FieldServiceImpl(IFieldRepository fieldRepository) {
        this.fieldRepository = fieldRepository;
    }

    @Override
    public Optional<Field> findById(Integer integer) {
        return fieldRepository.findById(integer);
    }

    @Override
    public Page<Field> findAll(Pageable pageable) {
        return fieldRepository.findAll(pageable);
    }

    @Override
    public Page<Field> searchAll(String q, String order, Pageable pageable) {
        String query = '%' + q.toLowerCase() + '%';
        Page<Field> fields;

        if (order.equals("mostUses")) {
            fields = fieldRepository.findAllOrderByMostUsesAndNewest(query, pageable);
        } else {
            Sort sort;
            if (order.equals("oldest")) {
                sort = Sort.by(Sort.Direction.ASC, "createdAt");
            } else { // newest
                sort = Sort.by(Sort.Direction.DESC, "createdAt");
            }
            pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
            fields = fieldRepository.findAll(query, pageable);
        }

        return fields;
    }

    @Override
    public boolean existsByFieldName(String fieldName) {
        return fieldRepository.existsByFieldName(fieldName);
    }

    @Override
    public void save(Field field) {
        fieldRepository.save(field);
    }

    @Override
    public void delete(Field field) {
        fieldRepository.delete(field);
    }
}
