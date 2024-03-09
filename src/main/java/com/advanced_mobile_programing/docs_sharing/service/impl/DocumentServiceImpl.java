package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Category;
import com.advanced_mobile_programing.docs_sharing.entity.Document;
import com.advanced_mobile_programing.docs_sharing.entity.Field;
import com.advanced_mobile_programing.docs_sharing.repository.IDocumentRepository;
import com.advanced_mobile_programing.docs_sharing.service.ICategoryService;
import com.advanced_mobile_programing.docs_sharing.service.IDocumentService;
import com.advanced_mobile_programing.docs_sharing.service.IFieldService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class DocumentServiceImpl implements IDocumentService {
    private final IDocumentRepository documentRepository;
    private final ICategoryService categoryService;
    private final IFieldService fieldService;

    @Autowired
    public DocumentServiceImpl(IDocumentRepository documentRepository, ICategoryService categoryService, IFieldService fieldService) {
        this.documentRepository = documentRepository;
        this.categoryService = categoryService;
        this.fieldService = fieldService;
    }

    @Override
    public Page<Document> findAll(Pageable pageable) {
        return documentRepository.findAll(pageable);
    }

    @Override
    public Page<Document> searchAll(String q, List<Integer> categories, List<Integer> fields, String order, Pageable pageable) {
        List<Category> categoryList = new ArrayList<>();
        List<Field> fieldList = new ArrayList<>();

        for (Integer c : categories) {
            Optional<Category> category = categoryService.findById(c);
            if (category.isPresent())
                categoryList.add(category.get());
        }

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
                sort = Sort.by(Sort.Direction.DESC, "totalViews");
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
}
