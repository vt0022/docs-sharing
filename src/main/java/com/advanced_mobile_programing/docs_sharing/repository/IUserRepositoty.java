package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IUserRepositoty extends JpaRepository<User, Integer> {

    Optional<User> findByEmail(String email);

    Optional<User> findByEmailAndIsDisabledAndIsAuthenticated(String email, boolean isDisabled, boolean isAuthenticated);

}
