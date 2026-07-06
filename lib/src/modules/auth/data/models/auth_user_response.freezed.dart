// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthUserResponse _$AuthUserResponseFromJson(Map<String, dynamic> json) {
  return _AuthUserResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthUserResponse {
  int get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  bool get isProfileComplete => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthUserResponseCopyWith<AuthUserResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserResponseCopyWith<$Res> {
  factory $AuthUserResponseCopyWith(
          AuthUserResponse value, $Res Function(AuthUserResponse) then) =
      _$AuthUserResponseCopyWithImpl<$Res, AuthUserResponse>;
  @useResult
  $Res call(
      {int id,
      String? email,
      String displayName,
      String? avatarUrl,
      int status,
      bool isProfileComplete});
}

/// @nodoc
class _$AuthUserResponseCopyWithImpl<$Res, $Val extends AuthUserResponse>
    implements $AuthUserResponseCopyWith<$Res> {
  _$AuthUserResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = freezed,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? status = null,
    Object? isProfileComplete = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      isProfileComplete: null == isProfileComplete
          ? _value.isProfileComplete
          : isProfileComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthUserResponseImplCopyWith<$Res>
    implements $AuthUserResponseCopyWith<$Res> {
  factory _$$AuthUserResponseImplCopyWith(_$AuthUserResponseImpl value,
          $Res Function(_$AuthUserResponseImpl) then) =
      __$$AuthUserResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? email,
      String displayName,
      String? avatarUrl,
      int status,
      bool isProfileComplete});
}

/// @nodoc
class __$$AuthUserResponseImplCopyWithImpl<$Res>
    extends _$AuthUserResponseCopyWithImpl<$Res, _$AuthUserResponseImpl>
    implements _$$AuthUserResponseImplCopyWith<$Res> {
  __$$AuthUserResponseImplCopyWithImpl(_$AuthUserResponseImpl _value,
      $Res Function(_$AuthUserResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = freezed,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? status = null,
    Object? isProfileComplete = null,
  }) {
    return _then(_$AuthUserResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      isProfileComplete: null == isProfileComplete
          ? _value.isProfileComplete
          : isProfileComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthUserResponseImpl implements _AuthUserResponse {
  const _$AuthUserResponseImpl(
      {required this.id,
      this.email,
      required this.displayName,
      this.avatarUrl,
      required this.status,
      required this.isProfileComplete});

  factory _$AuthUserResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserResponseImplFromJson(json);

  @override
  final int id;
  @override
  final String? email;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
  @override
  final int status;
  @override
  final bool isProfileComplete;

  @override
  String toString() {
    return 'AuthUserResponse(id: $id, email: $email, displayName: $displayName, avatarUrl: $avatarUrl, status: $status, isProfileComplete: $isProfileComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isProfileComplete, isProfileComplete) ||
                other.isProfileComplete == isProfileComplete));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, displayName,
      avatarUrl, status, isProfileComplete);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserResponseImplCopyWith<_$AuthUserResponseImpl> get copyWith =>
      __$$AuthUserResponseImplCopyWithImpl<_$AuthUserResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserResponseImplToJson(
      this,
    );
  }
}

abstract class _AuthUserResponse implements AuthUserResponse {
  const factory _AuthUserResponse(
      {required final int id,
      final String? email,
      required final String displayName,
      final String? avatarUrl,
      required final int status,
      required final bool isProfileComplete}) = _$AuthUserResponseImpl;

  factory _AuthUserResponse.fromJson(Map<String, dynamic> json) =
      _$AuthUserResponseImpl.fromJson;

  @override
  int get id;
  @override
  String? get email;
  @override
  String get displayName;
  @override
  String? get avatarUrl;
  @override
  int get status;
  @override
  bool get isProfileComplete;
  @override
  @JsonKey(ignore: true)
  _$$AuthUserResponseImplCopyWith<_$AuthUserResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
