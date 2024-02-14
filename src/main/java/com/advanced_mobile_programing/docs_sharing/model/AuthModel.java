package com.advanced_mobile_programing.docs_sharing.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Builder
public class AuthModel {
    private String accessToken;
    private String refreshToken;
}
