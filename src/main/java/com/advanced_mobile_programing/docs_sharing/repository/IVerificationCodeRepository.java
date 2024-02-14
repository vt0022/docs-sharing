package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.entity.VerificationCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface IVerificationCodeRepository extends JpaRepository<VerificationCode, UUID> {
    Optional<VerificationCode> findByUser(User user);
}
