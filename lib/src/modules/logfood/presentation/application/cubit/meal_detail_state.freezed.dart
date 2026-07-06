// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MealDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MealDetail meal) loaded,
    required TResult Function(ApiError error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MealDetail meal)? loaded,
    TResult? Function(ApiError error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MealDetail meal)? loaded,
    TResult Function(ApiError error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MealDetailInitial value) initial,
    required TResult Function(MealDetailLoading value) loading,
    required TResult Function(MealDetailLoaded value) loaded,
    required TResult Function(MealDetailError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealDetailInitial value)? initial,
    TResult? Function(MealDetailLoading value)? loading,
    TResult? Function(MealDetailLoaded value)? loaded,
    TResult? Function(MealDetailError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealDetailInitial value)? initial,
    TResult Function(MealDetailLoading value)? loading,
    TResult Function(MealDetailLoaded value)? loaded,
    TResult Function(MealDetailError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealDetailStateCopyWith<$Res> {
  factory $MealDetailStateCopyWith(
          MealDetailState value, $Res Function(MealDetailState) then) =
      _$MealDetailStateCopyWithImpl<$Res, MealDetailState>;
}

/// @nodoc
class _$MealDetailStateCopyWithImpl<$Res, $Val extends MealDetailState>
    implements $MealDetailStateCopyWith<$Res> {
  _$MealDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MealDetailInitialImplCopyWith<$Res> {
  factory _$$MealDetailInitialImplCopyWith(_$MealDetailInitialImpl value,
          $Res Function(_$MealDetailInitialImpl) then) =
      __$$MealDetailInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MealDetailInitialImplCopyWithImpl<$Res>
    extends _$MealDetailStateCopyWithImpl<$Res, _$MealDetailInitialImpl>
    implements _$$MealDetailInitialImplCopyWith<$Res> {
  __$$MealDetailInitialImplCopyWithImpl(_$MealDetailInitialImpl _value,
      $Res Function(_$MealDetailInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MealDetailInitialImpl implements MealDetailInitial {
  const _$MealDetailInitialImpl();

  @override
  String toString() {
    return 'MealDetailState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MealDetailInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MealDetail meal) loaded,
    required TResult Function(ApiError error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MealDetail meal)? loaded,
    TResult? Function(ApiError error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MealDetail meal)? loaded,
    TResult Function(ApiError error)? error,
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
    required TResult Function(MealDetailInitial value) initial,
    required TResult Function(MealDetailLoading value) loading,
    required TResult Function(MealDetailLoaded value) loaded,
    required TResult Function(MealDetailError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealDetailInitial value)? initial,
    TResult? Function(MealDetailLoading value)? loading,
    TResult? Function(MealDetailLoaded value)? loaded,
    TResult? Function(MealDetailError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealDetailInitial value)? initial,
    TResult Function(MealDetailLoading value)? loading,
    TResult Function(MealDetailLoaded value)? loaded,
    TResult Function(MealDetailError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MealDetailInitial implements MealDetailState {
  const factory MealDetailInitial() = _$MealDetailInitialImpl;
}

/// @nodoc
abstract class _$$MealDetailLoadingImplCopyWith<$Res> {
  factory _$$MealDetailLoadingImplCopyWith(_$MealDetailLoadingImpl value,
          $Res Function(_$MealDetailLoadingImpl) then) =
      __$$MealDetailLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MealDetailLoadingImplCopyWithImpl<$Res>
    extends _$MealDetailStateCopyWithImpl<$Res, _$MealDetailLoadingImpl>
    implements _$$MealDetailLoadingImplCopyWith<$Res> {
  __$$MealDetailLoadingImplCopyWithImpl(_$MealDetailLoadingImpl _value,
      $Res Function(_$MealDetailLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MealDetailLoadingImpl implements MealDetailLoading {
  const _$MealDetailLoadingImpl();

  @override
  String toString() {
    return 'MealDetailState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MealDetailLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MealDetail meal) loaded,
    required TResult Function(ApiError error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MealDetail meal)? loaded,
    TResult? Function(ApiError error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MealDetail meal)? loaded,
    TResult Function(ApiError error)? error,
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
    required TResult Function(MealDetailInitial value) initial,
    required TResult Function(MealDetailLoading value) loading,
    required TResult Function(MealDetailLoaded value) loaded,
    required TResult Function(MealDetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealDetailInitial value)? initial,
    TResult? Function(MealDetailLoading value)? loading,
    TResult? Function(MealDetailLoaded value)? loaded,
    TResult? Function(MealDetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealDetailInitial value)? initial,
    TResult Function(MealDetailLoading value)? loading,
    TResult Function(MealDetailLoaded value)? loaded,
    TResult Function(MealDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MealDetailLoading implements MealDetailState {
  const factory MealDetailLoading() = _$MealDetailLoadingImpl;
}

/// @nodoc
abstract class _$$MealDetailLoadedImplCopyWith<$Res> {
  factory _$$MealDetailLoadedImplCopyWith(_$MealDetailLoadedImpl value,
          $Res Function(_$MealDetailLoadedImpl) then) =
      __$$MealDetailLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MealDetail meal});
}

/// @nodoc
class __$$MealDetailLoadedImplCopyWithImpl<$Res>
    extends _$MealDetailStateCopyWithImpl<$Res, _$MealDetailLoadedImpl>
    implements _$$MealDetailLoadedImplCopyWith<$Res> {
  __$$MealDetailLoadedImplCopyWithImpl(_$MealDetailLoadedImpl _value,
      $Res Function(_$MealDetailLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meal = null,
  }) {
    return _then(_$MealDetailLoadedImpl(
      null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as MealDetail,
    ));
  }
}

/// @nodoc

class _$MealDetailLoadedImpl implements MealDetailLoaded {
  const _$MealDetailLoadedImpl(this.meal);

  @override
  final MealDetail meal;

  @override
  String toString() {
    return 'MealDetailState.loaded(meal: $meal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealDetailLoadedImpl &&
            (identical(other.meal, meal) || other.meal == meal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, meal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MealDetailLoadedImplCopyWith<_$MealDetailLoadedImpl> get copyWith =>
      __$$MealDetailLoadedImplCopyWithImpl<_$MealDetailLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MealDetail meal) loaded,
    required TResult Function(ApiError error) error,
  }) {
    return loaded(meal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MealDetail meal)? loaded,
    TResult? Function(ApiError error)? error,
  }) {
    return loaded?.call(meal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MealDetail meal)? loaded,
    TResult Function(ApiError error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(meal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MealDetailInitial value) initial,
    required TResult Function(MealDetailLoading value) loading,
    required TResult Function(MealDetailLoaded value) loaded,
    required TResult Function(MealDetailError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealDetailInitial value)? initial,
    TResult? Function(MealDetailLoading value)? loading,
    TResult? Function(MealDetailLoaded value)? loaded,
    TResult? Function(MealDetailError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealDetailInitial value)? initial,
    TResult Function(MealDetailLoading value)? loading,
    TResult Function(MealDetailLoaded value)? loaded,
    TResult Function(MealDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MealDetailLoaded implements MealDetailState {
  const factory MealDetailLoaded(final MealDetail meal) =
      _$MealDetailLoadedImpl;

  MealDetail get meal;
  @JsonKey(ignore: true)
  _$$MealDetailLoadedImplCopyWith<_$MealDetailLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MealDetailErrorImplCopyWith<$Res> {
  factory _$$MealDetailErrorImplCopyWith(_$MealDetailErrorImpl value,
          $Res Function(_$MealDetailErrorImpl) then) =
      __$$MealDetailErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiError error});

  $ApiErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$MealDetailErrorImplCopyWithImpl<$Res>
    extends _$MealDetailStateCopyWithImpl<$Res, _$MealDetailErrorImpl>
    implements _$$MealDetailErrorImplCopyWith<$Res> {
  __$$MealDetailErrorImplCopyWithImpl(
      _$MealDetailErrorImpl _value, $Res Function(_$MealDetailErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$MealDetailErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiError,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ApiErrorCopyWith<$Res> get error {
    return $ApiErrorCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$MealDetailErrorImpl implements MealDetailError {
  const _$MealDetailErrorImpl(this.error);

  @override
  final ApiError error;

  @override
  String toString() {
    return 'MealDetailState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealDetailErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MealDetailErrorImplCopyWith<_$MealDetailErrorImpl> get copyWith =>
      __$$MealDetailErrorImplCopyWithImpl<_$MealDetailErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MealDetail meal) loaded,
    required TResult Function(ApiError error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MealDetail meal)? loaded,
    TResult? Function(ApiError error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MealDetail meal)? loaded,
    TResult Function(ApiError error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MealDetailInitial value) initial,
    required TResult Function(MealDetailLoading value) loading,
    required TResult Function(MealDetailLoaded value) loaded,
    required TResult Function(MealDetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealDetailInitial value)? initial,
    TResult? Function(MealDetailLoading value)? loading,
    TResult? Function(MealDetailLoaded value)? loaded,
    TResult? Function(MealDetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealDetailInitial value)? initial,
    TResult Function(MealDetailLoading value)? loading,
    TResult Function(MealDetailLoaded value)? loaded,
    TResult Function(MealDetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MealDetailError implements MealDetailState {
  const factory MealDetailError(final ApiError error) = _$MealDetailErrorImpl;

  ApiError get error;
  @JsonKey(ignore: true)
  _$$MealDetailErrorImplCopyWith<_$MealDetailErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
