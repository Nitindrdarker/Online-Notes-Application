# 📝 SyncNotes — Offline-First Notes App

An offline-first Notes application built using **Flutter** and **Spring Boot** that allows users to create, edit, and manage notes seamlessly without internet connectivity.

The app automatically synchronizes local changes with the backend once connectivity is restored while handling synchronization conflicts intelligently.

---

# ✨ Features

- 📴 Fully functional offline support
- 🔄 Automatic background synchronization
- ⚡ Real-time note updates
- 🧠 Intelligent conflict resolution
- 💾 Local persistence for offline access
- ☁️ Spring Boot backend integration
- 🔐 User authentication
- 🗑️ Soft delete support
- 📱 Responsive and clean Flutter UI

---

# 🏗️ Tech Stack

## Frontend
- Flutter
- flutter_bloc

## Backend
- Spring Boot
- Spring Data JPA
- REST APIs

## Database
- PostgreSQL / MySQL

## Local Storage
- SQLite / Hive

## State Management
- BLoC Architecture

---

# 🧠 Core Problem Solved

Traditional note-taking apps often fail in low-connectivity environments.

This project implements an **offline-first architecture** where users can continue interacting with the application even without internet access.

When connectivity is restored:
- Local changes are synced automatically
- Conflicts are detected and resolved
- Data consistency is maintained between client and server

---

# ⚙️ System Architecture

```text
                ┌────────────────┐
                │   Flutter App  │
                └───────┬────────┘
                        │
         Offline Reads/Writes
                        │
                        ▼
                ┌────────────────┐
                │ Local Database │
                │ SQLite / Hive  │
                └───────┬────────┘
                        │
             Sync Engine / Queue
                        │
                        ▼
                ┌────────────────┐
                │ Spring Boot API│
                └───────┬────────┘
                        │
                        ▼
                ┌────────────────┐
                │ PostgreSQL DB  │
                └────────────────┘
```

---
