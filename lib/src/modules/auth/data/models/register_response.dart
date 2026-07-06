import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_user_response.dart';
part 'register_response.freezed.dart';
part 'register_response.g.dart';

@freezed
class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required AuthUserResponse user,
  }) = _RegisterResponse;

  const RegisterResponse._();

  int get userId => user.id;
  String get token => accessToken;
  String get displayName => user.displayName;
  String? get userImage => user.avatarUrl;
  bool get isProfileComplete => user.isProfileComplete;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
