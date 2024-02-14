package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Role;
import com.advanced_mobile_programing.docs_sharing.repository.IRoleRepository;
import com.advanced_mobile_programing.docs_sharing.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
public class RoleServiceImpl implements IRoleService {
    private final IRoleRepository roleRepository;

    @Autowired
    public RoleServiceImpl(IRoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    @Override
    public Optional<Role> findById(UUID uuid) {
        return roleRepository.findById(uuid);
    }

    @Override
    public <S extends Role> S save(S entity) {
        return roleRepository.save(entity);
    }

    @Override
    public Optional<Role> findByRoleName(String roleName) {
        return roleRepository.findByRoleName(roleName);
    }
}
