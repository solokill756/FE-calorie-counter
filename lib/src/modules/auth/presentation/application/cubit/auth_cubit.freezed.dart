// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String message) authenticated,
    required TResult Function(String message) registered,
    required TResult Function() loading,
    required TResult Function(String message) saveProfileSuccess,
    required TResult Function() savingProfileLoading,
    required TResult Function(String message) unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String message)? authenticated,
    TResult? Function(String message)? registered,
    TResult? Function()? loading,
    TResult? Function(String message)? saveProfileSuccess,
    TResult? Function()? savingProfileLoading,
    TResult? Function(String message)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String message)? authenticated,
    TResult Function(String message)? registered,
    TResult Function()? loading,
    TResult Function(String message)? saveProfileSuccess,
    TResult Function()? savingProfileLoading,
    TResult Function(String message)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthRegistered value) registered,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSaveProfileSuccess value) saveProfileSuccess,
    required TResult Function(AuthSavingProfileLoading value)
        savingProfileLoading,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthRegistered value)? registered,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult? Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthError value)? error,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthRegistered value)? registered,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthInitialImplCopyWith<$Res> {
  factory _$$AuthInitialImplCopyWith(
          _$AuthInitialImpl value, $Res Function(_$AuthInitialImpl) then) =
      __$$AuthInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthInitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthInitialImpl>
    implements _$$AuthInitialImplCopyWith<$Res> {
  __$$AuthInitialImplCopyWithImpl(
      _$AuthInitialImpl _value, $Res Function(_$AuthInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthInitialImpl with DiagnosticableTreeMixin implements AuthInitial {
  const _$AuthInitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AuthState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String message) authenticated,
    required TResult Function(String message) registered,
    required TResult Function() loading,
    required TResult Function(String message) saveProfileSuccess,
    required TResult Function() savingProfileLoading,
    required TResult Function(String message) unauthenticated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String message)? authenticated,
    TResult? Function(String message)? registered,
    TResult? Function()? loading,
    TResult? Function(String message)? saveProfileSuccess,
    TResult? Function()? savingProfileLoading,
    TResult? Function(String message)? unauthenticated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String message)? authenticated,
    TResult Function(String message)? registered,
    TResult Function()? loading,
    TResult Function(String message)? saveProfileSuccess,
    TResult Function()? savingProfileLoading,
    TResult Function(String message)? unauthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthRegistered value) registered,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSaveProfileSuccess value) saveProfileSuccess,
    required TResult Function(AuthSavingProfileLoading value)
        savingProfileLoading,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthRegistered value)? registered,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult? Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthError value)? error,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthRegistered value)? registered,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthInitial implements AuthState {
  const factory AuthInitial() = _$AuthInitialImpl;
}

