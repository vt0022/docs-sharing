package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Role;

import java.util.Optional;

public interface IRoleService {
    Optional<Role> findById(int id);

    <S extends Role> S save(S entity);

    Optional<Role> findByRoleName(String roleName);
}
