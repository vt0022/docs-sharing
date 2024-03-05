package com.advanced_mobile_programing.docs_sharing.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDocument implements Serializable {
    private static final long serialVersionUID = 1L;

    private User user;

    private Document document;
}
