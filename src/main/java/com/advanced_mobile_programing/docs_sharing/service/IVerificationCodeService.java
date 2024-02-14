package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.entity.VerificationCode;

import java.util.Optional;

public interface IVerificationCodeService {
    Optional<VerificationCode> findByUser(User user);

    <S extends VerificationCode> S save(S entity);
}
