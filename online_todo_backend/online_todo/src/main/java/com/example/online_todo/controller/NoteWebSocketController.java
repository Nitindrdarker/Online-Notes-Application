package com.example.online_todo.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Controller;

import com.example.online_todo.models.NoteEditMessage;
import com.example.online_todo.services.NoteService;

@Controller
public class NoteWebSocketController {

    private final NoteService service;

    public NoteWebSocketController(NoteService service) {
        this.service = service;
    }

    @MessageMapping("/edit")
    public void handleEdit(@Payload NoteEditMessage message) {
       System.out.println("Received edit: " + message.getNoteId()); 
        service.broadcastEdit(message);
    }
}