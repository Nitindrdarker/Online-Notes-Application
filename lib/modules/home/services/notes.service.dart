import 'package:injectable/injectable.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/repository/notes.repository.dart';

@lazySingleton
class NotesService {
  void addNotes(Notes note) {
    Future.delayed(Duration(seconds: 2));
    notes.add(note);
  }

  void deleteNotes(String id) {
    Future.delayed(Duration(seconds: 2));
    notes.removeWhere((ele) => ele.id == id);
  }

  void updateNotes(Notes note) {
    Future.delayed(Duration(seconds: 2));
    final index = notes.indexWhere((element) => element.id == note.id);
    if (index == -1) {
      addNotes(note);
    } else {
      notes[index] = note;
    }
  }

  Future<List<Notes>> fetchNotes() async {
    Future.delayed(Duration(seconds: 2));
    return notes;
  }
}
