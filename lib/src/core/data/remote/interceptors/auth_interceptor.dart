import 'dart:io';

import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_cubit.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../local/storage.dart';

/// Auth interceptor to handle authentication headers and token refresh
class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final List<String> _excludedPaths;
  Future<bool>? _refreshFuture;

  AuthInterceptor(this._dio, {List<String> excludedPaths = const []})
    : _excludedPaths = excludedPaths;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Explicitly skip auth header for requests that opt out (e.g. refresh call).
    if (options.extra['__skipAuth'] == true) {
      return handler.next(options);
    }

    // Skip adding auth header for excluded paths (like login, register)
    if (_isExcludedPath(options.path)) {
      return handler.next(options);
    }

    try {
      final accessToken = await Storage.accessToken;

      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers[HttpHeaders.authorizationHeader] =
            'Bearer $accessToken';
      }
    } catch (e) {
      if (kDebugMode) {
        print('AuthInterceptor: Failed to get access token: $e');
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final isUnauthorized = statusCode == 401 || statusCode == 403;
    final isRetry = err.requestOptions.extra['__retriedAfterRefresh'] == true;
    final skipRefresh = err.requestOptions.extra['__skipRefresh'] == true;

    // Handle 401 Unauthorized error for token refresh.
    // Avoid infinite loops and do not refresh on excluded/auth endpoints.
    if (isUnauthorized &&
        !isRetry &&
        !skipRefresh &&
        !_isExcludedPath(err.requestOptions.path)) {
      try {
        final refreshed = await _refreshTokenShared();

        if (refreshed) {
          // Retry the original request with new token
          final response = await _retryRequest(err.requestOptions);
          return handler.resolve(response);
        } else {
          // Refresh failed, clear tokens and redirect to login
          await _clearTokensAndRedirectToLogin();
        }
      } catch (e) {
        print('AuthInterceptor: Token refresh failed: $e');
        await _clearTokensAndRedirectToLogin();
      }
    }

    handler.next(err);
  }

  /// Ensure there is only one refresh request at a time.
  /// Other 401 requests await the same in-flight refresh result.
  Future<bool> _refreshTokenShared() async {
    final inFlight = _refreshFuture;
    if (inFlight != null) {
      return inFlight;
    }

    final future = _refreshToken();
    _refreshFuture = future;

    try {
      return await future;
    } finally {
      if (identical(_refreshFuture, future)) {
        _refreshFuture = null;
      }
    }
  }

  /// Check if the request path should be excluded from authentication
  bool _isExcludedPath(String path) {
    return _excludedPaths.any((excludedPath) => path.contains(excludedPath));
  }

  /// Attempt to refresh the access token using refresh token
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await Storage.refreshToken;

      if (refreshToken == null || refreshToken.isEmpty) {
        if (kDebugMode) {
          print(
            'AuthInterceptor: Refresh skipped - no refresh token in storage',
          );
        }
        return false;
      }

      const refreshCandidates = ['auth/refresh', 'api/auth/refresh'];
      for (final endpoint in refreshCandidates) {
        try {
          if (kDebugMode) {
            print('AuthInterceptor: Trying refresh endpoint: $endpoint');
          }
          // Use the same Dio instance so refresh is observable in logs,
          // but opt out of auth header + refresh handling to avoid loops.
          final response = await _dio.post(
            endpoint,
            data: {'refreshToken': refreshToken},
            options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json'},
              extra: const {'__skipAuth': true, '__skipRefresh': true},
            ),
          );

          final status = response.statusCode ?? 0;
          if (status >= 200 && status < 300) {
            final data = response.data;
            final newAccessToken = data['accessToken'] as String?;
            final newRefreshToken = data['refreshToken'] as String?;

            if (newAccessToken != null && newAccessToken.isNotEmpty) {
              await Storage.setAccessToken(newAccessToken);
              if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
                await Storage.setRefreshToken(newRefreshToken);
              }
              if (kDebugMode) {
                print('AuthInterceptor: Refresh succeeded via $endpoint');
              }
              return true;
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('AuthInterceptor: Refresh failed via $endpoint -> $e');
          }
        }
      }
    } catch (e) {
      print('AuthInterceptor: Refresh token request failed: $e');
    }

    return false;
  }

  /// Retry the original request with new access token
  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    final accessToken = await Storage.accessToken;
    requestOptions.extra['__retriedAfterRefresh'] = true;

    if (accessToken != null) {
      requestOptions.headers[HttpHeaders.authorizationHeader] =
          'Bearer $accessToken';
    }

    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        receiveTimeout: requestOptions.receiveTimeout,
        sendTimeout: requestOptions.sendTimeout,
        extra: requestOptions.extra,
      ),
    );
  }

  /// Clear tokens and handle logout logic
  Future<void> _clearTokensAndRedirectToLogin() async {
    await Storage.removeAccessToken();
    await Storage.removeRefreshToken();
    await Storage.setUserID(null);
    await Storage.setUserProfile(null);
    await Storage.setIsProfileComplete(false);
    getIt<UserProfileCubit>().clear();

    // Example using GetIt to get a router/navigation service
    final router = getIt.get<AppRouter>();
    router.replaceAll([const WelcomeRoute()]);
  }
}
