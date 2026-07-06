// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserResponseImpl _$$AuthUserResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthUserResponseImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String?,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      status: (json['status'] as num).toInt(),
      isProfileComplete: json['isProfileComplete'] as bool,
    );

Map<String, dynamic> _$$AuthUserResponseImplToJson(
        _$AuthUserResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'status': instance.status,
      'isProfileComplete': instance.isProfileComplete,
    };
