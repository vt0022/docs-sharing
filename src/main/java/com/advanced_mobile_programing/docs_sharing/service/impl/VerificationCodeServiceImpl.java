package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.entity.VerificationCode;
import com.advanced_mobile_programing.docs_sharing.repository.IVerificationCodeRepository;
import com.advanced_mobile_programing.docs_sharing.service.IVerificationCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class VerificationCodeServiceImpl implements IVerificationCodeService {
    private final IVerificationCodeRepository verificationCodeRepository;

    @Autowired
    public VerificationCodeServiceImpl(IVerificationCodeRepository verificationCodeRepository) {
        this.verificationCodeRepository = verificationCodeRepository;
    }

    @Override
    public Optional<VerificationCode> findByUser(User user) {
        return verificationCodeRepository.findByUser(user);
    }

    @Override
    public <S extends VerificationCode> S save(S entity) {
        return verificationCodeRepository.save(entity);
    }
}
