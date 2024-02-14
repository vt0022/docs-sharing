package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.exception_handler.exception.UserAuthenticationException;
import com.advanced_mobile_programing.docs_sharing.repository.IUserRepositoty;
import com.advanced_mobile_programing.docs_sharing.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
public class UserServiceImpl implements IUserService {

    private final IUserRepositoty userRepository;

    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceImpl(IUserRepositoty userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public Page<User> findAll(Pageable pageable) {
        return userRepository.findAll(pageable);
    }

    @Override
    public <S extends User> S save(S entity) {
        entity.setPassword(passwordEncoder.encode(entity.getPassword()));
        return userRepository.save(entity);
    }

    @Override
    public <S extends User> S update(S entity) {
        return userRepository.save(entity);
    }

    @Override
    public void deleteById(UUID uuid) {
        userRepository.deleteById(uuid);
    }

    @Override
    public Optional<User> findById(UUID uuid) {
        return userRepository.findById(uuid);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public Optional<User> findByEmailAndIsDisabled(String email, boolean isDisabled) {
        return userRepository.findByEmailAndIsDisabled(email, isDisabled);
    }

    @Override
    public Optional<User> findLoggedInUser() {
        // Find user info
        UsernamePasswordAuthenticationToken auth = (UsernamePasswordAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        if (auth == null) {
            throw new UserAuthenticationException("User unauthorized. Please log in again.");
        }
        String email = String.valueOf(auth.getPrincipal());
        return userRepository.findByEmail(email);
    }
}
