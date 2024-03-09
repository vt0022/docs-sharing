package com.advanced_mobile_programing.docs_sharing.model.lean_model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryLeanModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private int categoryId;

    private String categoryName;
}
