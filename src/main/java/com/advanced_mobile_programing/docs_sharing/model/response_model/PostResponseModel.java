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
public class PostResponseModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private int postId;

    private String title;

    private String content;

    private Timestamp createdAt;

    private Timestamp updatedAt;

    private int totalLikes;

    private int totalComments;

    private boolean isLiked;
}
