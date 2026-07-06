// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calorie_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CalorieState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)
        loaded,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)?
        loaded,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)?
        loaded,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalorieStateCopyWith<$Res> {
  factory $CalorieStateCopyWith(
          CalorieState value, $Res Function(CalorieState) then) =
      _$CalorieStateCopyWithImpl<$Res, CalorieState>;
}

/// @nodoc
class _$CalorieStateCopyWithImpl<$Res, $Val extends CalorieState>
    implements $CalorieStateCopyWith<$Res> {
  _$CalorieStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isError,
      String? errorMessage,
      CalorieEntity? todayCalories,
      MacroEntity? todayMacros,
      List<ActivityEntity> todayActivities,
      List<WeightEntity> weightHistory,
      int steps,
      int stepGoal});

  $CalorieEntityCopyWith<$Res>? get todayCalories;
  $MacroEntityCopyWith<$Res>? get todayMacros;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$CalorieStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = freezed,
    Object? todayCalories = freezed,
    Object? todayMacros = freezed,
    Object? todayActivities = null,
    Object? weightHistory = null,
    Object? steps = null,
    Object? stepGoal = null,
  }) {
    return _then(_$LoadedImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      todayCalories: freezed == todayCalories
          ? _value.todayCalories
          : todayCalories // ignore: cast_nullable_to_non_nullable
              as CalorieEntity?,
      todayMacros: freezed == todayMacros
          ? _value.todayMacros
          : todayMacros // ignore: cast_nullable_to_non_nullable
              as MacroEntity?,
      todayActivities: null == todayActivities
          ? _value._todayActivities
          : todayActivities // ignore: cast_nullable_to_non_nullable
              as List<ActivityEntity>,
      weightHistory: null == weightHistory
          ? _value._weightHistory
          : weightHistory // ignore: cast_nullable_to_non_nullable
              as List<WeightEntity>,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      stepGoal: null == stepGoal
          ? _value.stepGoal
          : stepGoal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $CalorieEntityCopyWith<$Res>? get todayCalories {
    if (_value.todayCalories == null) {
      return null;
    }

    return $CalorieEntityCopyWith<$Res>(_value.todayCalories!, (value) {
      return _then(_value.copyWith(todayCalories: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MacroEntityCopyWith<$Res>? get todayMacros {
    if (_value.todayMacros == null) {
      return null;
    }

    return $MacroEntityCopyWith<$Res>(_value.todayMacros!, (value) {
      return _then(_value.copyWith(todayMacros: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {this.isLoading = false,
      this.isError = false,
      this.errorMessage,
      this.todayCalories,
      this.todayMacros,
      final List<ActivityEntity> todayActivities = const [],
      final List<WeightEntity> weightHistory = const [],
      this.steps = 0,
      this.stepGoal = 10000})
      : _todayActivities = todayActivities,
        _weightHistory = weightHistory;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isError;
  @override
  final String? errorMessage;
  @override
  final CalorieEntity? todayCalories;
  @override
  final MacroEntity? todayMacros;
  final List<ActivityEntity> _todayActivities;
  @override
  @JsonKey()
  List<ActivityEntity> get todayActivities {
    if (_todayActivities is EqualUnmodifiableListView) return _todayActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todayActivities);
  }

  final List<WeightEntity> _weightHistory;
  @override
  @JsonKey()
  List<WeightEntity> get weightHistory {
    if (_weightHistory is EqualUnmodifiableListView) return _weightHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weightHistory);
  }

  @override
  @JsonKey()
  final int steps;
  @override
  @JsonKey()
  final int stepGoal;

  @override
  String toString() {
    return 'CalorieState.loaded(isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage, todayCalories: $todayCalories, todayMacros: $todayMacros, todayActivities: $todayActivities, weightHistory: $weightHistory, steps: $steps, stepGoal: $stepGoal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.todayCalories, todayCalories) ||
                other.todayCalories == todayCalories) &&
            (identical(other.todayMacros, todayMacros) ||
                other.todayMacros == todayMacros) &&
            const DeepCollectionEquality()
                .equals(other._todayActivities, _todayActivities) &&
            const DeepCollectionEquality()
                .equals(other._weightHistory, _weightHistory) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.stepGoal, stepGoal) ||
                other.stepGoal == stepGoal));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isError,
      errorMessage,
      todayCalories,
      todayMacros,
      const DeepCollectionEquality().hash(_todayActivities),
      const DeepCollectionEquality().hash(_weightHistory),
      steps,
      stepGoal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)
        loaded,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return loaded(isLoading, isError, errorMessage, todayCalories, todayMacros,
        todayActivities, weightHistory, steps, stepGoal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)?
        loaded,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(isLoading, isError, errorMessage, todayCalories,
        todayMacros, todayActivities, weightHistory, steps, stepGoal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)?
        loaded,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(isLoading, isError, errorMessage, todayCalories,
          todayMacros, todayActivities, weightHistory, steps, stepGoal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements CalorieState {
  const factory _Loaded(
      {final bool isLoading,
      final bool isError,
      final String? errorMessage,
      final CalorieEntity? todayCalories,
      final MacroEntity? todayMacros,
      final List<ActivityEntity> todayActivities,
      final List<WeightEntity> weightHistory,
      final int steps,
      final int stepGoal}) = _$LoadedImpl;

  bool get isLoading;
  bool get isError;
  String? get errorMessage;
  CalorieEntity? get todayCalories;
  MacroEntity? get todayMacros;
  List<ActivityEntity> get todayActivities;
  List<WeightEntity> get weightHistory;
  int get steps;
  int get stepGoal;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CalorieStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CalorieState.initial()';
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
    required TResult Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)
        loaded,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)?
        loaded,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)?
        loaded,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CalorieState {
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
    extends _$CalorieStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'CalorieState.loading()';
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
    required TResult Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)
        loaded,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)?
        loaded,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)?
        loaded,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements CalorieState {
  const factory _Loading() = _$LoadingImpl;
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
    extends _$CalorieStateCopyWithImpl<$Res, _$ErrorImpl>
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

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CalorieState.error(message: $message)';
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
    required TResult Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)
        loaded,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)?
        loaded,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool isLoading,
            bool isError,
            String? errorMessage,
            CalorieEntity? todayCalories,
            MacroEntity? todayMacros,
            List<ActivityEntity> todayActivities,
            List<WeightEntity> weightHistory,
            int steps,
            int stepGoal)?
        loaded,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements CalorieState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
