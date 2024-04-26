package com.advanced_mobile_programing.docs_sharing.model.response_model;

import com.advanced_mobile_programing.docs_sharing.model.lean_model.UserLeanModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostReportResponseModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private int reportId;

    private Timestamp reportedAt;

    private boolean isRead;

    private ReportTypeResponseModel reportType;

    private String reason;

    private PostResponseModel post;

    private UserLeanModel user;
}
