import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:caloriecounter/src/core/utils/error_translator.dart';

void main() {
  group('ErrorTranslator', () {
    test('connectionTimeout returns friendly message', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );
      final message = ErrorTranslator.getMessage(exception);
      expect(message, contains('Connection timeout'));
    });

    test('receiveTimeout returns friendly message', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.receiveTimeout,
      );
      final message = ErrorTranslator.getMessage(exception);
      expect(message, contains('took too long'));
    });

    test('badResponse 401 returns session expired message', () {
      final response = Response(statusCode: 401, requestOptions: RequestOptions(path: '/test'));
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: response,
        type: DioExceptionType.badResponse,
      );
      final message = ErrorTranslator.getMessage(exception);
      expect(message, contains('session has expired'));
    });

    test('badResponse 404 returns not found message', () {
      final response = Response(statusCode: 404, requestOptions: RequestOptions(path: '/test'));
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: response,
        type: DioExceptionType.badResponse,
      );
      final message = ErrorTranslator.getMessage(exception);
      expect(message, contains('not found'));
    });

    test('badResponse 500 returns server error message', () {
      final response = Response(statusCode: 500, requestOptions: RequestOptions(path: '/test'));
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: response,
        type: DioExceptionType.badResponse,
      );
      final message = ErrorTranslator.getMessage(exception);
      expect(message, contains('Server error'));
    });

    test('unknown with "No host specified" returns network message', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.unknown,
        message: 'Error: Invalid argument(s): No host specified in URI',
      );
      final message = ErrorTranslator.getMessage(exception);
      expect(message, contains('Network issue'));
    });

    test('generic string error returns fallback message', () {
      final message = ErrorTranslator.getMessage('Some random error');
      expect(message, isNotEmpty);
    });
  });
}
