import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../../core/data/local/storage.dart';
import '../../../../../core/notifications/meal_log_reminder_service.dart';
import '../../../../../modules/notifications/presentation/application/notifications_cubit.dart';
import '../../../../../common/utils/getit_utils.dart';
import '../../../../../core/data/remote/base/api_error.dart';
import '../../../../more/presentation/application/more_cubit/more_cubit.dart';
import '../../../data/models/login_request.dart';
import '../../../data/models/register_request.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../data/onboarding_payload_mapper.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/repository/onboarding_repository.dart';
import 'user_profile_cubit.dart';
part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final OnboardingRepository onboardingRepository;
  final MoreCubit _moreCubit;
  final UserProfileCubit _userProfileCubit;

  AuthCubit({
    required this.authRepository,
    required this.onboardingRepository,
    required MoreCubit moreCubit,
    required UserProfileCubit userProfileCubit,
  }) : _moreCubit = moreCubit,
       _userProfileCubit = userProfileCubit,
       super(AuthState.initial());

  Future<void> _finishAuthSession() async {
    unawaited(_userProfileCubit.refresh());
    await _moreCubit.loadMoreData();
    unawaited(MealLogReminderService.instance.scheduleRollingWindow());
    unawaited(getIt<NotificationsCubit>().refresh());
  }

  Future<void> _persistAuthSession({
    required String accessToken,
    required String refreshToken,
    required int userId,
    required bool isProfileComplete,
    String? displayName,
    String? avatarUrl,
  }) async {
    await Storage.setAccessToken(accessToken);
    await Storage.setRefreshToken(refreshToken);
    await Storage.setUserID(userId);
    await Storage.setUserProfile(
      UserProfileModel(
        displayName: displayName ?? '',
        avatarUrl: avatarUrl,
        isProfileComplete: isProfileComplete,
      ),
    );
    await Storage.setIsProfileComplete(isProfileComplete);
  }

  Future<void> loginGoogle() async {
    emit(const AuthState.loading());
    final result = await authRepository.signInWithGoogle();
    result.fold(
      (loginResponse) async {
        await _persistAuthSession(
          accessToken: loginResponse.accessToken,
          refreshToken: loginResponse.refreshToken,
          userId: loginResponse.userId,
          isProfileComplete: loginResponse.isProfileComplete,
          displayName: loginResponse.displayName,
          avatarUrl: loginResponse.userImage,
        );
        await _finishAuthSession();
        emit(AuthState.authenticated('Google login successful'));
      },
      (error) {
        if (kDebugMode) {
          print('Google login error: ${error.message}');
        }
        String errorMessage = 'Google login failed';

        if (error.message.contains('cancelled')) {
          errorMessage = 'Google sign-in was cancelled';
        } else if (error.message.contains('network')) {
          errorMessage = 'Network error. Please check your connection';
        }

        emit(AuthState.error(errorMessage));
      },
    );
  }

  Future<void> loginApple() async {
    emit(const AuthState.loading());
    final result = await authRepository.signInWithApple();
    result.fold(
      (loginResponse) async {
        await _persistAuthSession(
          accessToken: loginResponse.accessToken,
          refreshToken: loginResponse.refreshToken,
          userId: loginResponse.userId,
          isProfileComplete: loginResponse.isProfileComplete,
          displayName: loginResponse.displayName,
          avatarUrl: loginResponse.userImage,
        );
        await _finishAuthSession();
        emit(AuthState.authenticated('Apple login successful'));
      },
      (error) {
        if (kDebugMode) {
          print('Apple login error: ${error.message}');
        }
        String errorMessage = 'Apple login failed';

        if (error.message.contains('cancelled')) {
          errorMessage = 'Apple sign-in was cancelled';
        } else if (error.message.contains('network')) {
          errorMessage = 'Network error. Please check your connection';
        }

        emit(AuthState.error(errorMessage));
      },
    );
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());
    final RegisterRequest request = RegisterRequest(
      email: email,
      password: password,
    );
    final result = await authRepository.signUp(request: request);
    result.fold(
      (registerResponse) async {
        await _persistAuthSession(
          accessToken: registerResponse.accessToken,
          refreshToken: registerResponse.refreshToken,
          userId: registerResponse.userId,
          isProfileComplete: registerResponse.isProfileComplete,
          displayName: registerResponse.displayName,
          avatarUrl: registerResponse.userImage,
        );
        await _finishAuthSession();
        emit(AuthState.registered('Registration successful'));
      },
      (error) {
        if (kDebugMode) {
          print('Registration error: ${error.message}');
        }
        // Ưu tiên hiển thị message từ BE, fallback nếu rỗng
        final errorMessage = error.message.isNotEmpty
            ? error.message
            : 'Registration failed';
        emit(AuthState.error(errorMessage));
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthState.loading());
    final result = await authRepository.signIn(
      LoginRequest(email: email, password: password),
    );
    result.fold(
      (loginResponse) async {
        await _persistAuthSession(
          accessToken: loginResponse.accessToken,
          refreshToken: loginResponse.refreshToken,
          userId: loginResponse.userId,
          isProfileComplete: loginResponse.isProfileComplete,
          displayName: loginResponse.displayName,
          avatarUrl: loginResponse.userImage,
        );
        await _finishAuthSession();
        emit(AuthState.authenticated('Login successful'));
      },
      (error) {
        if (kDebugMode) {
          print('Login error: ${error.message}');
        }
        // Ưu tiên hiển thị message từ BE, fallback nếu rỗng
        final errorMessage = error.message.isNotEmpty
            ? error.message
            : 'Login failed';
        emit(AuthState.error(errorMessage));
      },
    );
  }

  Future<Result<Map<String, dynamic>, ApiError>> forgotPassword({
    required String email,
  }) {
    return authRepository.forgotPassword(email);
  }

  Future<Result<bool, ApiError>> resetPassword({
    required String token,
    required String newPassword,
  }) {
    return authRepository.resetPassword(token: token, newPassword: newPassword);
  }

  Future<Result<Map<String, dynamic>, ApiError>> previewNutrition({
    required UserProfileModel userProfile,
  }) {
    final goalType = OnboardingPayloadMapper.goalsToGoalType(userProfile.goals);
    return onboardingRepository.previewNutrition(
      gender: OnboardingPayloadMapper.genderToApi(userProfile.gender),
      age: userProfile.age,
      heightCm: userProfile.heightCm,
      currentWeightKg: userProfile.currentWeightKg,
      activityLevel: OnboardingPayloadMapper.activityToApi(userProfile.activityLevel),
      goalType: goalType,
      goalWeightKg: userProfile.goalWeightKg > 0 ? userProfile.goalWeightKg : null,
      conditionTypes: userProfile.conditionTypes.isNotEmpty ? userProfile.conditionTypes : null,
    );
  }

  /// Loads server onboarding draft into a [UserProfileModel] (for resume).
  Future<UserProfileModel> loadOnboardingDraft(UserProfileModel current) async {
    final result = await onboardingRepository.getSnapshot();
    return result.fold(
      (data) => OnboardingPayloadMapper.mergeFromSnapshot(current, data),
      (_) => current,
    );
  }

  Future<void> submitOnboarding({required UserProfileModel userProfile}) async {
    emit(const AuthState.savingProfileLoading());

    final gender = OnboardingPayloadMapper.genderToApi(userProfile.gender);
    final activity = OnboardingPayloadMapper.activityToApi(
      userProfile.activityLevel,
    );
    final goalType = OnboardingPayloadMapper.goalsToGoalType(userProfile.goals);

    final trimmedName = userProfile.displayName?.trim();
    final basic = await onboardingRepository.patchBasicInfo(
      gender: gender,
      age: userProfile.age,
      heightCm: userProfile.heightCm,
      currentWeightKg: userProfile.currentWeightKg,
      displayName: (trimmedName != null && trimmedName.isNotEmpty)
          ? trimmedName
          : null,
      goalWeightKg: userProfile.goalWeightKg > 0
          ? userProfile.goalWeightKg
          : null,
    );
    if (basic.isError()) {
      emit(AuthState.error(_onboardingErrorMessage(basic.exceptionOrNull()!)));
      return;
    }

    final health = await onboardingRepository.patchHealthProfile(
      conditionTypes: List<String>.from(userProfile.conditionTypes),
    );
    if (health.isError()) {
      emit(AuthState.error(_onboardingErrorMessage(health.exceptionOrNull()!)));
      return;
    }

    final goals = await onboardingRepository.patchGoalPreferences(
      goalType: goalType,
      activityLevel: activity,
      mealFrequency: userProfile.mealPlanningFrequency.isNotEmpty
          ? userProfile.mealPlanningFrequency
          : null,
      barriers: userProfile.barriers.isNotEmpty ? userProfile.barriers : null,
    );
    if (goals.isError()) {
      emit(AuthState.error(_onboardingErrorMessage(goals.exceptionOrNull()!)));
      return;
    }

    final done = await onboardingRepository.complete();
    if (done.isError()) {
      emit(AuthState.error(_onboardingErrorMessage(done.exceptionOrNull()!)));
      return;
    }

    await Storage.setIsProfileComplete(true);
    await _userProfileCubit.refresh();
    await _moreCubit.loadMoreData();
    emit(const AuthState.saveProfileSuccess('Profile saved successfully'));
  }

  String _onboardingErrorMessage(ApiError error) {
    var msg = error.message.isNotEmpty ? error.message : 'Onboarding failed';
    if (msg.contains('network')) {
      msg = 'Network error. Please check your connection';
    }
    return msg;
  }

  /// Kept for existing signup step widgets; delegates to [submitOnboarding].
  Future<void> saveUserProfile({required UserProfileModel userProfile}) =>
      submitOnboarding(userProfile: userProfile);

  Future<void> logout() async {
    try {
      emit(const AuthState.loading());
      await MealLogReminderService.instance.cancelMealReminders();
      await authRepository.signOut();
      emit(AuthState.unauthenticated('Logged out successfully'));
    } catch (e) {
      emit(AuthState.error('Logout failed'));
    }
  }
}
