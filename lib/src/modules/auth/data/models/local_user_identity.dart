import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_user_identity.freezed.dart';
part 'local_user_identity.g.dart';

@freezed
class LocalUserIdentity with _$LocalUserIdentity {
  const factory LocalUserIdentity({
    @Default('') String email,
    @Default('') String? displayName,
    String? avatarUrl,
    @Default(false) bool isProfileComplete,
  }) = _LocalUserIdentity;

  factory LocalUserIdentity.fromJson(Map<String, dynamic> json) =>
      _$LocalUserIdentityFromJson(json);
}
