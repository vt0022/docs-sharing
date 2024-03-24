package com.advanced_mobile_programing.docs_sharing.model.response_model;

import com.advanced_mobile_programing.docs_sharing.model.lean_model.TagLeanModel;
import com.advanced_mobile_programing.docs_sharing.model.lean_model.UserLeanModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostResponseModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private int postId;

    private String title;

    private String content;

    private List<TagLeanModel> tags;

    private Timestamp createdAt;

    private Timestamp updatedAt;

    private int totalLikes;

    private int totalComments;

    private boolean isLiked;

    private UserLeanModel user;
}
