import 'package:dio/dio.dart';
import 'package:edutech_app/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  final data = e.response?.data ?? 'No response from server';
  final errorModel = ErrorModel.fromJson(data);

  if (e.type == DioExceptionType.badResponse) {
    // API returned a response but with error status codes
    switch (e.response?.statusCode) {
      case 400:
      case 401:
      case 403:
      case 404:
      case 409:
      case 422:
      case 504:
        throw ServerException(errorModel: errorModel);
      default:
        throw ServerException(errorModel: errorModel);
    }
  } else {
    // Network issues, timeout, cancellation, unknown, etc.
    throw ServerException(
      errorModel: ErrorModel(errorMessage: "Network error: ${e.type.name}"),
    );
  }
}
