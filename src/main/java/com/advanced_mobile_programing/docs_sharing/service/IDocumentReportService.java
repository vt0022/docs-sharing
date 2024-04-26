package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.DocumentReport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface IDocumentReportService {
    Page<DocumentReport> findAll(Pageable pageable);

    <S extends DocumentReport> S save(S entity);

    Optional<DocumentReport> findById(Integer integer);

    Page<DocumentReport> findByIsRead(boolean isRead, Pageable pageable);
}
