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
    final response = await getIt<NotesService>().fetchNotes(page: 0);

    return HomeStateModel(
      notes: response.notes,
      page: 1,
      hasMore: response.notes.isNotEmpty,
      isLoadingMore: false,
    );
  }

  // ✅ PAGINATION (LOAD MORE)
  Future<void> fetchMore() async {
    final current = state.valueOrNull;

    if (current == null || current.isLoadingMore || !current.hasMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    final response = await getIt<NotesService>().fetchNotes(page: current.page);

    final newNotes = response.notes;

    state = AsyncData(
      current.copyWith(
        notes: [...current.notes, ...newNotes],
        page: current.page + 1,
        hasMore: newNotes.isNotEmpty,
        isLoadingMore: false,
      ),
    );
  }

  Future<void> addNotes(String title, String content) async {
    final now = DateTime.now();

    final newNote = await getIt<NotesService>().addNotes(
      Notes(title: title, content: content, createdAt: now, updatedAt: now),
    );

    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncData(current.copyWith(notes: [newNote, ...current.notes]));
  }

  // ✅ DELETE NOTE (NO INVALIDATE)
  Future<void> deleteNotes(String id) async {
    await getIt<NotesService>().deleteNotes(id);

    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncData(
      current.copyWith(notes: current.notes.where((e) => e.id != id).toList()),
    );
  }

  // ✅ UPDATE NOTE (NO INVALIDATE)
  Future<void> updateNotes(String id, String title, String content) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final index = current.notes.indexWhere((e) => e.id == id);
    if (index == -1) return;

    final updated = current.notes[index].copyWith(
      title: title,
      content: content,
      updatedAt: DateTime.now(),
    );

    final saved = await getIt<NotesService>().updateNotes(updated);

    final updatedList = [...current.notes];
    updatedList[index] = saved;

    state = AsyncData(current.copyWith(notes: updatedList));
  }
}
