package com.advanced_mobile_programing.docs_sharing.model.request_model;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SignupRequestModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    @Email
    private String email;

    @Size(min = 8)
    private String password;

    @Size(min = 8)
    private String confirmPassword;

    private String firstName;

    private String lastName;

}
