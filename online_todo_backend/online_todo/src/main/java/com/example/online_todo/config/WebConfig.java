package com.example.online_todo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
public class WebConfig {

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**") // allow all endpoints
                        .allowedOriginPatterns("*") // allow all origins
                        .allowedMethods("*") // GET, POST, PUT, DELETE etc.
                        .allowedHeaders("*")
                        .allowCredentials(true);
            }
        };
    }
}