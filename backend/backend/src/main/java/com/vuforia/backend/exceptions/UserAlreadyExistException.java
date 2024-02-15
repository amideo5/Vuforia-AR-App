package com.vuforia.backend.exceptions;

public class UserAlreadyExistException extends Exception{
    public UserAlreadyExistException(String username){
        super("User with user name: " + username + " already exist");
    }
}