import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteCardWidget extends ConsumerWidget {
  const NoteCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef widget) {
    return InkWell(
      onTap: () {},
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
              "Title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text("Content"),
          ],
        ),
      ),
    );
  }
}
