package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Tag;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface ITagService {
    Optional<Tag> findById(Integer integer);

    Page<Tag> findAll(Pageable pageable);

    Page<Tag> searchAll(String q, String order, Pageable pageable);

    boolean existsByName(String name);

    void save(Tag tag);

    void delete(Tag tag);

    List<Tag> findAllById(List<Integer> tagIds);
}
