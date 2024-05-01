package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.DocumentReport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface IDocumentReportRepository extends JpaRepository<DocumentReport, Integer> {
    Page<DocumentReport> findByIsRead(boolean isRead, Pageable pageable);

    @Query("SELECT COUNT(dr) FROM DocumentReport dr WHERE dr.reportedAt >= :start AND dr.reportedAt < :end")
    long countByCreatedAtBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT COUNT(dr) FROM DocumentReport dr WHERE YEAR(dr.reportedAt) = :year")
    long countByReportedAtYear(@Param("year") int year);
}
