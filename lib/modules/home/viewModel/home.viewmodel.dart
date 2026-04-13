import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/injection.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/services/notes.service.dart';
import 'package:online_todo/modules/home/stateModel/home.state.model.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class HomeViewModel extends AsyncNotifier<HomeStateModel> {
  late StompClient stompClient;
  bool isRemoteUpdate = false;
  Timer? _debounce;

  String? currentNoteId;
  String currentTitle = "";
  String currentContent = "";

  @override
  Future<HomeStateModel> build() async {
    final response = await getIt<NotesService>().fetchNotes(page: 0);

    return HomeStateModel(
      notes: response.notes,
      page: 1,
      hasMore: response.notes.isNotEmpty,
      isLoadingMore: false,
    );
  }

  // ================= SOCKET (MOVED HERE) =================

  void connectSocket(String noteId) {
    currentNoteId = noteId;

    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'http://localhost:8080/notes_socket',
        onConnect: (frame) {
          print("✅ CONNECTED");
          onConnect(frame);
        },
        onWebSocketError: (error) {
          print("❌ WS ERROR: $error");
        },
        onStompError: (frame) {
          print("❌ STOMP ERROR: ${frame.body}");
        },
      ),
    );

    stompClient.activate();
  }

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/topic/notes/$currentNoteId',
      callback: (frame) {
        final data = jsonDecode(frame.body!);

        isRemoteUpdate = true;

        currentTitle = data['title'];
        currentContent = data['content'];

        // ✅ also update list
        _updateNoteFromSocket(data);

        isRemoteUpdate = false;
      },
    );
  }

  void listenToChanges() {
    sendUpdate();
  }

  void sendUpdate() {
    if (isRemoteUpdate) return;
    if (!stompClient.connected) return;

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (!stompClient.connected) return;

      print("📤 Sending update");

      stompClient.send(
        destination: '/app/edit',
        body: jsonEncode({
          "noteId": int.parse(currentNoteId!),
          "title": currentTitle,
          "content": currentContent,
        }),
      );
    });
  }

  void disconnectSocket() {
    stompClient.deactivate();
  }

  void _updateNoteFromSocket(Map data) {
    final current = state.valueOrNull;
    if (current == null) return;

    final index = current.notes.indexWhere((e) => e.id == currentNoteId);

    if (index == -1) return;

    final updatedList = [...current.notes];

    updatedList[index] = updatedList[index].copyWith(
      title: data['title'],
      content: data['content'],
      updatedAt: DateTime.now(),
    );

    state = AsyncData(current.copyWith(notes: updatedList));
  }

  // ================= API (UNCHANGED) =================

  Future<void> fetchMore() async {
    final current = state.valueOrNull;

    if (current == null || current.isLoadingMore || !current.hasMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    final response = await getIt<NotesService>().fetchNotes(page: current.page);

    final newNotes = response.notes;

    state = AsyncData(
      current.copyWith(
        notes: [...current.notes, ...newNotes],
        page: current.page + 1,
        hasMore: newNotes.isNotEmpty,
        isLoadingMore: false,
      ),
    );
  }

  Future<void> addNotes(String title, String content) async {
    final now = DateTime.now();

    final newNote = await getIt<NotesService>().addNotes(
      Notes(title: title, content: content, createdAt: now, updatedAt: now),
    );

    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncData(current.copyWith(notes: [newNote, ...current.notes]));
  }

  Future<void> deleteNotes(String id) async {
    await getIt<NotesService>().deleteNotes(id);

    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncData(
      current.copyWith(notes: current.notes.where((e) => e.id != id).toList()),
    );
  }

  Future<void> updateNotes(String id, String title, String content) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final index = current.notes.indexWhere((e) => e.id == id);
    if (index == -1) return;

    final updated = current.notes[index].copyWith(
      title: title,
      content: content,
      updatedAt: DateTime.now(),
    );

    final saved = await getIt<NotesService>().updateNotes(updated);

    final updatedList = [...current.notes];
    updatedList[index] = saved;

    state = AsyncData(current.copyWith(notes: updatedList));
  }
}
