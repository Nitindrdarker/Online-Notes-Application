import 'package:flutter/cupertino.dart';
import 'package:online_todo/modules/home/models/notes.dart';

class HomeStateModel {
  List<Notes> notes = [];
  TextEditingController dialogBoxFieldTitleController = TextEditingController();
  TextEditingController dialogBoxFieldNoteController = TextEditingController();

  HomeStateModel({this.notes = const []});

  HomeStateModel copyWith({List<Notes>? notes}) {
    return HomeStateModel(notes: notes ?? []);
  }
}
