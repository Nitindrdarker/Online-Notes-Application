package com.example.online_todo.services;

import org.springframework.stereotype.Service;

import com.example.online_todo.models.Note;
import com.example.online_todo.models.User;
import com.example.online_todo.repository.NoteRepository;
import com.example.online_todo.repository.UserRepository;

import java.util.List;

@Service
public class NoteService {

    private final NoteRepository repo;
    private final UserRepository userRepo;

    public NoteService(NoteRepository repo,  UserRepository userRepo) {
        this.repo = repo;
        this.userRepo = userRepo;
    }

public List<Note> getAllNotes(String username) {

    User user = userRepo.findByUsername(username)
            .orElseThrow(() -> new RuntimeException("User not found"));

    return repo.findAll()
            .stream()
            .filter(note -> note.getUser().getId().equals(user.getId()))
            .toList();
}

    public Note createNote(Note note, String userName) {
            User user = userRepo.findByUsername(userName)
            .orElseThrow(() -> new RuntimeException("User not found"));

    note.setUser(user);

    return repo.save(note);
    }

    public void deleteNote(Long id) {
        repo.deleteById(id);
    }


    public Note updateNote(Long id, String title, String content, String updateAt) {

    Note existingNote = repo.findById(id)
            .orElseThrow(() -> new RuntimeException("Note not found with id: " + id));

    existingNote.setTitle(title);
    existingNote.setContent(content);
    existingNote.setUpdatedAt(updateAt);

    return repo.save(existingNote);
}
    
}