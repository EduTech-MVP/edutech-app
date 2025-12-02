import 'package:dio/dio.dart';
import 'package:edutech_app/core/api/api_consumer.dart';
import 'package:edutech_app/core/api/api_interceptors.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  late final String baseurl;

  DioConsumer({required this.dio, String? baseurl}) {
    this.baseurl = baseurl ?? dotenv.env['baseUrl'] ?? '';

    dio.options.baseUrl = this.baseurl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  // NEW METHOD: For uploading files with form-data
  Future<dynamic> postFormData(
    String path, {
    Map<String, dynamic>? data,
    String? filePath,
    String fileKey = 'image',
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      // Create FormData
      FormData formData = FormData.fromMap({
        ...?data, // Spread all text fields (message, sessionId, etc.)
      });

      // Add file if provided
      if (filePath != null && filePath.isNotEmpty) {
        final file = File(filePath);

        // Check if file exists
        if (await file.exists()) {
          final fileName = filePath.split('/').last;

          formData.files.add(
            MapEntry(
              fileKey,
              await MultipartFile.fromFile(filePath, filename: fileName),
            ),
          );
        }
      }

      final response = await dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    } catch (e) {
      rethrow;
    }
  }
}
