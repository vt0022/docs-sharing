package com.advanced_mobile_programing.docs_sharing.model.response_model;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FieldResponseModel implements Serializable {
    @Serial
    private final static long serialVersionUID = 1L;

    private int fieldId;

    private String fieldName;

    private Timestamp createdAt;

    private Timestamp updatedAt;

    private boolean isDisabled;

    private int totalUses;
}
