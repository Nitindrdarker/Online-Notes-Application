package com.example.online_todo.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.example.online_todo.models.Note;
import com.example.online_todo.models.NoteEditMessage;
import com.example.online_todo.models.User;
import com.example.online_todo.repository.NoteRepository;
import com.example.online_todo.repository.UserRepository;

import java.util.List;

@Service
public class NoteService {

    private final NoteRepository repo;
    private final UserRepository userRepo;
    private SimpMessagingTemplate messagingTemplate;

    public NoteService(NoteRepository repo, UserRepository userRepo, SimpMessagingTemplate messagingTemplate) {
        this.repo = repo;
        this.userRepo = userRepo;
        this.messagingTemplate = messagingTemplate;
    }

    private User getUser(String username) {
        return userRepo.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));
    }

    // ✅ Get only user's notes (DB level)
    public List<Note> getAllNotes(String username, int page, int pagesize) {
        User user = getUser(username);
        Page<Note> notes = repo.findByUser(user, PageRequest.of(page, pagesize, Sort.by("updatedAt").descending()));
        return notes.getContent();
    }

    // ✅ Create note for user
    public Note createNote(Note note, String username) {
        User user = getUser(username);
        note.setUser(user);
        return repo.save(note);
    }

    // ✅ Secure delete
    public void deleteNote(Long id, String username) {
        User user = getUser(username);

        Note note = repo.findByIdAndUser(id, user)
                .orElseThrow(() -> new RuntimeException("Note not found"));

        repo.delete(note);
    }

    // ✅ Secure update
    public Note updateNote(Long id, String title, String content, String updatedAt, String username) {
        User user = getUser(username);

        Note note = repo.findByIdAndUser(id, user)
                .orElseThrow(() -> new RuntimeException("Note not found"));

        note.setTitle(title);
        note.setContent(content);
        note.setUpdatedAt(updatedAt);

        return repo.save(note);
    }


    public void broadcastEdit(NoteEditMessage msg) {

    messagingTemplate.convertAndSend(
        "/topic/notes/" + msg.getNoteId(),
        msg
    );
}


}