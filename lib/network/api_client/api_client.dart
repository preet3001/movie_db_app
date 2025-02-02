import 'package:dio/dio.dart';

class ApiClient {
  ApiClient({required this.dio}) {
    dio.options.baseUrl = 'https://api.themoviedb.org/3/';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers.addAll(
      {'Authorization': 'Bearer ${const String.fromEnvironment('token')}'},
    );
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );
  }
  final Dio dio;
}
