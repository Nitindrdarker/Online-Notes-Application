package com.example.online_todo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.online_todo.models.Note;

public interface NoteRepository extends JpaRepository<Note, Long>{
    
    
}
