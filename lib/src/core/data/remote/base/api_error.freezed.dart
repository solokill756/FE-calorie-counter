// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ValidationErrorDetail _$ValidationErrorDetailFromJson(
    Map<String, dynamic> json) {
  return _ValidationErrorDetail.fromJson(json);
}

/// @nodoc
mixin _$ValidationErrorDetail {
  String get field => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ValidationErrorDetailCopyWith<ValidationErrorDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationErrorDetailCopyWith<$Res> {
  factory $ValidationErrorDetailCopyWith(ValidationErrorDetail value,
          $Res Function(ValidationErrorDetail) then) =
      _$ValidationErrorDetailCopyWithImpl<$Res, ValidationErrorDetail>;
  @useResult
  $Res call({String field, String message});
}

/// @nodoc
class _$ValidationErrorDetailCopyWithImpl<$Res,
        $Val extends ValidationErrorDetail>
    implements $ValidationErrorDetailCopyWith<$Res> {
  _$ValidationErrorDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ValidationErrorDetailImplCopyWith<$Res>
    implements $ValidationErrorDetailCopyWith<$Res> {
  factory _$$ValidationErrorDetailImplCopyWith(
          _$ValidationErrorDetailImpl value,
          $Res Function(_$ValidationErrorDetailImpl) then) =
      __$$ValidationErrorDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String field, String message});
}

