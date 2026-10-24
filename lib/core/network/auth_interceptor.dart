import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class AuthInterceptor extends Interceptor {
  static const String authBoxName = 'auth';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Hive.isBoxOpen(authBoxName)) {
      final box = Hive.box(authBoxName);
      final token = box.get('accessToken');
      if (token != null && token.toString().isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && Hive.isBoxOpen(authBoxName)) {
      final box = Hive.box(authBoxName);
      final refreshToken = box.get('refreshToken');

      if (refreshToken != null && refreshToken.toString().isNotEmpty) {
        try {
          final dio = Dio(
            BaseOptions(
              baseUrl: 'https://dummyjson.com',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

          final response = await dio.post(
            '/auth/refresh',
            data: {
              'refreshToken': refreshToken,
              'expiresInMins': 60,
            },
          );

          if (response.statusCode == 200 && response.data != null) {
            final newAccessToken = response.data['accessToken'];
            final newRefreshToken = response.data['refreshToken'] ?? refreshToken;

            await box.put('accessToken', newAccessToken);
            await box.put('refreshToken', newRefreshToken);

            final retryOptions = err.requestOptions;
            retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            final retryResponse = await dio.fetch(retryOptions);
            return handler.resolve(retryResponse);
          }
        } catch (_) {
          await box.delete('accessToken');
          await box.delete('refreshToken');
          await box.delete('user');
        }
      }
    }
    super.onError(err, handler);
  }
}
