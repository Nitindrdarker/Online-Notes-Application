import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      username = response.data["username"];
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> register(String userName, String password) async {
    try {
      final url = Urls.register;
      final response = await http.client.post(
        url,
        data: {"username": userName, "password": password},
      );
      if (response.statusCode == 200) {
        return null;
      } else {
        return response.data.toString();
      }
    } catch (e) {
      if (e is DioException) {
        return e.response?.data.toString();
      }
      return "Somthing went wrong";
    }
  }
}
