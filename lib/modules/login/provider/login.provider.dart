import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/login/stateModel/login.stateModel.dart';
import 'package:online_todo/modules/login/viewmodel/login.viewModel.dart';

final loginProvider = NotifierProvider<LoginViewModel, LoginStateModel>(
  () => LoginViewModel(),
);
