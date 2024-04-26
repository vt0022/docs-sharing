package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.PostReport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface IPostReportService {
    Page<PostReport> findAll(Pageable pageable);

    <S extends PostReport> S save(S entity);

    Page<PostReport> findByIsRead(boolean isRead, Pageable pageable);

    Optional<PostReport> findById(Integer integer);
}
