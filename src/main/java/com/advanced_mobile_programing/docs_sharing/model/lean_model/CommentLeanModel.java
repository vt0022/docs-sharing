package com.advanced_mobile_programing.docs_sharing.model.lean_model;

import com.advanced_mobile_programing.docs_sharing.model.response_model.CommentResponseModel;
import com.advanced_mobile_programing.docs_sharing.model.response_model.PostResponseModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentLeanModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private int commentId;
    private String content;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private UserLeanModel user;
}
