package com.example.online_todo.controller;

import org.springframework.web.bind.annotation.*;

import com.example.online_todo.models.Note;
import com.example.online_todo.services.NoteService;

import jakarta.servlet.http.HttpServletRequest;

import java.security.Principal;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/notes")
public class NoteController {

    private final NoteService service;

    public NoteController(NoteService service) {
        this.service = service;
    }

@GetMapping
public Map<String, Object> getAllNotes(@RequestParam(defaultValue="0") int page, @RequestParam(defaultValue="10") int pageSize,  HttpServletRequest request) {

    String username = (String) request.getAttribute("username");

    return Map.of("notes", service.getAllNotes(username, page, pageSize));
}

 @PostMapping
public Note createNote(@RequestBody Note note, HttpServletRequest request) {

    String username = (String) request.getAttribute("username");

    return service.createNote(note, username);
}



    @DeleteMapping("/{id}")
    public void deleteNote(@PathVariable Long id, HttpServletRequest request) {
        String username = (String) request.getAttribute("username");
        service.deleteNote(id, username);
    }


    @PutMapping("/{id}")
public Note updateNote(@PathVariable Long id, @RequestBody Note note, HttpServletRequest request) {
    String username = (String) request.getAttribute("username");
    return service.updateNote(id, note.getTitle(), note.getContent(), note.getUpdatedAt(), username);
}


}