/// @nodoc
abstract class _$$AuthErrorImplCopyWith<$Res> {
  factory _$$AuthErrorImplCopyWith(
          _$AuthErrorImpl value, $Res Function(_$AuthErrorImpl) then) =
      __$$AuthErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthErrorImpl>
    implements _$$AuthErrorImplCopyWith<$Res> {
  __$$AuthErrorImplCopyWithImpl(
      _$AuthErrorImpl _value, $Res Function(_$AuthErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthErrorImpl with DiagnosticableTreeMixin implements AuthError {
  const _$AuthErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      __$$AuthErrorImplCopyWithImpl<_$AuthErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String message) authenticated,
    required TResult Function(String message) registered,
    required TResult Function() loading,
    required TResult Function(String message) saveProfileSuccess,
    required TResult Function() savingProfileLoading,
    required TResult Function(String message) unauthenticated,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String message)? authenticated,
    TResult? Function(String message)? registered,
    TResult? Function()? loading,
    TResult? Function(String message)? saveProfileSuccess,
    TResult? Function()? savingProfileLoading,
    TResult? Function(String message)? unauthenticated,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String message)? authenticated,
    TResult Function(String message)? registered,
    TResult Function()? loading,
    TResult Function(String message)? saveProfileSuccess,
    TResult Function()? savingProfileLoading,
    TResult Function(String message)? unauthenticated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthRegistered value) registered,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSaveProfileSuccess value) saveProfileSuccess,
    required TResult Function(AuthSavingProfileLoading value)
        savingProfileLoading,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthRegistered value)? registered,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult? Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthError value)? error,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthRegistered value)? registered,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthError implements AuthState {
  const factory AuthError(final String message) = _$AuthErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthAuthenticatedImplCopyWith(_$AuthAuthenticatedImpl value,
          $Res Function(_$AuthAuthenticatedImpl) then) =
      __$$AuthAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthAuthenticatedImpl>
    implements _$$AuthAuthenticatedImplCopyWith<$Res> {
  __$$AuthAuthenticatedImplCopyWithImpl(_$AuthAuthenticatedImpl _value,
      $Res Function(_$AuthAuthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthAuthenticatedImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthAuthenticatedImpl
    with DiagnosticableTreeMixin
    implements AuthAuthenticated {
  const _$AuthAuthenticatedImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.authenticated(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.authenticated'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthAuthenticatedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      __$$AuthAuthenticatedImplCopyWithImpl<_$AuthAuthenticatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String message) authenticated,
    required TResult Function(String message) registered,
    required TResult Function() loading,
    required TResult Function(String message) saveProfileSuccess,
    required TResult Function() savingProfileLoading,
    required TResult Function(String message) unauthenticated,
  }) {
    return authenticated(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String message)? authenticated,
    TResult? Function(String message)? registered,
    TResult? Function()? loading,
    TResult? Function(String message)? saveProfileSuccess,
    TResult? Function()? savingProfileLoading,
    TResult? Function(String message)? unauthenticated,
  }) {
    return authenticated?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String message)? authenticated,
    TResult Function(String message)? registered,
    TResult Function()? loading,
    TResult Function(String message)? saveProfileSuccess,
    TResult Function()? savingProfileLoading,
    TResult Function(String message)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthRegistered value) registered,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSaveProfileSuccess value) saveProfileSuccess,
    required TResult Function(AuthSavingProfileLoading value)
        savingProfileLoading,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthRegistered value)? registered,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult? Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthError value)? error,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthRegistered value)? registered,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthAuthenticated implements AuthState {
  const factory AuthAuthenticated(final String message) =
      _$AuthAuthenticatedImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthRegisteredImplCopyWith<$Res> {
  factory _$$AuthRegisteredImplCopyWith(_$AuthRegisteredImpl value,
          $Res Function(_$AuthRegisteredImpl) then) =
      __$$AuthRegisteredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthRegisteredImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthRegisteredImpl>
    implements _$$AuthRegisteredImplCopyWith<$Res> {
  __$$AuthRegisteredImplCopyWithImpl(
      _$AuthRegisteredImpl _value, $Res Function(_$AuthRegisteredImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthRegisteredImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthRegisteredImpl
    with DiagnosticableTreeMixin
    implements AuthRegistered {
  const _$AuthRegisteredImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.registered(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.registered'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthRegisteredImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthRegisteredImplCopyWith<_$AuthRegisteredImpl> get copyWith =>
      __$$AuthRegisteredImplCopyWithImpl<_$AuthRegisteredImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String message) authenticated,
    required TResult Function(String message) registered,
    required TResult Function() loading,
    required TResult Function(String message) saveProfileSuccess,
    required TResult Function() savingProfileLoading,
    required TResult Function(String message) unauthenticated,
  }) {
    return registered(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String message)? authenticated,
    TResult? Function(String message)? registered,
    TResult? Function()? loading,
    TResult? Function(String message)? saveProfileSuccess,
    TResult? Function()? savingProfileLoading,
    TResult? Function(String message)? unauthenticated,
  }) {
    return registered?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String message)? authenticated,
    TResult Function(String message)? registered,
    TResult Function()? loading,
    TResult Function(String message)? saveProfileSuccess,
    TResult Function()? savingProfileLoading,
    TResult Function(String message)? unauthenticated,
    required TResult orElse(),
  }) {
    if (registered != null) {
      return registered(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthRegistered value) registered,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSaveProfileSuccess value) saveProfileSuccess,
    required TResult Function(AuthSavingProfileLoading value)
        savingProfileLoading,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return registered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthRegistered value)? registered,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult? Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return registered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthError value)? error,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthRegistered value)? registered,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (registered != null) {
      return registered(this);
    }
    return orElse();
  }
}

