package com.vuforia.backend.repository;

import com.vuforia.backend.models.UserEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<UserEntity, String> {
    UserEntity save(UserEntity user);

    List<UserEntity> findAll();

    void deleteById(String userId);

    Optional<UserEntity> findById(String userId);
}
