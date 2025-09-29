import 'package:dio/dio.dart';

class ApiClient {
  ApiClient({Dio? dio, String? baseUrl})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl ?? defaultBaseUrl));

  // Default to production API; override with a custom baseUrl for local dev
  static const String defaultBaseUrl =
      'https://jihcservfixed-production.up.railway.app';

  final Dio _dio;

  Dio get dio => _dio;
}
