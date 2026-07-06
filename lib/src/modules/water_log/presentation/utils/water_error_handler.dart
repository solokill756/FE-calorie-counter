import 'package:dio/dio.dart';

/// Maps exceptions from the water tracking feature to user-friendly messages.
String mapWaterError(dynamic e) {
  if (e is DioException) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out, please try again.';
      case DioExceptionType.connectionError:
        return 'Network error, please check your connection.';
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 400) {
          return 'Invalid input. Please check your amount and try again.';
        }
        if (e.response?.statusCode == 401) {
          return 'Session expired. Please log in again.';
        }
        return 'Server error, please try again later.';
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      default:
        return 'Something went wrong, please try again.';
    }
  }
  return 'Something went wrong, please try again.';
}
