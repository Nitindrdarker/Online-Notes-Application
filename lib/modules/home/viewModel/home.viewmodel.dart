import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/injection.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/repository/notes.repository.dart';
import 'package:online_todo/modules/home/services/notes.service.dart';
import 'package:online_todo/modules/home/stateModel/home.state.model.dart';

class HomeViewModel extends AsyncNotifier<HomeStateModel> {
  @override
  Future<HomeStateModel> build() async {
    final response = await getIt<NotesService>().fetchNotes();
    return HomeStateModel(notes: response.notes);
  }

  Future<void> addNotes(String title, String content) async {
    final _id = UniqueKey().toString();
    final _createdAt = DateTime.now();
    final _updatedAt = DateTime.now();
    final _content = content;
    final _title = title;
    await getIt<NotesService>().addNotes(
      Notes(
        id: _id,
        title: _title,
        content: _content,
        createdAt: _createdAt,
        updatedAt: _updatedAt,
      ),
    );
    ref.invalidateSelf();
  }

  void deleteNotes(String id) async {
    await getIt<NotesService>().deleteNotes(id);
    ref.invalidateSelf();
  }

  Future<void> updateNotes(String? id, String title, String content) async {
    if (id == null) {
      await addNotes(title, content);
      return;
    }

    final current = state.valueOrNull;
    if (current == null) return;

    final note = current.notes.firstWhere((e) => e.id == id);

    final updated = note.copyWith(
      title: title,
      content: content,
      updatedAt: DateTime.now(),
    );

    await getIt<NotesService>().updateNotes(updated);

    ref.invalidateSelf();
  }

  // in case of normal notifier
  // void fetchNotes({String? id}) async {
  //   NotesResponse lists = await getIt<NotesService>().fetchNotes();
  //   state = state.copyWith(notes: lists.notes);
  // }
}
