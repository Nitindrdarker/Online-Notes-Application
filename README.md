# 📝 SyncNotes — Offline-First Notes App

An offline-first Notes application built using **Flutter** and **Spring Boot** that allows users to create, edit, and manage notes seamlessly without internet connectivity.

The app automatically synchronizes local changes with the backend once connectivity is restored while handling synchronization conflicts intelligently.

---

# ✨ Features


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
- RiverPod

## Backend
- Spring Boot
- Spring Data JPA
- REST APIs
- Stomp

## Database
- PostgreSQL / MySQL


## State Management
- RiverPod Architecture

---

# 🧠 Core Problem Solved
Traditional note-taking applications are designed for single-user interactions and require manual refreshes to view updates from others.

This project implements a real-time collaborative note-taking system where multiple users can simultaneously edit and view notes with instant synchronization across all connected clients.

When a user updates a note:

Changes are broadcast instantly to all collaborators
Updates are reflected in real time without page refreshes
WebSocket connections maintain low-latency communication
Data consistency is maintained across all active sessions
# ⚙️ System Architecture
                ┌────────────────┐
                │   Flutter App  │
                └───────┬────────┘
                        │
              STOMP over WebSocket
                        │
                        ▼
                ┌────────────────┐
                │ Spring Boot    │
                │ WebSocket API  │
                │ (STOMP Broker) │
                └───────┬────────┘
                        │
          Broadcast Note Updates
                        │
                        ▼
                ┌────────────────┐
                │ Collaboration  │
                │   Service      │
                └───────┬────────┘
                        │
                        ▼
                ┌────────────────┐
                │ PostgreSQL DB  │


```

---
