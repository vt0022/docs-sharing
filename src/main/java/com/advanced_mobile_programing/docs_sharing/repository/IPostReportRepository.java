package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.PostReport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface IPostReportRepository extends JpaRepository<PostReport, Integer> {
    Page<PostReport> findByIsRead(boolean isRead, Pageable pageable);

    @Query("SELECT COUNT(pr) FROM PostReport pr WHERE pr.reportedAt >= :start AND pr.reportedAt < :end")
    long countByCreatedAtBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT COUNT(pr) FROM PostReport pr WHERE YEAR(pr.reportedAt) = :year")
    long countByReportedAtYear(@Param("year") int year);
}
