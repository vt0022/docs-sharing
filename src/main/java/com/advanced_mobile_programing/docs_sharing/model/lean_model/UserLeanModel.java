package com.advanced_mobile_programing.docs_sharing.model.lean_model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserLeanModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private int userId;

    private String firstName;

    private String lastName;

    private int gender;

    private String image;

    private String email;

}
