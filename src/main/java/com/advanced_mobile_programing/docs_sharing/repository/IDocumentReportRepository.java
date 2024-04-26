package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.DocumentReport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IDocumentReportRepository extends JpaRepository<DocumentReport, Integer> {
    Page<DocumentReport> findByIsRead(boolean isRead, Pageable pageable);
}
