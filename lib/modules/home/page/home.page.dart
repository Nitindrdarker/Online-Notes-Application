import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/page/note.page.dart';
import 'package:online_todo/modules/home/provider/home.provider.dart';
import 'package:online_todo/modules/home/widget/notes_card.widget.dart';
import 'package:online_todo/modules/login/page/login.page.dart';
import 'package:online_todo/modules/profile/page/profile.page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        ref.read(homeProvider.notifier).fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
        ],
      ),

      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => const Center(child: Text("Service Unavailable")),

        data: (data) {
          return ListView.builder(
            controller: _controller,
            itemCount: data.notes.length + 1,
            itemBuilder: (context, index) {
              if (index < data.notes.length) {
                return NoteCardWidget(note: data.notes[index]);
              } else {
                return data.isLoadingMore
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox();
              }
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
