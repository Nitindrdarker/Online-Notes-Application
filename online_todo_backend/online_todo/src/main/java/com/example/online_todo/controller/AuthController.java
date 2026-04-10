package com.example.online_todo.controller;

import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<?> register(@RequestBody User user) {
        try{
            return ResponseEntity.ok(service.register(user));
        } catch(Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
        
    }

    // ✅ Login API
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody User user) {

        User loggedInUser = service.login(user.getUsername(), user.getPassword());
        String token = jwtUtil.generateToken(loggedInUser.getUsername());

        return Map.of(
                "message", "Login successful",
                "token", token,
                "username", loggedInUser.getUsername()
                
        );
    }
}