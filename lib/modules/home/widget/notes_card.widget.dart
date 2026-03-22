import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/page/note.page.dart';

class NoteCardWidget extends StatelessWidget {
  final Notes note;
  const NoteCardWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              note.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(note.content),
          ],
        ),
      ),
    );
  }
}
