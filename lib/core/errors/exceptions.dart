import 'package:dio/dio.dart';
import 'package:edutech_app/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  final data = e.response?.data;
  ErrorModel errorModel;

  if (e.type == DioExceptionType.badResponse) {
    // API returned a response but with error status codes
    switch (e.response?.statusCode) {
      case 400:
        errorModel = ErrorModel(
          errorMessage: "Invalid request. Please check your input.",
        );
        break;
      case 401:
        errorModel = ErrorModel(
          errorMessage: "Unauthorized. Please log in again.",
        );
        break;
      case 403:
        errorModel = ErrorModel(
          errorMessage: "You don’t have permission to do this.",
        );
        break;
      case 404:
        errorModel = ErrorModel(
          errorMessage: "Resource not found. Please try again.",
        );
        break;
      case 409:
        errorModel = ErrorModel(
          errorMessage: "Conflict occurred. Please try again.",
        );
        break;
      case 422:
        errorModel = ErrorModel(
          errorMessage: "Validation failed. Please review your input.",
        );
        break;
      case 504:
        errorModel = ErrorModel(
          errorMessage: "Server is taking too long to respond. Try later.",
        );
        break;
      default:
        errorModel = ErrorModel.fromJson(
          data ?? {"message": "Something went wrong. Please try again."},
        );
    }
  } else {
    // Network issues, timeout, cancellation, unknown, etc.
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorModel = ErrorModel(
          errorMessage: "Connection timed out. Please check your internet.",
        );
        break;
      case DioExceptionType.connectionError:
        errorModel = ErrorModel(
          errorMessage: "No internet connection. Please check your network.",
        );
        break;
      case DioExceptionType.cancel:
        errorModel = ErrorModel(
          errorMessage: "Request was cancelled. Please try again.",
        );
        break;
      default:
        errorModel = ErrorModel(
          errorMessage: "Unexpected error. Please try again.",
        );
    }
  }

  throw ServerException(errorModel: errorModel);
}
