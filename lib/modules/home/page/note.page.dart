import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/provider/home.provider.dart';

class NotePage extends ConsumerStatefulWidget {
  final Notes? note;
  const NotePage({super.key, this.note});

  @override
  ConsumerState<NotePage> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.note?.title ?? "");

    contentController = TextEditingController(text: widget.note?.content ?? "");
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(homeProvider.notifier);
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await viewModel.updateNotes(
            widget.note?.id,
            titleController.text,
            contentController.text,
          );
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
