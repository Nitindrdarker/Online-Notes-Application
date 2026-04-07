import 'package:injectable/injectable.dart';
import 'package:online_todo/BaseHttp.dart';
import 'package:online_todo/modules/db.dart';
import 'package:online_todo/urls.dart';

@lazySingleton
class LoginService {
  final Basehttp http;

  LoginService(this.http);

  Future<bool> login(String userName, String password) async {
    try {
      final url = Urls.login;
      final response = await http.client.post(
        url,
        data: {"username": userName, "password": password},
      );
      print(response);
      jwtToken = response.data["token"];
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> register(String userName, String password) async {
    final url = Urls.register;
    final response = await http.client.post(
      url,
      data: {"username": userName, "password": password},
    );
    print(response);
  }
}
