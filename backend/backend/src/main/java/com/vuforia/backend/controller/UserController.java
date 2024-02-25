package com.vuforia.backend.controller;

import com.vuforia.backend.exceptions.*;
import com.vuforia.backend.models.UserEntity;
import com.vuforia.backend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
@CrossOrigin(origins = "*")
public class UserController {

    @Autowired
    UserService userService;


    @GetMapping(path = "/getUsers")
    public ResponseEntity<?> getUsers(){
        List<UserEntity> users = userService.getUsers();
        return ResponseEntity.status(HttpStatus.OK).body(users);
    }

    @GetMapping(path = "/getUser/{userName}")
    public ResponseEntity<?> getUser(@PathVariable String userName) throws UserNotFoundException {
        try{
            UserEntity user = userService.getUserByUserName(userName);
            return ResponseEntity.status(HttpStatus.OK).body(user);
        }
        catch (UserNotFoundException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping(path = "/getUserByEmail/{email}")
    public ResponseEntity<?> getUserByEmail(@PathVariable String email) throws UserNotFoundException {
        try{
            UserEntity user = userService.getUserByEmail(email);
            return ResponseEntity.status(HttpStatus.OK).body(user);
        }
        catch (UserNotFoundException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping(path = "/createUser")
    public ResponseEntity<?> createUser(@RequestBody UserEntity userDetails) throws UserAlreadyExistException {
        try {
            String createUser = userService.createUser(userDetails);
            return ResponseEntity.status(HttpStatus.OK).body(createUser);
        }catch (UserAlreadyExistException e)
        {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PutMapping(path = "/updateUser/{userName}")
    public ResponseEntity<?> updateUser(@PathVariable String userName, @RequestBody UserEntity userDetails) throws UserNotFoundException, UserAlreadyExistException {
        try {
            String updateUser = userService.updateUser(userName, userDetails);
            return ResponseEntity.status(HttpStatus.OK).body(updateUser);
        }
        catch (UserNotFoundException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/signin/{username}/{password}")
    public ResponseEntity<?> authenticateUser(@PathVariable String username, @PathVariable String password){
        try {
            String signin = userService.signInUser(username,password);
            return ResponseEntity.status(HttpStatus.OK).body(signin);
        }
        catch(Exception e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/name/{username}")
    public ResponseEntity<?> getAccountName(@PathVariable String username) throws UserNotFoundException{
        try {
            String name = userService.getName(username);
            return ResponseEntity.status(HttpStatus.OK).body(name);
        } catch (UserNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

}
