package com.vuforia.backend.service;

import com.vuforia.backend.models.UserEntity;
import com.vuforia.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    UserRepository userRepository;

    public List<UserEntity> findAll() {
        return userRepository.findAll();
    }
}
