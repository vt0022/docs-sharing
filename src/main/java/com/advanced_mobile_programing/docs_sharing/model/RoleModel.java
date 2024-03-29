package com.advanced_mobile_programing.docs_sharing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RoleModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private int id;

    private String roleName;
}
