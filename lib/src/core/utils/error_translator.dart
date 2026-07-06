import 'package:dio/dio.dart';

/// Translates Dio exceptions and errors into user-friendly messages
class ErrorTranslator {
  static String getMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Connection timeout. Please check your internet connection.';
        case DioExceptionType.receiveTimeout:
          return 'Server took too long to respond. Please try again.';
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 401) {
            return 'Your session has expired. Please login again.';
          } else if (statusCode == 404) {
            return 'Resource not found.';
          } else if (statusCode == 500) {
            return 'Server error. Please try again later.';
          } else {
            return 'Something went wrong. Please try again.';
          }
        case DioExceptionType.unknown:
          if (error.message?.contains('No host specified') ?? false) {
            return 'Network issue. Please check your internet connection.';
          }
          return 'Connection error. Please try again.';
        default:
          return 'Something went wrong. Please try again.';
      }
    }
    // Fallback for non-Dio errors
    return error.toString().isNotEmpty
        ? error.toString()
        : 'An unexpected error occurred.';
  }
}