abstract class AuthRegistered implements AuthState {
  const factory AuthRegistered(final String message) = _$AuthRegisteredImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AuthRegisteredImplCopyWith<_$AuthRegisteredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthLoadingImplCopyWith<$Res> {
  factory _$$AuthLoadingImplCopyWith(
          _$AuthLoadingImpl value, $Res Function(_$AuthLoadingImpl) then) =
      __$$AuthLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthLoadingImpl>
    implements _$$AuthLoadingImplCopyWith<$Res> {
  __$$AuthLoadingImplCopyWithImpl(
      _$AuthLoadingImpl _value, $Res Function(_$AuthLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthLoadingImpl with DiagnosticableTreeMixin implements AuthLoading {
  const _$AuthLoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AuthState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String message) authenticated,
    required TResult Function(String message) registered,
    required TResult Function() loading,
    required TResult Function(String message) saveProfileSuccess,
    required TResult Function() savingProfileLoading,
    required TResult Function(String message) unauthenticated,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String message)? authenticated,
    TResult? Function(String message)? registered,
    TResult? Function()? loading,
    TResult? Function(String message)? saveProfileSuccess,
    TResult? Function()? savingProfileLoading,
    TResult? Function(String message)? unauthenticated,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String message)? authenticated,
    TResult Function(String message)? registered,
    TResult Function()? loading,
    TResult Function(String message)? saveProfileSuccess,
    TResult Function()? savingProfileLoading,
    TResult Function(String message)? unauthenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthRegistered value) registered,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSaveProfileSuccess value) saveProfileSuccess,
    required TResult Function(AuthSavingProfileLoading value)
        savingProfileLoading,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthRegistered value)? registered,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult? Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthError value)? error,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthRegistered value)? registered,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthLoading implements AuthState {
  const factory AuthLoading() = _$AuthLoadingImpl;
}

/// @nodoc
abstract class _$$AuthSaveProfileSuccessImplCopyWith<$Res> {
  factory _$$AuthSaveProfileSuccessImplCopyWith(
          _$AuthSaveProfileSuccessImpl value,
          $Res Function(_$AuthSaveProfileSuccessImpl) then) =
      __$$AuthSaveProfileSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthSaveProfileSuccessImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthSaveProfileSuccessImpl>
    implements _$$AuthSaveProfileSuccessImplCopyWith<$Res> {
  __$$AuthSaveProfileSuccessImplCopyWithImpl(
      _$AuthSaveProfileSuccessImpl _value,
      $Res Function(_$AuthSaveProfileSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthSaveProfileSuccessImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthSaveProfileSuccessImpl
    with DiagnosticableTreeMixin
    implements AuthSaveProfileSuccess {
  const _$AuthSaveProfileSuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.saveProfileSuccess(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.saveProfileSuccess'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSaveProfileSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSaveProfileSuccessImplCopyWith<_$AuthSaveProfileSuccessImpl>
      get copyWith => __$$AuthSaveProfileSuccessImplCopyWithImpl<
          _$AuthSaveProfileSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String message) authenticated,
    required TResult Function(String message) registered,
    required TResult Function() loading,
    required TResult Function(String message) saveProfileSuccess,
    required TResult Function() savingProfileLoading,
    required TResult Function(String message) unauthenticated,
  }) {
    return saveProfileSuccess(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String message)? authenticated,
    TResult? Function(String message)? registered,
    TResult? Function()? loading,
    TResult? Function(String message)? saveProfileSuccess,
    TResult? Function()? savingProfileLoading,
    TResult? Function(String message)? unauthenticated,
  }) {
    return saveProfileSuccess?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String message)? authenticated,
    TResult Function(String message)? registered,
    TResult Function()? loading,
    TResult Function(String message)? saveProfileSuccess,
    TResult Function()? savingProfileLoading,
    TResult Function(String message)? unauthenticated,
    required TResult orElse(),
  }) {
    if (saveProfileSuccess != null) {
      return saveProfileSuccess(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthRegistered value) registered,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSaveProfileSuccess value) saveProfileSuccess,
    required TResult Function(AuthSavingProfileLoading value)
        savingProfileLoading,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return saveProfileSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthRegistered value)? registered,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult? Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return saveProfileSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthError value)? error,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthRegistered value)? registered,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (saveProfileSuccess != null) {
      return saveProfileSuccess(this);
    }
    return orElse();
  }
}

