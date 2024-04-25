package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.*;
import com.advanced_mobile_programing.docs_sharing.repository.IDocumentRepository;
import com.advanced_mobile_programing.docs_sharing.service.ICategoryService;
import com.advanced_mobile_programing.docs_sharing.service.IDocumentService;
import com.advanced_mobile_programing.docs_sharing.service.IFieldService;
import com.advanced_mobile_programing.docs_sharing.service.ITagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class DocumentServiceImpl implements IDocumentService {

    private final IDocumentRepository documentRepository;
    private final ICategoryService categoryService;
    private final IFieldService fieldService;
    private final ITagService tagService;

    @Autowired
    public DocumentServiceImpl(IDocumentRepository documentRepository, ICategoryService categoryService, IFieldService fieldService, ITagService tagService) {
        this.documentRepository = documentRepository;
        this.categoryService = categoryService;
        this.fieldService = fieldService;
        this.tagService = tagService;
    }

    @Override
    public Page<Document> findAll(Pageable pageable) {
        return documentRepository.findAll(pageable);
    }

    @Override
    public Page<Document> searchAll(String q, List<Integer> categories, List<Integer> fields, String order, Pageable pageable) {
        List<Category> categoryList = new ArrayList<>();
        List<Field> fieldList = new ArrayList<>();

        if (categories != null)
            for (Integer c : categories) {
                Optional<Category> category = categoryService.findById(c);
                if (category.isPresent())
                    categoryList.add(category.get());
            }

        if (fields != null)
            for (Integer f : fields) {
                Optional<Field> field = fieldService.findById(f);
                if (field.isPresent())
                    fieldList.add(field.get());
            }

        String query = '%' + q.toLowerCase() + '%';

        if (order.equals("mostLikes")) {
            if (categoryList.size() > 0) {
                if (fieldList.size() > 0) {
                    return documentRepository.findAllByFieldsAndCategoriesOrderByLikes(query, categoryList, fieldList, pageable);
                } else {
                    return documentRepository.findAllByCategoriesOrderByLikes(query, categoryList, pageable);
                }
            } else {
                if (fieldList.size() > 0) {
                    return documentRepository.findAllByFieldsOrderByLikes(query, fieldList, pageable);
                } else {
                    return documentRepository.findAllOrderByLikes(query, pageable);
                }
            }
        } else {
            Sort sort;
            Pageable newPageable;
            if (order.equals("mostViews"))
                sort = Sort.by(Sort.Direction.DESC, "totalView");
            else if (order.equals("oldest"))
                sort = Sort.by(Sort.Direction.ASC, "uploadedAt");
            else
                sort = Sort.by(Sort.Direction.DESC, "uploadedAt");

            newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);

            if (categoryList.size() > 0) {
                if (fieldList.size() > 0) {
                    return documentRepository.findAllByCategoriesAndFields(query, categoryList, fieldList, newPageable);
                } else {
                    return documentRepository.findAllByCategories(query, categoryList, newPageable);
                }
            } else {
                if (fieldList.size() > 0) {
                    return documentRepository.findAllByFields(query, fieldList, newPageable);
                } else {
                    return documentRepository.findAll(query, newPageable);
                }
            }
        }
    }

    @Override
    public Page<Document> searchWithTag(String q, int tagId, String order, Pageable pageable) {
        Tag tag = tagService.findById(tagId).orElseThrow(() -> new RuntimeException("Tag not found"));

        String query = '%' + q.toLowerCase() + '%';

        if (order.equals("mostLikes")) {
            return documentRepository.findAllByTags(query, tag, pageable);
        } else {
            Sort sort;
            Pageable newPageable;
            if (order.equals("mostViews"))
                sort = Sort.by(Sort.Direction.DESC, "totalView");
            else if (order.equals("oldest"))
                sort = Sort.by(Sort.Direction.ASC, "uploadedAt");
            else
                sort = Sort.by(Sort.Direction.DESC, "uploadedAt");

            newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
            return documentRepository.findAllByTagsOrderByLikes(query, tag, newPageable);
        }
    }

    @Override
    public Optional<Document> findById(int docId) {
        return documentRepository.findById(docId);
    }

    @Override
    public void save(Document document) {
        documentRepository.save(document);
    }

    @Override
    public void delete(int docId) {
        documentRepository.deleteById(docId);
    }

    @Override
    public Page<Document> findByUser(User user, Pageable pageable) {
        return documentRepository.findByUser(user, pageable);
    }

    @Override
    public long countByUploadedAtYearAndMonth(int year, int month) {
        LocalDateTime start = LocalDateTime.of(year, month, 1, 0, 0);
        LocalDateTime end = start.plusMonths(1);
        return documentRepository.countByUploadedAtBetween(start, end);
    }

    @Override
    public long countAll() {
        return documentRepository.count();
    }

    @Override
    public long countByUploadedAtYear(int year) {
        return documentRepository.countByUploadedAtYear(year);
    }

    @Override
    @Query("SELECT d FROM Document d " +
            "JOIN d.documentLikes l " +
            "WHERE l.user = :user " +
            "ORDER BY l.likedAt DESC")
    public Page<Document> findByUserLike(User user, Pageable pageable) {
        return documentRepository.findByUserLike(user, pageable);
    }
}
