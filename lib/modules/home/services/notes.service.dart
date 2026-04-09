import 'package:injectable/injectable.dart';
import 'package:online_todo/BaseHttp.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/repository/notes.repository.dart';
import 'package:online_todo/urls.dart';
import 'package:injectable/injectable.dart';
import 'package:online_todo/BaseHttp.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/urls.dart';

@lazySingleton
class NotesService {
  final Basehttp http;
  NotesService(this.http);

  // ✅ CREATE
  Future<Notes> addNotes(Notes note) async {
    final url = Urls.notes;

    final response = await http.client.post(url, data: note.toJson());

    return Notes.fromJson(response.data);
  }

  // ✅ DELETE
  Future<void> deleteNotes(String id) async {
    final url = "${Urls.notes}/$id";
    await http.client.delete(url);
  }

  // ✅ UPDATE
  Future<Notes> updateNotes(Notes note) async {
    final url = "${Urls.notes}/${note.id}";

    final response = await http.client.put(url, data: note.toJson());

    return Notes.fromJson(response.data);
  }

  // ✅ FETCH WITH PAGINATION 🔥
  Future<NotesResponse> fetchNotes({int page = 0, int pageSize = 10}) async {
    final url = Urls.notes;

    final response = await http.client.get(
      url,
      queryParameters: {"page": page, "pageSize": pageSize},
    );

    return NotesResponse.fromJson(response.data);
  }
}
