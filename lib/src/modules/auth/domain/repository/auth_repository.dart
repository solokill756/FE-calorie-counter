import 'package:result_dart/result_dart.dart';

import '../../../../core/data/remote/base/api_error.dart';
import '../../data/models/login_request.dart';
import '../../data/models/login_response.dart';
import '../../data/models/register_request.dart';
import '../../data/models/register_response.dart';
import '../../data/models/user_profile_model.dart';

abstract class AuthRepository {
  Future<Result<RegisterResponse, ApiError>> signUp({
    required RegisterRequest request,
  });
  Future<Result<LoginResponse, ApiError>> signIn(LoginRequest loginRequest);
  Future<Result<Map<String, dynamic>, ApiError>> forgotPassword(String email);
  Future<Result<bool, ApiError>> resetPassword({
    required String token,
    required String newPassword,
  });
  Future<Result<LoginResponse, ApiError>> signInWithGoogle();
  Future<Result<LoginResponse, ApiError>> signInWithApple();
  Future<void> signOut();
  Future<Result<UserProfileModel, ApiError>> getUserProfile();

  Future<Result<UserProfileModel, ApiError>> patchProfile({
    String? displayName,
    String? email,
    String? newPassword,
    String? avatarUrl,
  });

  /// Sends only changed health fields; a null mealSplits resets the defaults.
  Future<Result<UserProfileModel, ApiError>> patchHealthProfile(
    Map<String, Object?> changes,
  );

  /// Updates primary goal; server recomputes calorie/macros targets.
  Future<Result<UserProfileModel, ApiError>> patchUserGoal({
    required String goalTypeSlug,
  });

  /// Permanently closes the account on the server (soft delete), then caller should clear local session.
  Future<Result<bool, ApiError>> deleteAccount();
}
