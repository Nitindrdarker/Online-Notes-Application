package com.example.online_todo.controller;

import org.springframework.web.bind.annotation.*;

import com.example.online_todo.JwtUtil;
import com.example.online_todo.models.User;
import com.example.online_todo.services.UserService;

import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final UserService service;
    private final JwtUtil jwtUtil;

    public AuthController(UserService service, JwtUtil jwtUtil) {
        this.service = service;
        this.jwtUtil = jwtUtil;
    }

    // ✅ Register API
    @PostMapping("/register")
    public User register(@RequestBody User user) {
        return service.register(user);
    }

    // ✅ Login API
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody User user) {

        User loggedInUser = service.login(user.getUsername(), user.getPassword());
        String token = jwtUtil.generateToken(loggedInUser.getUsername());

        return Map.of(
                "message", "Login successful",
                "token", token
        );
    }
}