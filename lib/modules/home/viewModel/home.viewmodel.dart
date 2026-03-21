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

  void addNotes() async {
    final _id = UniqueKey().toString();
    final _createdAt = DateTime.now();
    final _updatedAt = DateTime.now();
    final _content = state.dialogBoxFieldNoteController.text;
    final _title = state.dialogBoxFieldTitleController.text;
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

  void updateNotes(Notes notes) async {
    getIt<NotesService>().updateNotes(notes);
    fetchNotes();
  }

  void fetchNotes({String? id}) async {
    final lists = await getIt<NotesService>().fetchNotes();
    state = state.copyWith(notes: lists);
  }
}
