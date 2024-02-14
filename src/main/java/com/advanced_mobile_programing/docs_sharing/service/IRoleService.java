package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Role;

import java.util.Optional;
import java.util.UUID;

public interface IRoleService {
    Optional<Role> findById(UUID uuid);

    <S extends Role> S save(S entity);

    Optional<Role> findByRoleName(String roleName);
}
