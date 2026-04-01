import 'package:injectable/injectable.dart';
import 'package:online_todo/BaseHttp.dart';
import 'package:online_todo/modules/home/models/notes.dart';
import 'package:online_todo/modules/home/repository/notes.repository.dart';
import 'package:online_todo/urls.dart';

@lazySingleton
class NotesService {
  final Basehttp http;
  NotesService(this.http);

  Future<void> addNotes(Notes note) async {
    final url = Urls.notes;
    final response = await http.client.post(url, data: note.toJson());
  }

  Future<void> deleteNotes(String id) async {
    final url = "${Urls.notes}/$id";
    final response = await http.client.delete(url);
  }

  Future<void> updateNotes(Notes note) async {
    final url = "${Urls.notes}/${note.id}";
    final response = await http.client.put(url, data: note.toJson());
  }

  Future<NotesResponse> fetchNotes() async {
    final url = Urls.notes;
    final response = await http.client.get(url);
    return NotesResponse.fromJson(response.data);
  }
}
