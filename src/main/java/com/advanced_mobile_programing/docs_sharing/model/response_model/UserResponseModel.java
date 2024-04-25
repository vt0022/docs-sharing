package com.advanced_mobile_programing.docs_sharing.model.response_model;

import com.advanced_mobile_programing.docs_sharing.model.RoleModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserResponseModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private int userId;

    private String firstName;

    private String lastName;

    private Timestamp dateOfBirth;

    private int gender;

    private String image;

    private String email;

    private Timestamp createdAt;

    private Timestamp updatedAt;

    private boolean isDisabled;

    private RoleModel role;

    private int totalPosts;

    private int totalDocuments;

    private int totalPostLikes;

    private int totalDocumentLikes;

    private int totalComments;
}
