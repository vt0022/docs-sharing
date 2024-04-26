package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.ReportType;

import java.util.List;
import java.util.Optional;

public interface IReportTypeService {
    List<ReportType> findByType(int type);

    Optional<ReportType> findById(Integer integer);
}
