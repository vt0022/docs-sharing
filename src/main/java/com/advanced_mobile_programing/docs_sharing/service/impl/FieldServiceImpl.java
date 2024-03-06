package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Field;
import com.advanced_mobile_programing.docs_sharing.repository.IFieldRepository;
import com.advanced_mobile_programing.docs_sharing.service.IFieldService;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class FieldServiceImpl implements IFieldService {
    private final IFieldRepository fieldRepository;

    public FieldServiceImpl(IFieldRepository fieldRepository) {
        this.fieldRepository = fieldRepository;
    }

    @Override
    public Optional<Field> findById(Integer integer) {
        return fieldRepository.findById(integer);
    }
}
