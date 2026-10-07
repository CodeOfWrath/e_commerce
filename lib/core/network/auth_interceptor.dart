// lib/core/network/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final box = Hive.box('auth');
    final token = box.get('accessToken');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final box = Hive.box('auth');
      final refreshToken = box.get('refreshToken');
      if (refreshToken != null) {
        try {
          final dio = Dio(BaseOptions(baseUrl: 'https://example.com/api'));
          final response = await dio.post('/auth/refresh', data: {
            'refreshToken': refreshToken,
          });
          final newToken = response.data['accessToken'];
          box.put('accessToken', newToken);

          final retryRequest = await dio.request(
            err.requestOptions.path,
            options: Options(
              method: err.requestOptions.method,
              headers: {
                ...err.requestOptions.headers,
                'Authorization': 'Bearer $newToken',
              },
            ),
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          return handler.resolve(retryRequest);
        } catch (_) {
          box.delete('accessToken');
          box.delete('refreshToken');
        }
      }
    }
    super.onError(err, handler);
  }
}
