import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/injection.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/services/notes.service.dart';
import 'package:online_todo/modules/home/stateModel/home.state.model.dart';

class HomeViewModel extends Notifier<HomeStateModel> {
  @override
  HomeStateModel build() {
    return HomeStateModel();
  }

  Future<void> addNotes(String title, String content) async {
    final _id = UniqueKey().toString();
    final _createdAt = DateTime.now();
    final _updatedAt = DateTime.now();
    final _content = content;
    final _title = title;
    getIt<NotesService>().addNotes(
      Notes(
        id: _id,
        title: _title,
        content: _content,
        createdAt: _createdAt,
        updatedAt: _updatedAt,
      ),
    );
    fetchNotes();
  }

  void deleteNotes(String id) async {
    getIt<NotesService>().deleteNotes(id);
    fetchNotes();
  }

  Future<void> updateNotes(String? id, String title, String content) async {
    if (id == null) {
      addNotes(title, content);
    } else {
      final list = state.notes;
      Notes note = list.firstWhere((ele) => ele.id == id);

      final _updatedAt = DateTime.now();
      final _content = content;
      final _title = title;
      Notes _note = Notes(
        content: _content,
        title: _title,
        id: note.id,
        updatedAt: _updatedAt,
        createdAt: note.createdAt,
      );

      getIt<NotesService>().updateNotes(_note);
      fetchNotes();
    }
  }

  void fetchNotes({String? id}) async {
    final lists = await getIt<NotesService>().fetchNotes();
    state = state.copyWith(notes: lists);
  }
}
