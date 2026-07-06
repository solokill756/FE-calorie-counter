import 'package:caloriecounter/src/core/data/local/storage.dart';
import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/core/data/remote/services/api_service.dart';
import 'package:caloriecounter/src/modules/auth/data/models/login_request.dart';
import 'package:caloriecounter/src/modules/auth/data/models/login_response.dart';
import 'package:caloriecounter/src/modules/auth/data/models/register_request.dart';
import 'package:caloriecounter/src/modules/auth/data/models/register_response.dart';
import 'package:caloriecounter/src/modules/auth/data/auth_me_json_mapper.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../domain/repository/auth_repository.dart';
import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_cubit.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthRepositoryImpl(this._dio);

  @override
  Future<Result<RegisterResponse, ApiError>> signUp({
    required RegisterRequest request,
  }) async {
    return _dio.post('auth/register', data: request.toJson()).tryGet((
      response,
    ) {
      final RegisterResponse registerResponse = RegisterResponse.fromJson(
        response.data,
      );
      return registerResponse;
    });
  }

  @override
  Future<void> signOut() async {
    try {
      await _dio.post('auth/logout-all');
    } catch (_) {
      // Keep local logout resilient even if backend revocation fails.
    }

    await Storage.removeAccessToken();
    await Storage.removeRefreshToken();
    await Storage.setUserID(null);
    await Storage.setUserProfile(null);
    await Storage.setIsProfileComplete(false);
    getIt<UserProfileCubit>().clear();
    return Future.value();
  }

  @override
  Future<Result<LoginResponse, ApiError>> signIn(LoginRequest loginRequest) {
    return _dio.post('auth/login', data: loginRequest.toJson()).tryGet((
      response,
    ) {
      final LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      return loginResponse;
    });
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> forgotPassword(String email) {
    return _dio
        .post<Map<String, dynamic>>(
          'auth/forgot-password',
          data: {'email': email},
        )
        .tryGet((response) => response.data ?? <String, dynamic>{});
  }

  @override
  Future<Result<bool, ApiError>> resetPassword({
    required String token,
    required String newPassword,
  }) {
    return _dio
        .post<Map<String, dynamic>>(
          'auth/reset-password',
          data: {'token': token, 'newPassword': newPassword},
        )
        .tryGet((response) {
          final data = response.data ?? <String, dynamic>{};
          return data['success'] == true;
        });
  }

  @override
  Future<Result<LoginResponse, ApiError>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return Future.value(
          Result.failure(ApiError(400, 'User cancelled Google sign-in')),
        );
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      User? user = userCredential.user;
      if (user == null) {
        return Future.value(
          Result.failure(ApiError(500, 'Firebase sign-in failed')),
        );
      }
      final String? firebaseIdToken = await user.getIdToken();
      if (firebaseIdToken == null || firebaseIdToken.isEmpty) {
        return Future.value(
          Result.failure(ApiError(500, 'Unable to obtain Firebase ID token')),
        );
      }
      return _dio
          .post(
            'auth/oauth/google',
            data: {'idToken': firebaseIdToken, 'deviceInfo': 'mobile-google'},
          )
          .tryGet((response) {
            final LoginResponse loginResponse = LoginResponse.fromJson(
              response.data,
            );
            return loginResponse;
          });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Google sign-in error: $e');
      }
      return Future.value(
        Result.failure(ApiError(500, 'Google sign-in failed')),
      );
    }
  }

  @override
  Future<Result<bool, ApiError>> deleteAccount() {
    return _dio.delete<Map<String, dynamic>>('users/me').tryGet((_) => true);
  }

  @override
  Future<Result<UserProfileModel, ApiError>> getUserProfile() {
    return _dio.get('auth/me').tryGet((response) {
      return userProfileFromAuthMeJson(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<Result<UserProfileModel, ApiError>> patchProfile({
    String? displayName,
    String? email,
    String? newPassword,
    String? avatarUrl,
  }) {
    final data = <String, dynamic>{};
    if (displayName != null) {
      data['displayName'] = displayName;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (newPassword != null && newPassword.isNotEmpty) {
      data['newPassword'] = newPassword;
    }
    if (avatarUrl != null) {
      data['avatarUrl'] = avatarUrl;
    }
    return _dio
        .patch<Map<String, dynamic>>('users/profile', data: data)
        .tryGet(
          (response) =>
              userProfileFromAuthMeJson(response.data as Map<String, dynamic>),
        );
  }

  @override
  Future<Result<UserProfileModel, ApiError>> patchUserGoal({
    required String goalTypeSlug,
  }) {
    return _dio
        .patch<Map<String, dynamic>>(
          'users/goal',
          data: <String, dynamic>{'goalType': goalTypeSlug},
        )
        .tryGet(
          (response) =>
              userProfileFromAuthMeJson(response.data as Map<String, dynamic>),
        );
  }

  @override
  Future<Result<LoginResponse, ApiError>> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        oauthCredential,
      );
      final user = userCredential.user;

      if (user == null) {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_USER',
          message: 'No user returned from Apple sign-in',
        );
      }
      final String? firebaseIdToken = await user.getIdToken();
      if (firebaseIdToken == null || firebaseIdToken.isEmpty) {
        return Future.value(
          Result.failure(ApiError(500, 'Unable to obtain Firebase ID token')),
        );
      }
      return _dio
          .post(
            'auth/oauth/apple',
            data: {'idToken': firebaseIdToken, 'deviceInfo': 'mobile-apple'},
          )
          .tryGet((response) {
            final loginResponse = LoginResponse.fromJson(response.data);
            return loginResponse;
          });
    } on SignInWithAppleAuthorizationException catch (e) {
      if (kDebugMode) {
        debugPrint('🚨 Apple Auth Exception:');
        debugPrint('   - Code: ${e.code}');
        debugPrint('   - Message: ${e.message}');
      }
      return Result.failure(ApiError(400, 'Apple error: ${e.message}'));
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        debugPrint('🚨 Firebase Auth Exception:');
        debugPrint('   - Code: ${e.code}');
        debugPrint('   - Message: ${e.message}');
        debugPrint('   - Details: ${e.stackTrace}');
      }
      return Result.failure(ApiError(500, 'Firebase error: ${e.message}'));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('🚨 Unknown Error: $e');
        debugPrint('Stack trace: $stackTrace');
      }
      return Result.failure(ApiError(500, 'Error: $e'));
    }
  }
}
