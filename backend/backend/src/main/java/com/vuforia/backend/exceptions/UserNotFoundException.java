package com.vuforia.backend.exceptions;

public class UserNotFoundException extends RuntimeException{
    public UserNotFoundException(String id) {
        super("Could not find User id " + id);
    }
}
