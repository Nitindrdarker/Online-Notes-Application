import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/page/note.page.dart';
import 'package:online_todo/modules/home/provider/home.provider.dart';
import 'package:online_todo/modules/home/widget/notes_card.widget.dart';
import 'package:online_todo/modules/login/page/login.page.dart';
import 'package:online_todo/modules/profile/page/profile.page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginRegisterPage()),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) {
          return Center(child: Text("Service Unavalible"));
        },

        data: (data) {
          return ListView.builder(
            itemCount: data.notes.length,
            itemBuilder: (context, index) {
              final note = data.notes[index];
              return NoteCardWidget(note: note);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
