import 'package:dio/dio.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/cache/cache_helper.dart';
import 'package:flutter/material.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Skip token for signin/signup/forgot-password/verify-reset-code
    if (options.path.contains(Endpoints.signin) ||
        options.path.contains(Endpoints.register) ||
        options.path.contains(Endpoints.forgotPassword) ||
        options.path.contains(Endpoints.verifyResetPassword)) {
      options.headers['Content-Type'] = 'application/json';
      handler.next(options);
      return;
    }

    // Use reset token for password reset endpoint
    if (options.path.contains(Endpoints.resetPassword)) {
      final resetToken = CacheHelper.getData(key: ApiKey.resetToken);
      if (resetToken != null) {
        options.headers['Authorization'] = 'Bearer $resetToken';
      }
      options.headers['Content-Type'] = 'application/json';
      handler.next(options);
      return;
    }

    final token = CacheHelper.getData(key: ApiKey.token);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Content-Type'] = 'application/json';
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      "✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}",
    );
    debugPrint("Data: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      "❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}",
    );
    debugPrint("Message: ${err.message}");
    super.onError(err, handler);
  }
}
