import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/provider/home.provider.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class NotePage extends ConsumerStatefulWidget {
  final Notes? note;
  const NotePage({super.key, this.note});

  @override
  ConsumerState<NotePage> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  late StompClient stompClient;
  bool isRemoteUpdate = false;
  Timer? _debounce;

  void connectSocket() {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'http://localhost:8080/ws',
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
      destination: '/topic/notes/${widget.note?.id}',
      callback: (frame) {
        final data = jsonDecode(frame.body!);

        isRemoteUpdate = true;

        titleController.text = data['title'];
        contentController.text = data['content'];

        isRemoteUpdate = false;
      },
    );
  }

  void listenToChanges() {
    titleController.addListener(sendUpdate);
    contentController.addListener(sendUpdate);
  }

  void sendUpdate() {
    if (isRemoteUpdate) return;

    if (!stompClient.connected) return; // ✅ ADD THIS

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (!stompClient.connected) return; // extra safety
      print("📤 Sending update");
      stompClient.send(
        destination: '/app/edit',
        body: jsonEncode({
          "noteId": int.parse(widget.note!.id!),
          "title": titleController.text,
          "content": contentController.text,
        }),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.note?.title ?? "");

    contentController = TextEditingController(text: widget.note?.content ?? "");

    connectSocket();
    listenToChanges();
  }

  @override
  void dispose() {
    stompClient.deactivate();
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(homeProvider.notifier);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        // already popped

        await viewModel.updateNotes(
          widget.note?.id ?? '',
          titleController.text,
          contentController.text,
        );

        // manually pop after saving
      },

      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Title Field
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Enter Title",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Note Field (Full Remaining Screen)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: contentController,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: "Enter note",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: widget.note != null
            ? null
            : FloatingActionButton(
                onPressed: () async {
                  viewModel.addNotes(
                    titleController.text,
                    contentController.text,
                  );

                  Navigator.pop(context);
                },
                child: Icon(Icons.save),
              ),
      ),
    );
  }
}
