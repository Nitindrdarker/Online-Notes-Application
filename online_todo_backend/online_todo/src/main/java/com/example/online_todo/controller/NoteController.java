package com.example.online_todo.controller;

import org.springframework.web.bind.annotation.*;

import com.example.online_todo.models.Note;
import com.example.online_todo.services.NoteService;

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
    public Map<String, Object> getAllNotes() {
        return Map.of("notes",service.getAllNotes());
    }

    @PostMapping
    public Note createNote(@RequestBody Note note) {
        return service.createNote(note);
    }

    @DeleteMapping("/{id}")
    public void deleteNote(@PathVariable Long id) {
        service.deleteNote(id);
    }


    @PutMapping("/{id}")
public Note updateNote(@PathVariable Long id, @RequestBody Note note) {
    return service.updateNote(id, note.getTitle(), note.getContent(), note.getUpdatedAt());
}


}