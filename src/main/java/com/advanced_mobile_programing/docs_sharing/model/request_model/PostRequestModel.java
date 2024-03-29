package com.advanced_mobile_programing.docs_sharing.model.request_model;

import com.advanced_mobile_programing.docs_sharing.entity.Tag;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PostRequestModel implements Serializable {
    @Serial
    private final static long serialVersionUID = 1L;
    private String title;
    private String content;
    private List<Integer> tagIds;
}
