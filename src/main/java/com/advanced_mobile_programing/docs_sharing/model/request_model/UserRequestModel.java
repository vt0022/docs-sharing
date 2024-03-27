package com.advanced_mobile_programing.docs_sharing.model.request_model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserRequestModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private String firstName;

    private String lastName;

    private Timestamp dateOfBirth;

    private int gender;

    private String email;

    private String password;

    private String confirmPassword;

    private int roleId = 3;
}
