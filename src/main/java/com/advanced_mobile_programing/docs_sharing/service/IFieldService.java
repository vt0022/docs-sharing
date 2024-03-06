package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Field;

import java.util.Optional;

public interface IFieldService {
    Optional<Field> findById(Integer integer);
}
