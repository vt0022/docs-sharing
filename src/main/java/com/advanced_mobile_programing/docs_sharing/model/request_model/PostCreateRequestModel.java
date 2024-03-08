package com.advanced_mobile_programing.docs_sharing.model.request_model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Builder
public class PostCreateRequestModel {
    private String title;
    private String content;
}
