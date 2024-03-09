package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Document;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface IDocumentService {
    Page<Document> findAll(Pageable pageable);

    Page<Document> searchAll(String q, List<Integer> categories, List<Integer> fields, String order, Pageable pageable);

    Optional<Document> findById(int docId);

    void save(Document document);

    void delete(int docId);
}
