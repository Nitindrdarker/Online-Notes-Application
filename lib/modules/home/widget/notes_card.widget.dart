import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/page/note.page.dart';
import 'package:online_todo/modules/home/provider/home.provider.dart';
import 'package:online_todo/modules/home/viewModel/home.viewmodel.dart';

class NoteCardWidget extends ConsumerWidget {
  final Notes note;
  const NoteCardWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(homeProvider.notifier);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotePage(note: note)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 24, left: 16, right: 16),
        height: 88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  Text(note.content),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                viewModel.deleteNotes(note.id ?? '');
              },
              icon: Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}
