package com.example.online_todo.services;

import org.springframework.stereotype.Service;

import com.example.online_todo.models.Note;
import com.example.online_todo.repository.NoteRepository;

import java.util.List;

@Service
public class NoteService {

    private final NoteRepository repo;

    public NoteService(NoteRepository repo) {
        this.repo = repo;
    }

    public List<Note> getAllNotes() {
        return repo.findAll();
    }

    public Note createNote(Note note) {
        return repo.save(note);
    }

    public void deleteNote(Long id) {
        repo.deleteById(id);
    }
}