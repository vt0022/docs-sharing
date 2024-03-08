package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface IUserService {
    Page<User> findAll(Pageable pageable);

    <S extends User> S save(S entity);

    <S extends User> S update(S entity);

    void deleteById(int id);

    Optional<User> findById(int id);

    Optional<User> findByEmail(String email);

    Optional<User> findByEmailAndIsDisabledAndIsAuthenticated(String email, boolean isDisabled, boolean isAuthenticated);

    Optional<User> findLoggedInUser();
}
