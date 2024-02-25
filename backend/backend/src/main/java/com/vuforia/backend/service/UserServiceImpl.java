package com.vuforia.backend.service;

import com.vuforia.backend.exceptions.UserAlreadyExistException;
import com.vuforia.backend.exceptions.UserNotFoundException;
import com.vuforia.backend.models.UserEntity;
import com.vuforia.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    UserRepository userRepository;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    public UserServiceImpl(UserRepository userRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.userRepository = userRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Override
    public String createUser(UserEntity user) throws UserAlreadyExistException {
        if(userRepository.findByuserName(user.getUserName()) != null){
            throw new UserAlreadyExistException(user.getUserName());
        }
        UserEntity userEntity = new UserEntity();
        userEntity.setName(user.getName());
        userEntity.setEmail(user.getEmail());
        userEntity.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userEntity.setUserName(user.getUserName());
        userRepository.save(userEntity);
        return "User Created";
    }

    @Override
    public UserEntity getUserByUserName(String username) throws UserNotFoundException {
        if(userRepository.findByuserName(username) == null){
            throw new UserNotFoundException(username);
        }
        return userRepository.findByuserName(username);
    }

    @Override
    public UserEntity getUserByEmail(String email) throws UserNotFoundException {
        if(userRepository.findByEmail(email) == null){
            throw new UserNotFoundException(email);
        }
        return userRepository.findByEmail(email);
    }

    @Override
    public String updateUser(String username, UserEntity user) throws UserNotFoundException {
        if(userRepository.findByuserName(username) == null) {
            throw new UserNotFoundException(username);
        }
        UserEntity userEntity = userRepository.findByuserName(username);
        userEntity.setName(user.getName());
        userEntity.setEmail(user.getEmail());
        userEntity.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userEntity.setUserName(user.getUserName());
        userRepository.save(userEntity);
        return "User Updated";
    }

    @Override
    public List<UserEntity> getUsers() {
        return userRepository.findAll();
    }

    @Override
    public String signInUser(String username, String password) {
        if(username==null||password==null)
            return "Bad credentials";
        UserEntity user1 = userRepository.findByuserName(username);
        if(bCryptPasswordEncoder.matches(password ,user1.getPassword()))
            return "Successful";
        else
            return "Bad Credentials";
    }

    @Override
    public String getName(String username) throws UserNotFoundException {
        UserEntity userEntity = userRepository.findByuserName(username);
        if(userEntity == null){
            throw new UserNotFoundException(username);
        }
        return userEntity.getName();
    }
}
