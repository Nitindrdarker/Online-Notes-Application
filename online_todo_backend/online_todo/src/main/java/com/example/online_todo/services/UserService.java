package com.example.online_todo.services;

import org.springframework.stereotype.Service;

import com.example.online_todo.models.User;
import com.example.online_todo.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository repo;

    public UserService(UserRepository repo) {
        this.repo = repo;
    }

    // ✅ Register user
    public User register(User user) {

        // check if username already exists
        if (repo.findByUsername(user.getUsername()).isPresent()) {
            throw new RuntimeException("Username already exists");
        }

        // save user
        return repo.save(user);
    }

    // ✅ Login user
    public User login(String username, String password) {

        User user = repo.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (!user.getPassword().equals(password)) {
            throw new RuntimeException("Invalid password");
        }

        return user;
    }
}