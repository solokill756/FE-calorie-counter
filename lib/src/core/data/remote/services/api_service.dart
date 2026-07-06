import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../common/utils/app_environment.dart';
import '../../../../common/extensions/optional_x.dart';
import '../base/api_error.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/error_interceptor.dart';

@module
abstract class ApiModule {
  @Named('baseUrl')
  String get baseUrl => AppEnvironment.apiUrl;

  @singleton
  Dio dio(@Named('baseUrl') String url, Talker talker) {
    final dio = Dio(
      BaseOptions(
        baseUrl: url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(seconds: AppConstants.connectTimeout),
      ),
    );

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['X-Tz-Offset-Minutes'] =
              DateTime.now().timeZoneOffset.inMinutes.toString();
          if (options.data is FormData) {
            options.headers['Content-Type'] = 'multipart/form-data';
            if (kDebugMode) {
              final formData = options.data as FormData;

              // 1. Log các fields (dạng text)
              talker.debug('--- 📤 FormData Fields ---');
              if (formData.fields.isEmpty) {
                talker.debug('No text fields.');
              } else {
                for (var entry in formData.fields) {
                  talker.debug('${entry.key}: ${entry.value}');
                }
              }

              // 2. Log thông tin các files (tên, kích thước, loại)
              talker.debug('--- 📄 FormData Files ---');
              if (formData.files.isEmpty) {
                talker.debug('No files to upload.');
              } else {
                for (var entry in formData.files) {
                  talker.debug(
                    'File Key: ${entry.key}\n'
                    'FileName: ${entry.value.filename}\n'
                    'ContentType: ${entry.value.contentType}\n'
                    'Length: ${entry.value.length} bytes',
                  );
                }
              }
              talker.debug('-------------------------');
            }
          } else {
            options.headers['Content-Type'] = 'application/json';
          }
          handler.next(options);
        },
      ),
      AuthInterceptor(
        dio,
        excludedPaths: const [
          'auth/login',
          'auth/register',
          'auth/refresh',
          'auth/oauth',
        ],
      ),
      TalkerDioLogger(
        talker: talker,
        settings: TalkerDioLoggerSettings(
          responsePen: AnsiPen()..blue(),
          // All http responses enabled for console logging
          printResponseData: true,
          // All http requests disabled for console logging
          printRequestData: true,
          // Response logs including http - headers
          printResponseHeaders: false,
          // Request logs without http - headers
          printRequestHeaders: true,
        ),
      ),
      ErrorInterceptor(),
    ]);

    return dio;
  }
}

extension FutureX<T extends Object> on Future<T> {
  Future<T> getOrThrow() async {
    try {
      return await this;
    } on ApiError {
      rethrow;
    } on DioException catch (e) {
      throw e.toApiError();
    } catch (e) {
      throw ApiError.unexpected();
    }
  }

  Future<Result<R, ApiError>> tryGet<R extends Object>(
    R Function(T) response,
  ) async {
    try {
      return response.call(await getOrThrow()).toSuccess();
    } on ApiError catch (e) {
      return e.toFailure();
    } catch (e) {
      return ApiError.unexpected().toFailure();
    }
  }

  Future<Result<R, ApiError>> tryGetFuture<R extends Object>(
    Future<R> Function(T) response,
  ) async {
    try {
      return (await response.call(await getOrThrow())).toSuccess();
    } on ApiError catch (e) {
      return e.toFailure();
    } catch (e) {
      return ApiError.unexpected().toFailure();
    }
  }
}

extension FutureResultX<T extends Object> on Future<Result<T, ApiError>> {
  Future<W> fold<W>(
    W Function(T success) onSuccess,
    W Function(ApiError failure) onFailure,
  ) async {
    try {
      final result = await getOrThrow();
      return onSuccess(result);
    } on ApiError catch (e) {
      return onFailure(e);
    }
  }
}

extension DioExceptionX on DioException {
  ApiError toApiError() {
    if (error is ApiError) {
      return error as ApiError;
    } else {
      final statusCode = response?.statusCode ?? -1;
      String? responseMessage;
      if (response?.data is Map<String, dynamic>) {
        responseMessage = response?.data?['message'];
        if (responseMessage.isNotNullOrBlank && kDebugMode) {
          responseMessage = '$responseMessage';
        }
      }
      responseMessage = responseMessage ?? 'S.Error unexpected';
      if (statusCode == 401) {
        return ApiError.unauthorized(responseMessage);
      } else if (statusCode >= 400 && statusCode < 500) {
        return ApiError.server(code: statusCode, message: responseMessage);
      } else {
        return ApiError.network(code: statusCode, message: responseMessage);
      }
    }
  }
}
