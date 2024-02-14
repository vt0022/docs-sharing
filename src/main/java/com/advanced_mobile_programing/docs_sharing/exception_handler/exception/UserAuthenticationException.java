package com.advanced_mobile_programing.docs_sharing.exception_handler.exception;

import org.springframework.security.core.AuthenticationException;

public class UserAuthenticationException extends AuthenticationException {
    public UserAuthenticationException(String msg) {
        super(msg);
    }
}
