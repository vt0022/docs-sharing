package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;
import java.util.UUID;

public interface IUserService {
    Page<User> findAll(Pageable pageable);

    <S extends User> S save(S entity);

    <S extends User> S update(S entity);

    void deleteById(UUID uuid);

    Optional<User> findById(UUID uuid);

    Optional<User> findByEmail(String email);

    Optional<User> findByEmailAndIsDisabled(String email, boolean isDisabled);

    Optional<User> findLoggedInUser();
}
