import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Basehttp {
  late final Dio client;
  Basehttp() {
    client = Dio(
      BaseOptions(
        baseUrl: "http://localhost:8080/",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {"Content-type": "application/json"},
      ),
    );
    _addInterceptors();
  }
  void _addInterceptors() {
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          String? token = null;
          if (token != null) {
            options.headers['Authorization'] = "Bearer $token";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },

        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );
  }
}
