package com.example.online_todo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

import com.example.online_todo.models.Note;
import com.example.online_todo.models.User;

public interface NoteRepository extends JpaRepository<Note, Long> {

    // ✅ Get all notes of a specific user (DB-level filtering)
    Page<Note> findByUser(User user, Pageable pageable);

    // ✅ Secure fetch (used for update/delete)
    Optional<Note> findByIdAndUser(Long id, User user);
}