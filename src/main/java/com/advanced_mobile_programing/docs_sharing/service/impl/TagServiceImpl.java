package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Category;
import com.advanced_mobile_programing.docs_sharing.entity.Tag;
import com.advanced_mobile_programing.docs_sharing.repository.ITagRepository;
import com.advanced_mobile_programing.docs_sharing.service.ITagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TagServiceImpl implements ITagService {
    private final ITagRepository tagRepository;

    @Autowired
    public TagServiceImpl(ITagRepository tagRepository) {
        this.tagRepository = tagRepository;
    }

    @Override
    public Optional<Tag> findById(Integer integer) {
        return tagRepository.findById(integer);
    }

    @Override
    public Page<Tag> findAll(Pageable pageable) {
        return tagRepository.findAll(pageable);
    }

    @Override
    public Page<Tag> searchAll(String q, String order, Pageable pageable) {
        String query = '%' + q.toLowerCase() + '%';
        Page<Tag> tags;

        if (order.equals("mostUses")) {
            tags = tagRepository.findAllOrderByMostUsesAndNewest(query, pageable);
        } else {
            Sort sort;
            if (order.equals("oldest")) {
                sort = Sort.by(Sort.Direction.ASC, "createdAt");
            } else { // newest
                sort = Sort.by(Sort.Direction.DESC, "createdAt");
            }
            pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
            tags = tagRepository.findAll(query, pageable);
        }

        return tags;
    }

    @Override
    public boolean existsByName(String name) {
        return tagRepository.existsByName(name);
    }

    @Override
    public void save(Tag tag) {
        tagRepository.save(tag);
    }

    @Override
    public void delete(Tag tag) {
        tagRepository.delete(tag);
    }

    @Override
    public List<Tag> findAllById(List<Integer> tagIds) {
        return tagRepository.findAllById(tagIds);
    }
}
