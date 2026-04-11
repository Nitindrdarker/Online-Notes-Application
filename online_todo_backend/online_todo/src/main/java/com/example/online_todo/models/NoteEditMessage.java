package com.example.online_todo.models;

public class NoteEditMessage {

    private Long noteId;
    private String title;
    private String content;

    public Long getNoteId() {          // ✅ FIXED
        return noteId;
    }

    public void setNoteId(Long noteId) {  // ✅ FIXED
        this.noteId = noteId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}