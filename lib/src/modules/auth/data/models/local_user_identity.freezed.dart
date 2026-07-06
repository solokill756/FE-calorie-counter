// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_user_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocalUserIdentity _$LocalUserIdentityFromJson(Map<String, dynamic> json) {
  return _LocalUserIdentity.fromJson(json);
}

/// @nodoc
mixin _$LocalUserIdentity {
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  bool get isProfileComplete => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocalUserIdentityCopyWith<LocalUserIdentity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalUserIdentityCopyWith<$Res> {
  factory $LocalUserIdentityCopyWith(
          LocalUserIdentity value, $Res Function(LocalUserIdentity) then) =
      _$LocalUserIdentityCopyWithImpl<$Res, LocalUserIdentity>;
  @useResult
  $Res call(
      {String email,
      String? displayName,
      String? avatarUrl,
      bool isProfileComplete});
}

/// @nodoc
class _$LocalUserIdentityCopyWithImpl<$Res, $Val extends LocalUserIdentity>
    implements $LocalUserIdentityCopyWith<$Res> {
  _$LocalUserIdentityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? isProfileComplete = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isProfileComplete: null == isProfileComplete
          ? _value.isProfileComplete
          : isProfileComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalUserIdentityImplCopyWith<$Res>
    implements $LocalUserIdentityCopyWith<$Res> {
  factory _$$LocalUserIdentityImplCopyWith(_$LocalUserIdentityImpl value,
          $Res Function(_$LocalUserIdentityImpl) then) =
      __$$LocalUserIdentityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String? displayName,
      String? avatarUrl,
      bool isProfileComplete});
}

/// @nodoc
class __$$LocalUserIdentityImplCopyWithImpl<$Res>
    extends _$LocalUserIdentityCopyWithImpl<$Res, _$LocalUserIdentityImpl>
    implements _$$LocalUserIdentityImplCopyWith<$Res> {
  __$$LocalUserIdentityImplCopyWithImpl(_$LocalUserIdentityImpl _value,
      $Res Function(_$LocalUserIdentityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? isProfileComplete = null,
  }) {
    return _then(_$LocalUserIdentityImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isProfileComplete: null == isProfileComplete
          ? _value.isProfileComplete
          : isProfileComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalUserIdentityImpl implements _LocalUserIdentity {
  const _$LocalUserIdentityImpl(
      {this.email = '',
      this.displayName = '',
      this.avatarUrl,
      this.isProfileComplete = false});

  factory _$LocalUserIdentityImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalUserIdentityImplFromJson(json);

  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String? displayName;
  @override
  final String? avatarUrl;
  @override
  @JsonKey()
  final bool isProfileComplete;

  @override
  String toString() {
    return 'LocalUserIdentity(email: $email, displayName: $displayName, avatarUrl: $avatarUrl, isProfileComplete: $isProfileComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalUserIdentityImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isProfileComplete, isProfileComplete) ||
                other.isProfileComplete == isProfileComplete));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, email, displayName, avatarUrl, isProfileComplete);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalUserIdentityImplCopyWith<_$LocalUserIdentityImpl> get copyWith =>
      __$$LocalUserIdentityImplCopyWithImpl<_$LocalUserIdentityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalUserIdentityImplToJson(
      this,
    );
  }
}

abstract class _LocalUserIdentity implements LocalUserIdentity {
  const factory _LocalUserIdentity(
      {final String email,
      final String? displayName,
      final String? avatarUrl,
      final bool isProfileComplete}) = _$LocalUserIdentityImpl;

  factory _LocalUserIdentity.fromJson(Map<String, dynamic> json) =
      _$LocalUserIdentityImpl.fromJson;

  @override
  String get email;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;
  @override
  bool get isProfileComplete;
  @override
  @JsonKey(ignore: true)
  _$$LocalUserIdentityImplCopyWith<_$LocalUserIdentityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
