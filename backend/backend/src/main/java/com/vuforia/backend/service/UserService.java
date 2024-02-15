package com.vuforia.backend.service;

import com.vuforia.backend.exceptions.UserAlreadyExistException;
import com.vuforia.backend.exceptions.UserNotFoundException;
import com.vuforia.backend.models.UserEntity;

import java.util.List;
import java.util.Optional;

public interface UserService {

    String createUser(UserEntity user) throws UserAlreadyExistException;
    UserEntity getUserByUserName(String username) throws UserNotFoundException;
    String updateUser(String username, UserEntity user) throws UserNotFoundException, UserAlreadyExistException;
    List<UserEntity> getUsers();
    String signInUser(UserEntity user);
    String getName(String username) throws UserNotFoundException;
}
