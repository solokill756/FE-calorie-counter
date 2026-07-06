import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_response.freezed.dart';
part 'auth_user_response.g.dart';

@freezed
class AuthUserResponse with _$AuthUserResponse {
  const factory AuthUserResponse({
    required int id,
    String? email,
    required String displayName,
    String? avatarUrl,
    required int status,
    required bool isProfileComplete,
  }) = _AuthUserResponse;

  factory AuthUserResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthUserResponseFromJson(json);
}
