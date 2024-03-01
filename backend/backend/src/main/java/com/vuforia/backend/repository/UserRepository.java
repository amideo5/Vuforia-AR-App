package com.vuforia.backend.repository;

import com.vuforia.backend.models.UserEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<UserEntity, Long> {
    UserEntity save(UserEntity user);

    List<UserEntity> findAll();

    void deleteById(Long userId);

    UserEntity findByuserName(String userName);

    UserEntity findByEmail(String email);

    Optional<UserEntity> findById(Long userId);
}
