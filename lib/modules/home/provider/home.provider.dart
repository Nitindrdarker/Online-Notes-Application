import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/home/stateModel/home.state.model.dart';
import 'package:online_todo/modules/home/viewModel/home.viewmodel.dart';

final homeProvider = AsyncNotifierProvider<HomeViewModel, HomeStateModel>(
  () => HomeViewModel(),
);
