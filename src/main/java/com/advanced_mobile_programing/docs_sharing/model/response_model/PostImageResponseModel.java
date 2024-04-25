package com.advanced_mobile_programing.docs_sharing.model.response_model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostImageResponseModel implements Serializable {
    @Serial
    private final static long serialVersionUID = 1L;

    private int postImageId;

    private String url;
}
