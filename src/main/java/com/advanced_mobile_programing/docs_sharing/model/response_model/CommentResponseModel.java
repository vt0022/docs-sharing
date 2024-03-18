package com.advanced_mobile_programing.docs_sharing.model.response_model;

import com.advanced_mobile_programing.docs_sharing.model.lean_model.CommentLeanModel;
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
public class CommentResponseModel  implements Serializable {
    @Serial
    private final static long serialVersionUID = 1L;

    private int commentId;
    private String content;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private List<CommentLeanModel> childComments;
    private CommentLeanModel parentComment;
    private PostResponseModel post;
    private UserLeanModel user;
    private int totalLikes;
    private int totalResponses;
    private boolean isCommented;
    private boolean isLiked;
}
