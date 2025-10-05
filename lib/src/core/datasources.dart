import 'package:dio/dio.dart';

class ApiClient {
  ApiClient({Dio? dio, String? baseUrl})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl ?? defaultBaseUrl));

  static const String defaultBaseUrl =
      'http://127.0.0.1:8000';
  final Dio _dio;
  Dio get dio => _dio;
}

// https://jihcservfixed-production.up.railway.app