/// @nodoc
class __$$ValidationErrorDetailImplCopyWithImpl<$Res>
    extends _$ValidationErrorDetailCopyWithImpl<$Res,
        _$ValidationErrorDetailImpl>
    implements _$$ValidationErrorDetailImplCopyWith<$Res> {
  __$$ValidationErrorDetailImplCopyWithImpl(_$ValidationErrorDetailImpl _value,
      $Res Function(_$ValidationErrorDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? message = null,
  }) {
    return _then(_$ValidationErrorDetailImpl(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidationErrorDetailImpl implements _ValidationErrorDetail {
  const _$ValidationErrorDetailImpl(
      {required this.field, required this.message});

  factory _$ValidationErrorDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationErrorDetailImplFromJson(json);

  @override
  final String field;
  @override
  final String message;

  @override
  String toString() {
    return 'ValidationErrorDetail(field: $field, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationErrorDetailImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, field, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationErrorDetailImplCopyWith<_$ValidationErrorDetailImpl>
      get copyWith => __$$ValidationErrorDetailImplCopyWithImpl<
          _$ValidationErrorDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationErrorDetailImplToJson(
      this,
    );
  }
}

abstract class _ValidationErrorDetail implements ValidationErrorDetail {
  const factory _ValidationErrorDetail(
      {required final String field,
      required final String message}) = _$ValidationErrorDetailImpl;

  factory _ValidationErrorDetail.fromJson(Map<String, dynamic> json) =
      _$ValidationErrorDetailImpl.fromJson;

  @override
  String get field;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ValidationErrorDetailImplCopyWith<_$ValidationErrorDetailImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'default':
      return _ApiError.fromJson(json);
    case 'server':
      return _Server.fromJson(json);
    case 'network':
      return _Network.fromJson(json);
    case 'unexpected':
      return _Unexpected.fromJson(json);
    case 'unauthorized':
      return _Unauthorized.fromJson(json);
    case 'conflict':
      return _Conflict.fromJson(json);
    case 'validation':
      return _Validation.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ApiError',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ApiError {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? code, String message) $default, {
    required TResult Function(int? code, String message) server,
    required TResult Function(int? code, String message) network,
    required TResult Function() unexpected,
    required TResult Function(String message) unauthorized,
    required TResult Function(int? code, String message) conflict,
    required TResult Function(
            int statusCode, List<ValidationErrorDetail> errors)
        validation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? code, String message)? $default, {
    TResult? Function(int? code, String message)? server,
    TResult? Function(int? code, String message)? network,
    TResult? Function()? unexpected,
    TResult? Function(String message)? unauthorized,
    TResult? Function(int? code, String message)? conflict,
    TResult? Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? code, String message)? $default, {
    TResult Function(int? code, String message)? server,
    TResult Function(int? code, String message)? network,
    TResult Function()? unexpected,
    TResult Function(String message)? unauthorized,
    TResult Function(int? code, String message)? conflict,
    TResult Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ApiError value) $default, {
    required TResult Function(_Server value) server,
    required TResult Function(_Network value) network,
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Conflict value) conflict,
    required TResult Function(_Validation value) validation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ApiError value)? $default, {
    TResult? Function(_Server value)? server,
    TResult? Function(_Network value)? network,
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Conflict value)? conflict,
    TResult? Function(_Validation value)? validation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ApiError value)? $default, {
    TResult Function(_Server value)? server,
    TResult Function(_Network value)? network,
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Conflict value)? conflict,
    TResult Function(_Validation value)? validation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorCopyWith<$Res> {
  factory $ApiErrorCopyWith(ApiError value, $Res Function(ApiError) then) =
      _$ApiErrorCopyWithImpl<$Res, ApiError>;
}

/// @nodoc
class _$ApiErrorCopyWithImpl<$Res, $Val extends ApiError>
    implements $ApiErrorCopyWith<$Res> {
  _$ApiErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ApiErrorImplCopyWith<$Res> {
  factory _$$ApiErrorImplCopyWith(
          _$ApiErrorImpl value, $Res Function(_$ApiErrorImpl) then) =
      __$$ApiErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? code, String message});
}

/// @nodoc
class __$$ApiErrorImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$ApiErrorImpl>
    implements _$$ApiErrorImplCopyWith<$Res> {
  __$$ApiErrorImplCopyWithImpl(
      _$ApiErrorImpl _value, $Res Function(_$ApiErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = null,
  }) {
    return _then(_$ApiErrorImpl(
      freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiErrorImpl extends _ApiError {
  _$ApiErrorImpl(this.code, this.message, {final String? $type})
      : $type = $type ?? 'default',
        super._();

  factory _$ApiErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiErrorImplFromJson(json);

  @override
  final int? code;
  @override
  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ApiError(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiErrorImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiErrorImplCopyWith<_$ApiErrorImpl> get copyWith =>
      __$$ApiErrorImplCopyWithImpl<_$ApiErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? code, String message) $default, {
    required TResult Function(int? code, String message) server,
    required TResult Function(int? code, String message) network,
    required TResult Function() unexpected,
    required TResult Function(String message) unauthorized,
    required TResult Function(int? code, String message) conflict,
    required TResult Function(
            int statusCode, List<ValidationErrorDetail> errors)
        validation,
  }) {
    return $default(code, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? code, String message)? $default, {
    TResult? Function(int? code, String message)? server,
    TResult? Function(int? code, String message)? network,
    TResult? Function()? unexpected,
    TResult? Function(String message)? unauthorized,
    TResult? Function(int? code, String message)? conflict,
    TResult? Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
  }) {
    return $default?.call(code, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? code, String message)? $default, {
    TResult Function(int? code, String message)? server,
    TResult Function(int? code, String message)? network,
    TResult Function()? unexpected,
    TResult Function(String message)? unauthorized,
    TResult Function(int? code, String message)? conflict,
    TResult Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(code, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ApiError value) $default, {
    required TResult Function(_Server value) server,
    required TResult Function(_Network value) network,
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Conflict value) conflict,
    required TResult Function(_Validation value) validation,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ApiError value)? $default, {
    TResult? Function(_Server value)? server,
    TResult? Function(_Network value)? network,
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Conflict value)? conflict,
    TResult? Function(_Validation value)? validation,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ApiError value)? $default, {
    TResult Function(_Server value)? server,
    TResult Function(_Network value)? network,
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Conflict value)? conflict,
    TResult Function(_Validation value)? validation,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiErrorImplToJson(
      this,
    );
  }
}

abstract class _ApiError extends ApiError {
  factory _ApiError(final int? code, final String message) = _$ApiErrorImpl;
  _ApiError._() : super._();

  factory _ApiError.fromJson(Map<String, dynamic> json) =
      _$ApiErrorImpl.fromJson;

  int? get code;
  String get message;
  @JsonKey(ignore: true)
  _$$ApiErrorImplCopyWith<_$ApiErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerImplCopyWith<$Res> {
  factory _$$ServerImplCopyWith(
          _$ServerImpl value, $Res Function(_$ServerImpl) then) =
      __$$ServerImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? code, String message});
}

/// @nodoc
class __$$ServerImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$ServerImpl>
    implements _$$ServerImplCopyWith<$Res> {
  __$$ServerImplCopyWithImpl(
      _$ServerImpl _value, $Res Function(_$ServerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = null,
  }) {
    return _then(_$ServerImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerImpl extends _Server {
  _$ServerImpl({this.code, required this.message, final String? $type})
      : $type = $type ?? 'server',
        super._();

  factory _$ServerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerImplFromJson(json);

  @override
  final int? code;
  @override
  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ApiError.server(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerImplCopyWith<_$ServerImpl> get copyWith =>
      __$$ServerImplCopyWithImpl<_$ServerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? code, String message) $default, {
    required TResult Function(int? code, String message) server,
    required TResult Function(int? code, String message) network,
    required TResult Function() unexpected,
    required TResult Function(String message) unauthorized,
    required TResult Function(int? code, String message) conflict,
    required TResult Function(
            int statusCode, List<ValidationErrorDetail> errors)
        validation,
  }) {
    return server(code, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? code, String message)? $default, {
    TResult? Function(int? code, String message)? server,
    TResult? Function(int? code, String message)? network,
    TResult? Function()? unexpected,
    TResult? Function(String message)? unauthorized,
    TResult? Function(int? code, String message)? conflict,
    TResult? Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
  }) {
    return server?.call(code, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? code, String message)? $default, {
    TResult Function(int? code, String message)? server,
    TResult Function(int? code, String message)? network,
    TResult Function()? unexpected,
    TResult Function(String message)? unauthorized,
    TResult Function(int? code, String message)? conflict,
    TResult Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(code, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ApiError value) $default, {
    required TResult Function(_Server value) server,
    required TResult Function(_Network value) network,
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Conflict value) conflict,
    required TResult Function(_Validation value) validation,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ApiError value)? $default, {
    TResult? Function(_Server value)? server,
    TResult? Function(_Network value)? network,
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Conflict value)? conflict,
    TResult? Function(_Validation value)? validation,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ApiError value)? $default, {
    TResult Function(_Server value)? server,
    TResult Function(_Network value)? network,
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Conflict value)? conflict,
    TResult Function(_Validation value)? validation,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerImplToJson(
      this,
    );
  }
}

abstract class _Server extends ApiError {
  factory _Server({final int? code, required final String message}) =
      _$ServerImpl;
  _Server._() : super._();

  factory _Server.fromJson(Map<String, dynamic> json) = _$ServerImpl.fromJson;

  int? get code;
  String get message;
  @JsonKey(ignore: true)
  _$$ServerImplCopyWith<_$ServerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkImplCopyWith<$Res> {
  factory _$$NetworkImplCopyWith(
          _$NetworkImpl value, $Res Function(_$NetworkImpl) then) =
      __$$NetworkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? code, String message});
}

/// @nodoc
class __$$NetworkImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$NetworkImpl>
    implements _$$NetworkImplCopyWith<$Res> {
  __$$NetworkImplCopyWithImpl(
      _$NetworkImpl _value, $Res Function(_$NetworkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = null,
  }) {
    return _then(_$NetworkImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NetworkImpl extends _Network {
  _$NetworkImpl({this.code, required this.message, final String? $type})
      : $type = $type ?? 'network',
        super._();

  factory _$NetworkImpl.fromJson(Map<String, dynamic> json) =>
      _$$NetworkImplFromJson(json);

  @override
  final int? code;
  @override
  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ApiError.network(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkImplCopyWith<_$NetworkImpl> get copyWith =>
      __$$NetworkImplCopyWithImpl<_$NetworkImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? code, String message) $default, {
    required TResult Function(int? code, String message) server,
    required TResult Function(int? code, String message) network,
    required TResult Function() unexpected,
    required TResult Function(String message) unauthorized,
    required TResult Function(int? code, String message) conflict,
    required TResult Function(
            int statusCode, List<ValidationErrorDetail> errors)
        validation,
  }) {
    return network(code, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? code, String message)? $default, {
    TResult? Function(int? code, String message)? server,
    TResult? Function(int? code, String message)? network,
    TResult? Function()? unexpected,
    TResult? Function(String message)? unauthorized,
    TResult? Function(int? code, String message)? conflict,
    TResult? Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
  }) {
    return network?.call(code, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? code, String message)? $default, {
    TResult Function(int? code, String message)? server,
    TResult Function(int? code, String message)? network,
    TResult Function()? unexpected,
    TResult Function(String message)? unauthorized,
    TResult Function(int? code, String message)? conflict,
    TResult Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(code, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ApiError value) $default, {
    required TResult Function(_Server value) server,
    required TResult Function(_Network value) network,
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Conflict value) conflict,
    required TResult Function(_Validation value) validation,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ApiError value)? $default, {
    TResult? Function(_Server value)? server,
    TResult? Function(_Network value)? network,
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Conflict value)? conflict,
    TResult? Function(_Validation value)? validation,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ApiError value)? $default, {
    TResult Function(_Server value)? server,
    TResult Function(_Network value)? network,
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Conflict value)? conflict,
    TResult Function(_Validation value)? validation,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NetworkImplToJson(
      this,
    );
  }
}

abstract class _Network extends ApiError {
  factory _Network({final int? code, required final String message}) =
      _$NetworkImpl;
  _Network._() : super._();

  factory _Network.fromJson(Map<String, dynamic> json) = _$NetworkImpl.fromJson;

  int? get code;
  String get message;
  @JsonKey(ignore: true)
  _$$NetworkImplCopyWith<_$NetworkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnexpectedImplCopyWith<$Res> {
  factory _$$UnexpectedImplCopyWith(
          _$UnexpectedImpl value, $Res Function(_$UnexpectedImpl) then) =
      __$$UnexpectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnexpectedImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$UnexpectedImpl>
    implements _$$UnexpectedImplCopyWith<$Res> {
  __$$UnexpectedImplCopyWithImpl(
      _$UnexpectedImpl _value, $Res Function(_$UnexpectedImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$UnexpectedImpl extends _Unexpected {
  _$UnexpectedImpl({final String? $type})
      : $type = $type ?? 'unexpected',
        super._();

  factory _$UnexpectedImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnexpectedImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ApiError.unexpected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnexpectedImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? code, String message) $default, {
    required TResult Function(int? code, String message) server,
    required TResult Function(int? code, String message) network,
    required TResult Function() unexpected,
    required TResult Function(String message) unauthorized,
    required TResult Function(int? code, String message) conflict,
    required TResult Function(
            int statusCode, List<ValidationErrorDetail> errors)
        validation,
  }) {
    return unexpected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? code, String message)? $default, {
    TResult? Function(int? code, String message)? server,
    TResult? Function(int? code, String message)? network,
    TResult? Function()? unexpected,
    TResult? Function(String message)? unauthorized,
    TResult? Function(int? code, String message)? conflict,
    TResult? Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
  }) {
    return unexpected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? code, String message)? $default, {
    TResult Function(int? code, String message)? server,
    TResult Function(int? code, String message)? network,
    TResult Function()? unexpected,
    TResult Function(String message)? unauthorized,
    TResult Function(int? code, String message)? conflict,
    TResult Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ApiError value) $default, {
    required TResult Function(_Server value) server,
    required TResult Function(_Network value) network,
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Conflict value) conflict,
    required TResult Function(_Validation value) validation,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ApiError value)? $default, {
    TResult? Function(_Server value)? server,
    TResult? Function(_Network value)? network,
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Conflict value)? conflict,
    TResult? Function(_Validation value)? validation,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ApiError value)? $default, {
    TResult Function(_Server value)? server,
    TResult Function(_Network value)? network,
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Conflict value)? conflict,
    TResult Function(_Validation value)? validation,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnexpectedImplToJson(
      this,
    );
  }
}

abstract class _Unexpected extends ApiError {
  factory _Unexpected() = _$UnexpectedImpl;
  _Unexpected._() : super._();

  factory _Unexpected.fromJson(Map<String, dynamic> json) =
      _$UnexpectedImpl.fromJson;
}

/// @nodoc
abstract class _$$UnauthorizedImplCopyWith<$Res> {
  factory _$$UnauthorizedImplCopyWith(
          _$UnauthorizedImpl value, $Res Function(_$UnauthorizedImpl) then) =
      __$$UnauthorizedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnauthorizedImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$UnauthorizedImpl>
    implements _$$UnauthorizedImplCopyWith<$Res> {
  __$$UnauthorizedImplCopyWithImpl(
      _$UnauthorizedImpl _value, $Res Function(_$UnauthorizedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UnauthorizedImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnauthorizedImpl extends _Unauthorized {
  _$UnauthorizedImpl(this.message, {final String? $type})
      : $type = $type ?? 'unauthorized',
        super._();

  factory _$UnauthorizedImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnauthorizedImplFromJson(json);

  @override
  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ApiError.unauthorized(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthorizedImplCopyWith<_$UnauthorizedImpl> get copyWith =>
      __$$UnauthorizedImplCopyWithImpl<_$UnauthorizedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? code, String message) $default, {
    required TResult Function(int? code, String message) server,
    required TResult Function(int? code, String message) network,
    required TResult Function() unexpected,
    required TResult Function(String message) unauthorized,
    required TResult Function(int? code, String message) conflict,
    required TResult Function(
            int statusCode, List<ValidationErrorDetail> errors)
        validation,
  }) {
    return unauthorized(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? code, String message)? $default, {
    TResult? Function(int? code, String message)? server,
    TResult? Function(int? code, String message)? network,
    TResult? Function()? unexpected,
    TResult? Function(String message)? unauthorized,
    TResult? Function(int? code, String message)? conflict,
    TResult? Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
  }) {
    return unauthorized?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? code, String message)? $default, {
    TResult Function(int? code, String message)? server,
    TResult Function(int? code, String message)? network,
    TResult Function()? unexpected,
    TResult Function(String message)? unauthorized,
    TResult Function(int? code, String message)? conflict,
    TResult Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ApiError value) $default, {
    required TResult Function(_Server value) server,
    required TResult Function(_Network value) network,
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Conflict value) conflict,
    required TResult Function(_Validation value) validation,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ApiError value)? $default, {
    TResult? Function(_Server value)? server,
    TResult? Function(_Network value)? network,
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Conflict value)? conflict,
    TResult? Function(_Validation value)? validation,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ApiError value)? $default, {
    TResult Function(_Server value)? server,
    TResult Function(_Network value)? network,
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Conflict value)? conflict,
    TResult Function(_Validation value)? validation,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnauthorizedImplToJson(
      this,
    );
  }
}

abstract class _Unauthorized extends ApiError {
  factory _Unauthorized(final String message) = _$UnauthorizedImpl;
  _Unauthorized._() : super._();

  factory _Unauthorized.fromJson(Map<String, dynamic> json) =
      _$UnauthorizedImpl.fromJson;

  String get message;
  @JsonKey(ignore: true)
  _$$UnauthorizedImplCopyWith<_$UnauthorizedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConflictImplCopyWith<$Res> {
  factory _$$ConflictImplCopyWith(
          _$ConflictImpl value, $Res Function(_$ConflictImpl) then) =
      __$$ConflictImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? code, String message});
}

/// @nodoc
class __$$ConflictImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$ConflictImpl>
    implements _$$ConflictImplCopyWith<$Res> {
  __$$ConflictImplCopyWithImpl(
      _$ConflictImpl _value, $Res Function(_$ConflictImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = null,
  }) {
    return _then(_$ConflictImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConflictImpl extends _Conflict {
  _$ConflictImpl({this.code, required this.message, final String? $type})
      : $type = $type ?? 'conflict',
        super._();

  factory _$ConflictImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConflictImplFromJson(json);

  @override
  final int? code;
  @override
  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ApiError.conflict(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConflictImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConflictImplCopyWith<_$ConflictImpl> get copyWith =>
      __$$ConflictImplCopyWithImpl<_$ConflictImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? code, String message) $default, {
    required TResult Function(int? code, String message) server,
    required TResult Function(int? code, String message) network,
    required TResult Function() unexpected,
    required TResult Function(String message) unauthorized,
    required TResult Function(int? code, String message) conflict,
    required TResult Function(
            int statusCode, List<ValidationErrorDetail> errors)
        validation,
  }) {
    return conflict(code, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? code, String message)? $default, {
    TResult? Function(int? code, String message)? server,
    TResult? Function(int? code, String message)? network,
    TResult? Function()? unexpected,
    TResult? Function(String message)? unauthorized,
    TResult? Function(int? code, String message)? conflict,
    TResult? Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
  }) {
    return conflict?.call(code, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? code, String message)? $default, {
    TResult Function(int? code, String message)? server,
    TResult Function(int? code, String message)? network,
    TResult Function()? unexpected,
    TResult Function(String message)? unauthorized,
    TResult Function(int? code, String message)? conflict,
    TResult Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
    required TResult orElse(),
  }) {
    if (conflict != null) {
      return conflict(code, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ApiError value) $default, {
    required TResult Function(_Server value) server,
    required TResult Function(_Network value) network,
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Conflict value) conflict,
    required TResult Function(_Validation value) validation,
  }) {
    return conflict(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ApiError value)? $default, {
    TResult? Function(_Server value)? server,
    TResult? Function(_Network value)? network,
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Conflict value)? conflict,
    TResult? Function(_Validation value)? validation,
  }) {
    return conflict?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ApiError value)? $default, {
    TResult Function(_Server value)? server,
    TResult Function(_Network value)? network,
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Conflict value)? conflict,
    TResult Function(_Validation value)? validation,
    required TResult orElse(),
  }) {
    if (conflict != null) {
      return conflict(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConflictImplToJson(
      this,
    );
  }
}

abstract class _Conflict extends ApiError {
  factory _Conflict({final int? code, required final String message}) =
      _$ConflictImpl;
  _Conflict._() : super._();

  factory _Conflict.fromJson(Map<String, dynamic> json) =
      _$ConflictImpl.fromJson;

  int? get code;
  String get message;
  @JsonKey(ignore: true)
  _$$ConflictImplCopyWith<_$ConflictImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationImplCopyWith<$Res> {
  factory _$$ValidationImplCopyWith(
          _$ValidationImpl value, $Res Function(_$ValidationImpl) then) =
      __$$ValidationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int statusCode, List<ValidationErrorDetail> errors});
}

/// @nodoc
class __$$ValidationImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$ValidationImpl>
    implements _$$ValidationImplCopyWith<$Res> {
  __$$ValidationImplCopyWithImpl(
      _$ValidationImpl _value, $Res Function(_$ValidationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? errors = null,
  }) {
    return _then(_$ValidationImpl(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<ValidationErrorDetail>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidationImpl extends _Validation {
  _$ValidationImpl(
      {required this.statusCode,
      required final List<ValidationErrorDetail> errors,
      final String? $type})
      : _errors = errors,
        $type = $type ?? 'validation',
        super._();

  factory _$ValidationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationImplFromJson(json);

  @override
  final int statusCode;
  final List<ValidationErrorDetail> _errors;
  @override
  List<ValidationErrorDetail> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ApiError.validation(statusCode: $statusCode, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, statusCode, const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationImplCopyWith<_$ValidationImpl> get copyWith =>
      __$$ValidationImplCopyWithImpl<_$ValidationImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? code, String message) $default, {
    required TResult Function(int? code, String message) server,
    required TResult Function(int? code, String message) network,
    required TResult Function() unexpected,
    required TResult Function(String message) unauthorized,
    required TResult Function(int? code, String message) conflict,
    required TResult Function(
            int statusCode, List<ValidationErrorDetail> errors)
        validation,
  }) {
    return validation(statusCode, errors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? code, String message)? $default, {
    TResult? Function(int? code, String message)? server,
    TResult? Function(int? code, String message)? network,
    TResult? Function()? unexpected,
    TResult? Function(String message)? unauthorized,
    TResult? Function(int? code, String message)? conflict,
    TResult? Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
  }) {
    return validation?.call(statusCode, errors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? code, String message)? $default, {
    TResult Function(int? code, String message)? server,
    TResult Function(int? code, String message)? network,
    TResult Function()? unexpected,
    TResult Function(String message)? unauthorized,
    TResult Function(int? code, String message)? conflict,
    TResult Function(int statusCode, List<ValidationErrorDetail> errors)?
        validation,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(statusCode, errors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ApiError value) $default, {
    required TResult Function(_Server value) server,
    required TResult Function(_Network value) network,
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_Conflict value) conflict,
    required TResult Function(_Validation value) validation,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ApiError value)? $default, {
    TResult? Function(_Server value)? server,
    TResult? Function(_Network value)? network,
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_Conflict value)? conflict,
    TResult? Function(_Validation value)? validation,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ApiError value)? $default, {
    TResult Function(_Server value)? server,
    TResult Function(_Network value)? network,
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_Conflict value)? conflict,
    TResult Function(_Validation value)? validation,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationImplToJson(
      this,
    );
  }
}

abstract class _Validation extends ApiError {
  factory _Validation(
      {required final int statusCode,
      required final List<ValidationErrorDetail> errors}) = _$ValidationImpl;
  _Validation._() : super._();

  factory _Validation.fromJson(Map<String, dynamic> json) =
      _$ValidationImpl.fromJson;

  int get statusCode;
  List<ValidationErrorDetail> get errors;
  @JsonKey(ignore: true)
  _$$ValidationImplCopyWith<_$ValidationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
