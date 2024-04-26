package com.advanced_mobile_programing.docs_sharing.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Entity
public class ReportType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int typeId;

    private String reason;

    private int type;

    @OneToMany(mappedBy = "reportType", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DocumentReport> documentReports = new ArrayList<>();

    @OneToMany(mappedBy = "reportType", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PostReport> postReports = new ArrayList<>();
}
