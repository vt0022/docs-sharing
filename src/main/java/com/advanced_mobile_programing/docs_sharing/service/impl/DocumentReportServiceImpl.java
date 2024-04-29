package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.DocumentReport;
import com.advanced_mobile_programing.docs_sharing.repository.IDocumentReportRepository;
import com.advanced_mobile_programing.docs_sharing.service.IDocumentReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class DocumentReportServiceImpl implements IDocumentReportService {
    private final IDocumentReportRepository documentReportRepository;

    @Autowired
    public DocumentReportServiceImpl(IDocumentReportRepository documentReportRepository) {
        this.documentReportRepository = documentReportRepository;
    }

    @Override
    public Page<DocumentReport> findAll(Pageable pageable) {
        return documentReportRepository.findAll(pageable);
    }

    @Override
    public <S extends DocumentReport> S save(S entity) {
        return documentReportRepository.save(entity);
    }

    @Override
    public Optional<DocumentReport> findById(Integer integer) {
        return documentReportRepository.findById(integer);
    }

    @Override
    public Page<DocumentReport> findByIsRead(boolean isRead, Pageable pageable) {
        return documentReportRepository.findByIsRead(isRead, pageable);
    }

    @Override
    public long countAll() {
        return documentReportRepository.count();
    }

    @Override
    public long countByReportedAtYearAndMonth(int year, int month) {
        LocalDateTime start = LocalDateTime.of(year, month, 1, 0, 0);
        LocalDateTime end = start.plusMonths(1);
        return documentReportRepository.countByCreatedAtBetween(start, end);
    }

    @Override
    public long countByReportedAtYear(int year) {
        return documentReportRepository.countByReportedAtYear(year);
    }
}