abstract class AuthSaveProfileSuccess implements AuthState {
  const factory AuthSaveProfileSuccess(final String message) =
      _$AuthSaveProfileSuccessImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AuthSaveProfileSuccessImplCopyWith<_$AuthSaveProfileSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthSavingProfileLoadingImplCopyWith<$Res> {
  factory _$$AuthSavingProfileLoadingImplCopyWith(
          _$AuthSavingProfileLoadingImpl value,
          $Res Function(_$AuthSavingProfileLoadingImpl) then) =
      __$$AuthSavingProfileLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthSavingProfileLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthSavingProfileLoadingImpl>
    implements _$$AuthSavingProfileLoadingImplCopyWith<$Res> {
  __$$AuthSavingProfileLoadingImplCopyWithImpl(
      _$AuthSavingProfileLoadingImpl _value,
      $Res Function(_$AuthSavingProfileLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthSavingProfileLoadingImpl
    with DiagnosticableTreeMixin
    implements AuthSavingProfileLoading {
  const _$AuthSavingProfileLoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.savingProfileLoading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'AuthState.savingProfileLoading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSavingProfileLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String message) authenticated,
    required TResult Function(String message) registered,
    required TResult Function() loading,
    required TResult Function(String message) saveProfileSuccess,
    required TResult Function() savingProfileLoading,
    required TResult Function(String message) unauthenticated,
  }) {
    return savingProfileLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String message)? authenticated,
    TResult? Function(String message)? registered,
    TResult? Function()? loading,
    TResult? Function(String message)? saveProfileSuccess,
    TResult? Function()? savingProfileLoading,
    TResult? Function(String message)? unauthenticated,
  }) {
    return savingProfileLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String message)? authenticated,
    TResult Function(String message)? registered,
    TResult Function()? loading,
    TResult Function(String message)? saveProfileSuccess,
    TResult Function()? savingProfileLoading,
    TResult Function(String message)? unauthenticated,
    required TResult orElse(),
  }) {
    if (savingProfileLoading != null) {
      return savingProfileLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthRegistered value) registered,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSaveProfileSuccess value) saveProfileSuccess,
    required TResult Function(AuthSavingProfileLoading value)
        savingProfileLoading,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return savingProfileLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthRegistered value)? registered,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult? Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return savingProfileLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthError value)? error,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthRegistered value)? registered,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (savingProfileLoading != null) {
      return savingProfileLoading(this);
    }
    return orElse();
  }
}

abstract class AuthSavingProfileLoading implements AuthState {
  const factory AuthSavingProfileLoading() = _$AuthSavingProfileLoadingImpl;
}

/// @nodoc
abstract class _$$AuthUnauthenticatedImplCopyWith<$Res> {
  factory _$$AuthUnauthenticatedImplCopyWith(_$AuthUnauthenticatedImpl value,
          $Res Function(_$AuthUnauthenticatedImpl) then) =
      __$$AuthUnauthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthUnauthenticatedImpl>
    implements _$$AuthUnauthenticatedImplCopyWith<$Res> {
  __$$AuthUnauthenticatedImplCopyWithImpl(_$AuthUnauthenticatedImpl _value,
      $Res Function(_$AuthUnauthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthUnauthenticatedImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthUnauthenticatedImpl
    with DiagnosticableTreeMixin
    implements AuthUnauthenticated {
  const _$AuthUnauthenticatedImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.unauthenticated(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.unauthenticated'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUnauthenticatedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUnauthenticatedImplCopyWith<_$AuthUnauthenticatedImpl> get copyWith =>
      __$$AuthUnauthenticatedImplCopyWithImpl<_$AuthUnauthenticatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String message) authenticated,
    required TResult Function(String message) registered,
    required TResult Function() loading,
    required TResult Function(String message) saveProfileSuccess,
    required TResult Function() savingProfileLoading,
    required TResult Function(String message) unauthenticated,
  }) {
    return unauthenticated(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String message)? authenticated,
    TResult? Function(String message)? registered,
    TResult? Function()? loading,
    TResult? Function(String message)? saveProfileSuccess,
    TResult? Function()? savingProfileLoading,
    TResult? Function(String message)? unauthenticated,
  }) {
    return unauthenticated?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String message)? authenticated,
    TResult Function(String message)? registered,
    TResult Function()? loading,
    TResult Function(String message)? saveProfileSuccess,
    TResult Function()? savingProfileLoading,
    TResult Function(String message)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthRegistered value) registered,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthSaveProfileSuccess value) saveProfileSuccess,
    required TResult Function(AuthSavingProfileLoading value)
        savingProfileLoading,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthRegistered value)? registered,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult? Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthError value)? error,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthRegistered value)? registered,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthSaveProfileSuccess value)? saveProfileSuccess,
    TResult Function(AuthSavingProfileLoading value)? savingProfileLoading,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthUnauthenticated implements AuthState {
  const factory AuthUnauthenticated(final String message) =
      _$AuthUnauthenticatedImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AuthUnauthenticatedImplCopyWith<_$AuthUnauthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
