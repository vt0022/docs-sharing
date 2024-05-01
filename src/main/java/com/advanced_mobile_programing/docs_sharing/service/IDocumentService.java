package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Document;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface IDocumentService {
    Page<Document> findAll(Pageable pageable);

    Page<Document> searchAll(String q, List<Integer> categories, List<Integer> fields, String order, Pageable pageable);

    Optional<Document> findById(int docId);

    void save(Document document);

    void delete(int docId);

    Page<Document> findByUser(User user, Pageable pageable);

    long countByUploadedAtYearAndMonth(int year, int month);

    long countAll();

    long countByUploadedAtYear(int year);

    @Query("SELECT d FROM Document d " +
            "JOIN d.documentLikes l " +
            "WHERE l.user = :user " +
            "ORDER BY l.likedAt DESC")
    Page<Document> findByUserLike(User user, Pageable pageable);
}
