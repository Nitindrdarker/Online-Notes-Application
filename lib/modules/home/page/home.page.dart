import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/page/note.page.dart';
import 'package:online_todo/modules/home/provider/home.provider.dart';
import 'package:online_todo/modules/home/widget/notes_card.widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final viewModel = ref.read(homeProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: ListView.builder(
        itemCount: state.notes.length,
        itemBuilder: (context, index) {
          final note = state.notes[index];
          return NoteCardWidget(note: note);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotePage()),
          );
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: Text("Add Note"),
          //       content: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           TextField(
          //             controller: state.dialogBoxFieldTitleController,
          //             decoration: InputDecoration(hintText: "Enter Title"),
          //           ),
          //           TextField(
          //             controller: state.dialogBoxFieldNoteController,
          //             decoration: InputDecoration(hintText: "Enter note"),
          //           ),
          //         ],
          //       ),
          //       actions: [
          //         TextButton(
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           child: Text("Cancel"),
          //         ),
          //         ElevatedButton(
          //           onPressed: () {
          //             viewModel.addNotes();
          //             Navigator.pop(context);
          //           },
          //           child: Text("Save"),
          //         ),
          //       ],
          //     );
          //   },
          // );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
