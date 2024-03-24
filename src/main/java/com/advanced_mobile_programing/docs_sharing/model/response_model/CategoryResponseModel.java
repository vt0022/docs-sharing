package com.advanced_mobile_programing.docs_sharing.model.response_model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryResponseModel implements Serializable {
    @Serial
    private final static long serialVersionUID = 1L;

    private int categoryId;

    private String categoryName;

    private Timestamp createdAt;

    private Timestamp updatedAt;

    private boolean isDisabled;

    private int totalUses;
}
