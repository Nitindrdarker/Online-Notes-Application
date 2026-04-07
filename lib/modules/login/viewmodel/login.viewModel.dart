import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/injection.dart';
import 'package:online_todo/modules/db.dart';
import 'package:online_todo/modules/login/services/login.service.dart';
import 'package:online_todo/modules/login/stateModel/login.stateModel.dart';

class LoginViewModel extends Notifier<LoginStateModel> {
  @override
  LoginStateModel build() {
    return LoginStateModel();
  }

  Future<bool> login(String userName, String password) async {
    bool response = await getIt<LoginService>().login(userName, password);
    state = LoginStateModel(token: jwtToken);
    return response;
  }

  Future<void> register(String userName, String password) async {
    getIt<LoginService>().register(userName, password);
    state = LoginStateModel(userName: userName);
  }
}
