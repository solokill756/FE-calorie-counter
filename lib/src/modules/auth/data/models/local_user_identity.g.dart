// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalUserIdentityImpl _$$LocalUserIdentityImplFromJson(
        Map<String, dynamic> json) =>
    _$LocalUserIdentityImpl(
      email: json['email'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
      isProfileComplete: json['isProfileComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$$LocalUserIdentityImplToJson(
        _$LocalUserIdentityImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'isProfileComplete': instance.isProfileComplete,
    };
