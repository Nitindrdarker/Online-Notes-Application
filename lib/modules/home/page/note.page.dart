import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/provider/home.provider.dart';
import 'package:online_todo/modules/home/viewModel/home.viewmodel.dart';

class NotePage extends ConsumerStatefulWidget {
  final Notes? note;
  const NotePage({super.key, this.note});

  @override
  ConsumerState<NotePage> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  late HomeViewModel vm;
  late final removeListener;
  @override
  void initState() {
    super.initState();

    vm = ref.read(homeProvider.notifier);

    titleController = TextEditingController(text: widget.note?.title ?? "");

    contentController = TextEditingController(text: widget.note?.content ?? "");

    // ✅ connect socket
    if (widget.note?.id != null) {
      vm.connectSocket(widget.note!.id!);
    }

    // ✅ listen changes (UI → VM)
    titleController.addListener(() {
      vm.currentTitle = titleController.text;
      vm.currentContent = contentController.text;
      vm.sendUpdate();
    });

    contentController.addListener(() {
      vm.currentTitle = titleController.text;
      vm.currentContent = contentController.text;
      vm.sendUpdate();
    });
    removeListener = ref.listenManual(homeProvider, (previous, next) {
      final note = next.value?.notes
          .where((e) => e.id == widget.note?.id)
          .firstOrNull;

      if (note == null) return;

      // prevent infinite loop + cursor jump
      if (titleController.text != note.title) {
        titleController.text = note.title ?? "";
      }

      if (contentController.text != note.content) {
        contentController.text = note.content ?? "";
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    vm = ref.read(homeProvider.notifier);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        // already popped

        await vm.updateNotes(
          widget.note?.id ?? '',
          titleController.text,
          contentController.text,
        );

        // manually pop after saving
        ref.read(homeProvider.notifier).disconnectSocket();
        removeListener();
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
                  vm.addNotes(titleController.text, contentController.text);

                  Navigator.pop(context);
                },
                child: Icon(Icons.save),
              ),
      ),
    );
  }
}
