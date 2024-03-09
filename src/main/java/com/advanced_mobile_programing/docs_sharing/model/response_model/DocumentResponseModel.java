package com.advanced_mobile_programing.docs_sharing.model.response_model;

import com.advanced_mobile_programing.docs_sharing.model.lean_model.UserLeanModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DocumentResponseModel implements Serializable {
    @Serial
    private final static long serialVersionUID = 1L;

    private int docId;

    private String docName;

    private String docIntroduction;

    private String viewUrl;

    private String downloadUrl;

    private Timestamp uploadedAt;

    private Timestamp updatedAt;

    private int totalView;

    private String thumbnail;

    private int totalLikes;

    private boolean isLiked;

    private UserLeanModel user;
}
