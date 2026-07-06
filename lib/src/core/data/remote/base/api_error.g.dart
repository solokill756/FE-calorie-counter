// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ValidationErrorDetailImpl _$$ValidationErrorDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$ValidationErrorDetailImpl(
      field: json['field'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ValidationErrorDetailImplToJson(
        _$ValidationErrorDetailImpl instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

_$ApiErrorImpl _$$ApiErrorImplFromJson(Map<String, dynamic> json) =>
    _$ApiErrorImpl(
      (json['code'] as num?)?.toInt(),
      json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ApiErrorImplToJson(_$ApiErrorImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_$ServerImpl _$$ServerImplFromJson(Map<String, dynamic> json) => _$ServerImpl(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ServerImplToJson(_$ServerImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_$NetworkImpl _$$NetworkImplFromJson(Map<String, dynamic> json) =>
    _$NetworkImpl(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NetworkImplToJson(_$NetworkImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_$UnexpectedImpl _$$UnexpectedImplFromJson(Map<String, dynamic> json) =>
    _$UnexpectedImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnexpectedImplToJson(_$UnexpectedImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$UnauthorizedImpl _$$UnauthorizedImplFromJson(Map<String, dynamic> json) =>
    _$UnauthorizedImpl(
      json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnauthorizedImplToJson(_$UnauthorizedImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_$ConflictImpl _$$ConflictImplFromJson(Map<String, dynamic> json) =>
    _$ConflictImpl(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConflictImplToJson(_$ConflictImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_$ValidationImpl _$$ValidationImplFromJson(Map<String, dynamic> json) =>
    _$ValidationImpl(
      statusCode: (json['statusCode'] as num).toInt(),
      errors: (json['errors'] as List<dynamic>)
          .map((e) => ValidationErrorDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ValidationImplToJson(_$ValidationImpl instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'errors': instance.errors.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };
