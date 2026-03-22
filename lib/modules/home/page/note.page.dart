import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/provider/home.provider.dart';

class NotePage extends ConsumerWidget {
  final Notes? note;
  const NotePage({super.key, this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Title Field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: viewModel.getTitleController(note),
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
                  controller: viewModel.getFieldController(note),
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
          await viewModel.updateNotes(note?.id);
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
