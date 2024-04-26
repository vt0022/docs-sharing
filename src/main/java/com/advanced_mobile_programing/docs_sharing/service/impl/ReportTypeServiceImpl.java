package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.ReportType;
import com.advanced_mobile_programing.docs_sharing.repository.IReportTypeRepository;
import com.advanced_mobile_programing.docs_sharing.service.IReportTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReportTypeServiceImpl implements IReportTypeService {
    private final IReportTypeRepository reportTypeRepository;

    @Autowired
    public ReportTypeServiceImpl(IReportTypeRepository reportTypeRepository) {
        this.reportTypeRepository = reportTypeRepository;
    }

    @Override
    public List<ReportType> findByType(int type) {
        return reportTypeRepository.findByType(type);
    }

    @Override
    public Optional<ReportType> findById(Integer integer) {
        return reportTypeRepository.findById(integer);
    }
}
