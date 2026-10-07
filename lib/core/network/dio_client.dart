// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'auth_interceptor.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://example.com/api', // à adapter
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(AuthInterceptor());

  static Dio get instance => _dio;
}
