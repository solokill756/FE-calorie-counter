import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_user_response.dart';
part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required AuthUserResponse user,
  }) = _LoginResponse;

  const LoginResponse._();

  int get userId => user.id;
  String get token => accessToken;
  String get displayName => user.displayName;
  String? get userImage => user.avatarUrl;
  bool get isProfileComplete => user.isProfileComplete;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
