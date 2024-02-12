package com.vuforia.backend.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor 
public class UserEntity {
    @Id
    private String userId;
    private String name;
    private String email;
    private String password;
}