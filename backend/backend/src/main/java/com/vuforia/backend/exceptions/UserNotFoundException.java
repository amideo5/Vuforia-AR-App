package com.vuforia.backend.exceptions;

public class UserNotFoundException extends RuntimeException{
    public UserNotFoundException(String userName) {
        super("Could not find User name " + userName);
    }
}
