import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/stateModel/home.state.model.dart';

class HomeViewModel extends Notifier<HomeStateModel> {
  @override
  HomeStateModel build() {
    return HomeStateModel();
  }

  void addNotes() {}

  void deleteNotes() {}

  void updateNotes() {}

  void fetchNotes() {}
}
