package com.advanced_mobile_programing.docs_sharing.model.request_model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostReportRequestModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private int postId;

    private int typeId;

    private String reason = "";
}
