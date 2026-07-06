// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProgressState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressStateCopyWith<$Res> {
  factory $ProgressStateCopyWith(
          ProgressState value, $Res Function(ProgressState) then) =
      _$ProgressStateCopyWithImpl<$Res, ProgressState>;
}

/// @nodoc
class _$ProgressStateCopyWithImpl<$Res, $Val extends ProgressState>
    implements $ProgressStateCopyWith<$Res> {
  _$ProgressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'ProgressState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ProgressState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'ProgressState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ProgressState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProgressStats stats});

  $ProgressStatsCopyWith<$Res> get stats;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = null,
  }) {
    return _then(_$LoadedImpl(
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as ProgressStats,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ProgressStatsCopyWith<$Res> get stats {
    return $ProgressStatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl with DiagnosticableTreeMixin implements _Loaded {
  const _$LoadedImpl({required this.stats});

  @override
  final ProgressStats stats;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.loaded(stats: $stats)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProgressState.loaded'))
      ..add(DiagnosticsProperty('stats', stats));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stats);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return loaded(stats);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return loaded?.call(stats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(stats);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ProgressState {
  const factory _Loaded({required final ProgressStats stats}) = _$LoadedImpl;

  ProgressStats get stats;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl with DiagnosticableTreeMixin implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProgressState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ProgressState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddingImplCopyWith<$Res> {
  factory _$$AddingImplCopyWith(
          _$AddingImpl value, $Res Function(_$AddingImpl) then) =
      __$$AddingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddingImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$AddingImpl>
    implements _$$AddingImplCopyWith<$Res> {
  __$$AddingImplCopyWithImpl(
      _$AddingImpl _value, $Res Function(_$AddingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AddingImpl with DiagnosticableTreeMixin implements _Adding {
  const _$AddingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.adding()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'ProgressState.adding'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return adding();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return adding?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
    required TResult orElse(),
  }) {
    if (adding != null) {
      return adding();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return adding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return adding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (adding != null) {
      return adding(this);
    }
    return orElse();
  }
}

abstract class _Adding implements ProgressState {
  const factory _Adding() = _$AddingImpl;
}

/// @nodoc
abstract class _$$AddedSuccessImplCopyWith<$Res> {
  factory _$$AddedSuccessImplCopyWith(
          _$AddedSuccessImpl value, $Res Function(_$AddedSuccessImpl) then) =
      __$$AddedSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AddedSuccessImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$AddedSuccessImpl>
    implements _$$AddedSuccessImplCopyWith<$Res> {
  __$$AddedSuccessImplCopyWithImpl(
      _$AddedSuccessImpl _value, $Res Function(_$AddedSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AddedSuccessImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddedSuccessImpl with DiagnosticableTreeMixin implements _AddedSuccess {
  const _$AddedSuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.addedSuccess(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProgressState.addedSuccess'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddedSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddedSuccessImplCopyWith<_$AddedSuccessImpl> get copyWith =>
      __$$AddedSuccessImplCopyWithImpl<_$AddedSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return addedSuccess(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return addedSuccess?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
    required TResult orElse(),
  }) {
    if (addedSuccess != null) {
      return addedSuccess(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return addedSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return addedSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (addedSuccess != null) {
      return addedSuccess(this);
    }
    return orElse();
  }
}

abstract class _AddedSuccess implements ProgressState {
  const factory _AddedSuccess(final String message) = _$AddedSuccessImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AddedSuccessImplCopyWith<_$AddedSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatedSuccessImplCopyWith<$Res> {
  factory _$$UpdatedSuccessImplCopyWith(_$UpdatedSuccessImpl value,
          $Res Function(_$UpdatedSuccessImpl) then) =
      __$$UpdatedSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UpdatedSuccessImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$UpdatedSuccessImpl>
    implements _$$UpdatedSuccessImplCopyWith<$Res> {
  __$$UpdatedSuccessImplCopyWithImpl(
      _$UpdatedSuccessImpl _value, $Res Function(_$UpdatedSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UpdatedSuccessImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdatedSuccessImpl
    with DiagnosticableTreeMixin
    implements _UpdatedSuccess {
  const _$UpdatedSuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.updatedSuccess(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProgressState.updatedSuccess'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedSuccessImplCopyWith<_$UpdatedSuccessImpl> get copyWith =>
      __$$UpdatedSuccessImplCopyWithImpl<_$UpdatedSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return updatedSuccess(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return updatedSuccess?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
    required TResult orElse(),
  }) {
    if (updatedSuccess != null) {
      return updatedSuccess(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return updatedSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return updatedSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (updatedSuccess != null) {
      return updatedSuccess(this);
    }
    return orElse();
  }
}

abstract class _UpdatedSuccess implements ProgressState {
  const factory _UpdatedSuccess(final String message) = _$UpdatedSuccessImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$UpdatedSuccessImplCopyWith<_$UpdatedSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletedSuccessImplCopyWith<$Res> {
  factory _$$DeletedSuccessImplCopyWith(_$DeletedSuccessImpl value,
          $Res Function(_$DeletedSuccessImpl) then) =
      __$$DeletedSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$DeletedSuccessImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$DeletedSuccessImpl>
    implements _$$DeletedSuccessImplCopyWith<$Res> {
  __$$DeletedSuccessImplCopyWithImpl(
      _$DeletedSuccessImpl _value, $Res Function(_$DeletedSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$DeletedSuccessImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeletedSuccessImpl
    with DiagnosticableTreeMixin
    implements _DeletedSuccess {
  const _$DeletedSuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.deletedSuccess(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProgressState.deletedSuccess'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletedSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletedSuccessImplCopyWith<_$DeletedSuccessImpl> get copyWith =>
      __$$DeletedSuccessImplCopyWithImpl<_$DeletedSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return deletedSuccess(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return deletedSuccess?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
    required TResult orElse(),
  }) {
    if (deletedSuccess != null) {
      return deletedSuccess(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return deletedSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return deletedSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (deletedSuccess != null) {
      return deletedSuccess(this);
    }
    return orElse();
  }
}

abstract class _DeletedSuccess implements ProgressState {
  const factory _DeletedSuccess(final String message) = _$DeletedSuccessImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$DeletedSuccessImplCopyWith<_$DeletedSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddedFailureImplCopyWith<$Res> {
  factory _$$AddedFailureImplCopyWith(
          _$AddedFailureImpl value, $Res Function(_$AddedFailureImpl) then) =
      __$$AddedFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AddedFailureImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$AddedFailureImpl>
    implements _$$AddedFailureImplCopyWith<$Res> {
  __$$AddedFailureImplCopyWithImpl(
      _$AddedFailureImpl _value, $Res Function(_$AddedFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AddedFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddedFailureImpl with DiagnosticableTreeMixin implements _AddedFailure {
  const _$AddedFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.addedFailure(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProgressState.addedFailure'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddedFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddedFailureImplCopyWith<_$AddedFailureImpl> get copyWith =>
      __$$AddedFailureImplCopyWithImpl<_$AddedFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return addedFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return addedFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
    required TResult orElse(),
  }) {
    if (addedFailure != null) {
      return addedFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return addedFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return addedFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (addedFailure != null) {
      return addedFailure(this);
    }
    return orElse();
  }
}

abstract class _AddedFailure implements ProgressState {
  const factory _AddedFailure(final String message) = _$AddedFailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AddedFailureImplCopyWith<_$AddedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatedFailureImplCopyWith<$Res> {
  factory _$$UpdatedFailureImplCopyWith(_$UpdatedFailureImpl value,
          $Res Function(_$UpdatedFailureImpl) then) =
      __$$UpdatedFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UpdatedFailureImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$UpdatedFailureImpl>
    implements _$$UpdatedFailureImplCopyWith<$Res> {
  __$$UpdatedFailureImplCopyWithImpl(
      _$UpdatedFailureImpl _value, $Res Function(_$UpdatedFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UpdatedFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdatedFailureImpl
    with DiagnosticableTreeMixin
    implements _UpdatedFailure {
  const _$UpdatedFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.updatedFailure(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProgressState.updatedFailure'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedFailureImplCopyWith<_$UpdatedFailureImpl> get copyWith =>
      __$$UpdatedFailureImplCopyWithImpl<_$UpdatedFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return updatedFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return updatedFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
    required TResult orElse(),
  }) {
    if (updatedFailure != null) {
      return updatedFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return updatedFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return updatedFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (updatedFailure != null) {
      return updatedFailure(this);
    }
    return orElse();
  }
}

abstract class _UpdatedFailure implements ProgressState {
  const factory _UpdatedFailure(final String message) = _$UpdatedFailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$UpdatedFailureImplCopyWith<_$UpdatedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletedFailureImplCopyWith<$Res> {
  factory _$$DeletedFailureImplCopyWith(_$DeletedFailureImpl value,
          $Res Function(_$DeletedFailureImpl) then) =
      __$$DeletedFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$DeletedFailureImplCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$DeletedFailureImpl>
    implements _$$DeletedFailureImplCopyWith<$Res> {
  __$$DeletedFailureImplCopyWithImpl(
      _$DeletedFailureImpl _value, $Res Function(_$DeletedFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$DeletedFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeletedFailureImpl
    with DiagnosticableTreeMixin
    implements _DeletedFailure {
  const _$DeletedFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProgressState.deletedFailure(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProgressState.deletedFailure'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletedFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletedFailureImplCopyWith<_$DeletedFailureImpl> get copyWith =>
      __$$DeletedFailureImplCopyWithImpl<_$DeletedFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProgressStats stats) loaded,
    required TResult Function(String message) error,
    required TResult Function() adding,
    required TResult Function(String message) addedSuccess,
    required TResult Function(String message) updatedSuccess,
    required TResult Function(String message) deletedSuccess,
    required TResult Function(String message) addedFailure,
    required TResult Function(String message) updatedFailure,
    required TResult Function(String message) deletedFailure,
  }) {
    return deletedFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProgressStats stats)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? adding,
    TResult? Function(String message)? addedSuccess,
    TResult? Function(String message)? updatedSuccess,
    TResult? Function(String message)? deletedSuccess,
    TResult? Function(String message)? addedFailure,
    TResult? Function(String message)? updatedFailure,
    TResult? Function(String message)? deletedFailure,
  }) {
    return deletedFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProgressStats stats)? loaded,
    TResult Function(String message)? error,
    TResult Function()? adding,
    TResult Function(String message)? addedSuccess,
    TResult Function(String message)? updatedSuccess,
    TResult Function(String message)? deletedSuccess,
    TResult Function(String message)? addedFailure,
    TResult Function(String message)? updatedFailure,
    TResult Function(String message)? deletedFailure,
    required TResult orElse(),
  }) {
    if (deletedFailure != null) {
      return deletedFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Adding value) adding,
    required TResult Function(_AddedSuccess value) addedSuccess,
    required TResult Function(_UpdatedSuccess value) updatedSuccess,
    required TResult Function(_DeletedSuccess value) deletedSuccess,
    required TResult Function(_AddedFailure value) addedFailure,
    required TResult Function(_UpdatedFailure value) updatedFailure,
    required TResult Function(_DeletedFailure value) deletedFailure,
  }) {
    return deletedFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Adding value)? adding,
    TResult? Function(_AddedSuccess value)? addedSuccess,
    TResult? Function(_UpdatedSuccess value)? updatedSuccess,
    TResult? Function(_DeletedSuccess value)? deletedSuccess,
    TResult? Function(_AddedFailure value)? addedFailure,
    TResult? Function(_UpdatedFailure value)? updatedFailure,
    TResult? Function(_DeletedFailure value)? deletedFailure,
  }) {
    return deletedFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Adding value)? adding,
    TResult Function(_AddedSuccess value)? addedSuccess,
    TResult Function(_UpdatedSuccess value)? updatedSuccess,
    TResult Function(_DeletedSuccess value)? deletedSuccess,
    TResult Function(_AddedFailure value)? addedFailure,
    TResult Function(_UpdatedFailure value)? updatedFailure,
    TResult Function(_DeletedFailure value)? deletedFailure,
    required TResult orElse(),
  }) {
    if (deletedFailure != null) {
      return deletedFailure(this);
    }
    return orElse();
  }
}

abstract class _DeletedFailure implements ProgressState {
  const factory _DeletedFailure(final String message) = _$DeletedFailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$DeletedFailureImplCopyWith<_$DeletedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
