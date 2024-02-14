package com.vuforia.backend.controller;

import com.vuforia.backend.exceptions.UserNotFoundException;
import com.vuforia.backend.models.UserEntity;
import com.vuforia.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserRepository userRepository ;

    @GetMapping(path = "/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<UserEntity> list() {
        return userRepository.findAll();
    }

    @GetMapping("/byId/{id}")
    UserEntity getUser(@PathVariable String id) {
        UserEntity user = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));
        return user;
    }

    @PostMapping(path = "/add", produces = MediaType.APPLICATION_JSON_VALUE)
    public UserEntity save(@RequestBody UserEntity newUser) {
        return userRepository.save(newUser);
    }

    @PutMapping("/update/{id}")
    UserEntity replaceEmployee(@RequestBody UserEntity newUser, @PathVariable String id) {

        UserEntity user = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));

        user.setName(newUser.getName());
        return user;

    }

    @DeleteMapping("/delete/{id}")
    void deleteEmployee(@PathVariable String id) {
        userRepository.deleteById(id);
    }
}
