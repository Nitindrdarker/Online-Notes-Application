# 📝 SyncNotes — Offline-First Notes App

A real-time collaborative Notes application built using Flutter, Spring Boot, and STOMP WebSockets that enables multiple users to create, edit, and collaborate on notes simultaneously.

The application instantly propagates note updates to all connected users through WebSocket communication, ensuring a seamless and synchronized collaboration experience without requiring manual refreshes.

---

# ✨ Features


-Real-time note synchronization across multiple users
-Collaborative editing with instant updates
-STOMP-based publish/subscribe messaging architecture
-WebSocket-powered low-latency communication
-Persistent note storage using PostgreSQL
-Reactive Flutter UI with live data updates
-Scalable Spring Boot backend architecture

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
