// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutrition_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NutritionState {
  DateTime get currentDate => throw _privateConstructorUsedError;
  String get selectedPeriod => throw _privateConstructorUsedError;
  bool get isNetMode => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)
        initial,
    required TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)
        loading,
    required TResult Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)
        loaded,
    required TResult Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        initial,
    TResult? Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        loading,
    TResult? Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)?
        loaded,
    TResult? Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        initial,
    TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        loading,
    TResult Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)?
        loaded,
    TResult Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NutritionInitial value) initial,
    required TResult Function(NutritionLoading value) loading,
    required TResult Function(NutritionLoaded value) loaded,
    required TResult Function(NutritionError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NutritionInitial value)? initial,
    TResult? Function(NutritionLoading value)? loading,
    TResult? Function(NutritionLoaded value)? loaded,
    TResult? Function(NutritionError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NutritionInitial value)? initial,
    TResult Function(NutritionLoading value)? loading,
    TResult Function(NutritionLoaded value)? loaded,
    TResult Function(NutritionError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NutritionStateCopyWith<NutritionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionStateCopyWith<$Res> {
  factory $NutritionStateCopyWith(
          NutritionState value, $Res Function(NutritionState) then) =
      _$NutritionStateCopyWithImpl<$Res, NutritionState>;
  @useResult
  $Res call({DateTime currentDate, String selectedPeriod, bool isNetMode});
}

/// @nodoc
class _$NutritionStateCopyWithImpl<$Res, $Val extends NutritionState>
    implements $NutritionStateCopyWith<$Res> {
  _$NutritionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? selectedPeriod = null,
    Object? isNetMode = null,
  }) {
    return _then(_value.copyWith(
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      isNetMode: null == isNetMode
          ? _value.isNetMode
          : isNetMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionInitialImplCopyWith<$Res>
    implements $NutritionStateCopyWith<$Res> {
  factory _$$NutritionInitialImplCopyWith(_$NutritionInitialImpl value,
          $Res Function(_$NutritionInitialImpl) then) =
      __$$NutritionInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime currentDate, String selectedPeriod, bool isNetMode});
}

/// @nodoc
class __$$NutritionInitialImplCopyWithImpl<$Res>
    extends _$NutritionStateCopyWithImpl<$Res, _$NutritionInitialImpl>
    implements _$$NutritionInitialImplCopyWith<$Res> {
  __$$NutritionInitialImplCopyWithImpl(_$NutritionInitialImpl _value,
      $Res Function(_$NutritionInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? selectedPeriod = null,
    Object? isNetMode = null,
  }) {
    return _then(_$NutritionInitialImpl(
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      isNetMode: null == isNetMode
          ? _value.isNetMode
          : isNetMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NutritionInitialImpl implements NutritionInitial {
  const _$NutritionInitialImpl(
      {required this.currentDate,
      this.selectedPeriod = 'Week View',
      this.isNetMode = false});

  @override
  final DateTime currentDate;
  @override
  @JsonKey()
  final String selectedPeriod;
  @override
  @JsonKey()
  final bool isNetMode;

  @override
  String toString() {
    return 'NutritionState.initial(currentDate: $currentDate, selectedPeriod: $selectedPeriod, isNetMode: $isNetMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionInitialImpl &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod) &&
            (identical(other.isNetMode, isNetMode) ||
                other.isNetMode == isNetMode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentDate, selectedPeriod, isNetMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionInitialImplCopyWith<_$NutritionInitialImpl> get copyWith =>
      __$$NutritionInitialImplCopyWithImpl<_$NutritionInitialImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)
        initial,
    required TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)
        loading,
    required TResult Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)
        loaded,
    required TResult Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)
        error,
  }) {
    return initial(currentDate, selectedPeriod, isNetMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        initial,
    TResult? Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        loading,
    TResult? Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)?
        loaded,
    TResult? Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)?
        error,
  }) {
    return initial?.call(currentDate, selectedPeriod, isNetMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        initial,
    TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        loading,
    TResult Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)?
        loaded,
    TResult Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(currentDate, selectedPeriod, isNetMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NutritionInitial value) initial,
    required TResult Function(NutritionLoading value) loading,
    required TResult Function(NutritionLoaded value) loaded,
    required TResult Function(NutritionError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NutritionInitial value)? initial,
    TResult? Function(NutritionLoading value)? loading,
    TResult? Function(NutritionLoaded value)? loaded,
    TResult? Function(NutritionError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NutritionInitial value)? initial,
    TResult Function(NutritionLoading value)? loading,
    TResult Function(NutritionLoaded value)? loaded,
    TResult Function(NutritionError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class NutritionInitial implements NutritionState {
  const factory NutritionInitial(
      {required final DateTime currentDate,
      final String selectedPeriod,
      final bool isNetMode}) = _$NutritionInitialImpl;

  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  bool get isNetMode;
  @override
  @JsonKey(ignore: true)
  _$$NutritionInitialImplCopyWith<_$NutritionInitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NutritionLoadingImplCopyWith<$Res>
    implements $NutritionStateCopyWith<$Res> {
  factory _$$NutritionLoadingImplCopyWith(_$NutritionLoadingImpl value,
          $Res Function(_$NutritionLoadingImpl) then) =
      __$$NutritionLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime currentDate, String selectedPeriod, bool isNetMode});
}

/// @nodoc
class __$$NutritionLoadingImplCopyWithImpl<$Res>
    extends _$NutritionStateCopyWithImpl<$Res, _$NutritionLoadingImpl>
    implements _$$NutritionLoadingImplCopyWith<$Res> {
  __$$NutritionLoadingImplCopyWithImpl(_$NutritionLoadingImpl _value,
      $Res Function(_$NutritionLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? selectedPeriod = null,
    Object? isNetMode = null,
  }) {
    return _then(_$NutritionLoadingImpl(
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      isNetMode: null == isNetMode
          ? _value.isNetMode
          : isNetMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NutritionLoadingImpl implements NutritionLoading {
  const _$NutritionLoadingImpl(
      {required this.currentDate,
      required this.selectedPeriod,
      this.isNetMode = false});

  @override
  final DateTime currentDate;
  @override
  final String selectedPeriod;
  @override
  @JsonKey()
  final bool isNetMode;

  @override
  String toString() {
    return 'NutritionState.loading(currentDate: $currentDate, selectedPeriod: $selectedPeriod, isNetMode: $isNetMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionLoadingImpl &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod) &&
            (identical(other.isNetMode, isNetMode) ||
                other.isNetMode == isNetMode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentDate, selectedPeriod, isNetMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionLoadingImplCopyWith<_$NutritionLoadingImpl> get copyWith =>
      __$$NutritionLoadingImplCopyWithImpl<_$NutritionLoadingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)
        initial,
    required TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)
        loading,
    required TResult Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)
        loaded,
    required TResult Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)
        error,
  }) {
    return loading(currentDate, selectedPeriod, isNetMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        initial,
    TResult? Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        loading,
    TResult? Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)?
        loaded,
    TResult? Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)?
        error,
  }) {
    return loading?.call(currentDate, selectedPeriod, isNetMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        initial,
    TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        loading,
    TResult Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)?
        loaded,
    TResult Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(currentDate, selectedPeriod, isNetMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NutritionInitial value) initial,
    required TResult Function(NutritionLoading value) loading,
    required TResult Function(NutritionLoaded value) loaded,
    required TResult Function(NutritionError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NutritionInitial value)? initial,
    TResult? Function(NutritionLoading value)? loading,
    TResult? Function(NutritionLoaded value)? loaded,
    TResult? Function(NutritionError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NutritionInitial value)? initial,
    TResult Function(NutritionLoading value)? loading,
    TResult Function(NutritionLoaded value)? loaded,
    TResult Function(NutritionError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NutritionLoading implements NutritionState {
  const factory NutritionLoading(
      {required final DateTime currentDate,
      required final String selectedPeriod,
      final bool isNetMode}) = _$NutritionLoadingImpl;

  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  bool get isNetMode;
  @override
  @JsonKey(ignore: true)
  _$$NutritionLoadingImplCopyWith<_$NutritionLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NutritionLoadedImplCopyWith<$Res>
    implements $NutritionStateCopyWith<$Res> {
  factory _$$NutritionLoadedImplCopyWith(_$NutritionLoadedImpl value,
          $Res Function(_$NutritionLoadedImpl) then) =
      __$$NutritionLoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WeeklyNutritionData weeklyData,
      DateTime currentDate,
      String selectedPeriod,
      bool isNetMode,
      bool fresh,
      List<String> foodsHighestInCalories,
      List<String> foodsHighestInCarbohydrates,
      List<String> foodsHighestInFat,
      List<String> foodsHighestInProtein});

  $WeeklyNutritionDataCopyWith<$Res> get weeklyData;
}

/// @nodoc
class __$$NutritionLoadedImplCopyWithImpl<$Res>
    extends _$NutritionStateCopyWithImpl<$Res, _$NutritionLoadedImpl>
    implements _$$NutritionLoadedImplCopyWith<$Res> {
  __$$NutritionLoadedImplCopyWithImpl(
      _$NutritionLoadedImpl _value, $Res Function(_$NutritionLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weeklyData = null,
    Object? currentDate = null,
    Object? selectedPeriod = null,
    Object? isNetMode = null,
    Object? fresh = null,
    Object? foodsHighestInCalories = null,
    Object? foodsHighestInCarbohydrates = null,
    Object? foodsHighestInFat = null,
    Object? foodsHighestInProtein = null,
  }) {
    return _then(_$NutritionLoadedImpl(
      weeklyData: null == weeklyData
          ? _value.weeklyData
          : weeklyData // ignore: cast_nullable_to_non_nullable
              as WeeklyNutritionData,
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      isNetMode: null == isNetMode
          ? _value.isNetMode
          : isNetMode // ignore: cast_nullable_to_non_nullable
              as bool,
      fresh: null == fresh
          ? _value.fresh
          : fresh // ignore: cast_nullable_to_non_nullable
              as bool,
      foodsHighestInCalories: null == foodsHighestInCalories
          ? _value._foodsHighestInCalories
          : foodsHighestInCalories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      foodsHighestInCarbohydrates: null == foodsHighestInCarbohydrates
          ? _value._foodsHighestInCarbohydrates
          : foodsHighestInCarbohydrates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      foodsHighestInFat: null == foodsHighestInFat
          ? _value._foodsHighestInFat
          : foodsHighestInFat // ignore: cast_nullable_to_non_nullable
              as List<String>,
      foodsHighestInProtein: null == foodsHighestInProtein
          ? _value._foodsHighestInProtein
          : foodsHighestInProtein // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $WeeklyNutritionDataCopyWith<$Res> get weeklyData {
    return $WeeklyNutritionDataCopyWith<$Res>(_value.weeklyData, (value) {
      return _then(_value.copyWith(weeklyData: value));
    });
  }
}

/// @nodoc

class _$NutritionLoadedImpl implements NutritionLoaded {
  const _$NutritionLoadedImpl(
      {required this.weeklyData,
      required this.currentDate,
      required this.selectedPeriod,
      this.isNetMode = false,
      this.fresh = false,
      final List<String> foodsHighestInCalories = const [],
      final List<String> foodsHighestInCarbohydrates = const [],
      final List<String> foodsHighestInFat = const [],
      final List<String> foodsHighestInProtein = const []})
      : _foodsHighestInCalories = foodsHighestInCalories,
        _foodsHighestInCarbohydrates = foodsHighestInCarbohydrates,
        _foodsHighestInFat = foodsHighestInFat,
        _foodsHighestInProtein = foodsHighestInProtein;

  @override
  final WeeklyNutritionData weeklyData;
  @override
  final DateTime currentDate;
  @override
  final String selectedPeriod;
  @override
  @JsonKey()
  final bool isNetMode;
  @override
  @JsonKey()
  final bool fresh;
  final List<String> _foodsHighestInCalories;
  @override
  @JsonKey()
  List<String> get foodsHighestInCalories {
    if (_foodsHighestInCalories is EqualUnmodifiableListView)
      return _foodsHighestInCalories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodsHighestInCalories);
  }

  final List<String> _foodsHighestInCarbohydrates;
  @override
  @JsonKey()
  List<String> get foodsHighestInCarbohydrates {
    if (_foodsHighestInCarbohydrates is EqualUnmodifiableListView)
      return _foodsHighestInCarbohydrates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodsHighestInCarbohydrates);
  }

  final List<String> _foodsHighestInFat;
  @override
  @JsonKey()
  List<String> get foodsHighestInFat {
    if (_foodsHighestInFat is EqualUnmodifiableListView)
      return _foodsHighestInFat;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodsHighestInFat);
  }

  final List<String> _foodsHighestInProtein;
  @override
  @JsonKey()
  List<String> get foodsHighestInProtein {
    if (_foodsHighestInProtein is EqualUnmodifiableListView)
      return _foodsHighestInProtein;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodsHighestInProtein);
  }

  @override
  String toString() {
    return 'NutritionState.loaded(weeklyData: $weeklyData, currentDate: $currentDate, selectedPeriod: $selectedPeriod, isNetMode: $isNetMode, fresh: $fresh, foodsHighestInCalories: $foodsHighestInCalories, foodsHighestInCarbohydrates: $foodsHighestInCarbohydrates, foodsHighestInFat: $foodsHighestInFat, foodsHighestInProtein: $foodsHighestInProtein)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionLoadedImpl &&
            (identical(other.weeklyData, weeklyData) ||
                other.weeklyData == weeklyData) &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod) &&
            (identical(other.isNetMode, isNetMode) ||
                other.isNetMode == isNetMode) &&
            (identical(other.fresh, fresh) || other.fresh == fresh) &&
            const DeepCollectionEquality().equals(
                other._foodsHighestInCalories, _foodsHighestInCalories) &&
            const DeepCollectionEquality().equals(
                other._foodsHighestInCarbohydrates,
                _foodsHighestInCarbohydrates) &&
            const DeepCollectionEquality()
                .equals(other._foodsHighestInFat, _foodsHighestInFat) &&
            const DeepCollectionEquality()
                .equals(other._foodsHighestInProtein, _foodsHighestInProtein));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      weeklyData,
      currentDate,
      selectedPeriod,
      isNetMode,
      fresh,
      const DeepCollectionEquality().hash(_foodsHighestInCalories),
      const DeepCollectionEquality().hash(_foodsHighestInCarbohydrates),
      const DeepCollectionEquality().hash(_foodsHighestInFat),
      const DeepCollectionEquality().hash(_foodsHighestInProtein));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionLoadedImplCopyWith<_$NutritionLoadedImpl> get copyWith =>
      __$$NutritionLoadedImplCopyWithImpl<_$NutritionLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)
        initial,
    required TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)
        loading,
    required TResult Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)
        loaded,
    required TResult Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)
        error,
  }) {
    return loaded(
        weeklyData,
        currentDate,
        selectedPeriod,
        isNetMode,
        fresh,
        foodsHighestInCalories,
        foodsHighestInCarbohydrates,
        foodsHighestInFat,
        foodsHighestInProtein);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        initial,
    TResult? Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        loading,
    TResult? Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)?
        loaded,
    TResult? Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)?
        error,
  }) {
    return loaded?.call(
        weeklyData,
        currentDate,
        selectedPeriod,
        isNetMode,
        fresh,
        foodsHighestInCalories,
        foodsHighestInCarbohydrates,
        foodsHighestInFat,
        foodsHighestInProtein);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        initial,
    TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        loading,
    TResult Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)?
        loaded,
    TResult Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          weeklyData,
          currentDate,
          selectedPeriod,
          isNetMode,
          fresh,
          foodsHighestInCalories,
          foodsHighestInCarbohydrates,
          foodsHighestInFat,
          foodsHighestInProtein);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NutritionInitial value) initial,
    required TResult Function(NutritionLoading value) loading,
    required TResult Function(NutritionLoaded value) loaded,
    required TResult Function(NutritionError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NutritionInitial value)? initial,
    TResult? Function(NutritionLoading value)? loading,
    TResult? Function(NutritionLoaded value)? loaded,
    TResult? Function(NutritionError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NutritionInitial value)? initial,
    TResult Function(NutritionLoading value)? loading,
    TResult Function(NutritionLoaded value)? loaded,
    TResult Function(NutritionError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class NutritionLoaded implements NutritionState {
  const factory NutritionLoaded(
      {required final WeeklyNutritionData weeklyData,
      required final DateTime currentDate,
      required final String selectedPeriod,
      final bool isNetMode,
      final bool fresh,
      final List<String> foodsHighestInCalories,
      final List<String> foodsHighestInCarbohydrates,
      final List<String> foodsHighestInFat,
      final List<String> foodsHighestInProtein}) = _$NutritionLoadedImpl;

  WeeklyNutritionData get weeklyData;
  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  bool get isNetMode;
  bool get fresh;
  List<String> get foodsHighestInCalories;
  List<String> get foodsHighestInCarbohydrates;
  List<String> get foodsHighestInFat;
  List<String> get foodsHighestInProtein;
  @override
  @JsonKey(ignore: true)
  _$$NutritionLoadedImplCopyWith<_$NutritionLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NutritionErrorImplCopyWith<$Res>
    implements $NutritionStateCopyWith<$Res> {
  factory _$$NutritionErrorImplCopyWith(_$NutritionErrorImpl value,
          $Res Function(_$NutritionErrorImpl) then) =
      __$$NutritionErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      DateTime currentDate,
      String selectedPeriod,
      bool isNetMode,
      WeeklyNutritionData? weeklyData});

  $WeeklyNutritionDataCopyWith<$Res>? get weeklyData;
}

/// @nodoc
class __$$NutritionErrorImplCopyWithImpl<$Res>
    extends _$NutritionStateCopyWithImpl<$Res, _$NutritionErrorImpl>
    implements _$$NutritionErrorImplCopyWith<$Res> {
  __$$NutritionErrorImplCopyWithImpl(
      _$NutritionErrorImpl _value, $Res Function(_$NutritionErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? currentDate = null,
    Object? selectedPeriod = null,
    Object? isNetMode = null,
    Object? weeklyData = freezed,
  }) {
    return _then(_$NutritionErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      isNetMode: null == isNetMode
          ? _value.isNetMode
          : isNetMode // ignore: cast_nullable_to_non_nullable
              as bool,
      weeklyData: freezed == weeklyData
          ? _value.weeklyData
          : weeklyData // ignore: cast_nullable_to_non_nullable
              as WeeklyNutritionData?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $WeeklyNutritionDataCopyWith<$Res>? get weeklyData {
    if (_value.weeklyData == null) {
      return null;
    }

    return $WeeklyNutritionDataCopyWith<$Res>(_value.weeklyData!, (value) {
      return _then(_value.copyWith(weeklyData: value));
    });
  }
}

/// @nodoc

class _$NutritionErrorImpl implements NutritionError {
  const _$NutritionErrorImpl(
      {required this.message,
      required this.currentDate,
      required this.selectedPeriod,
      this.isNetMode = false,
      this.weeklyData});

  @override
  final String message;
  @override
  final DateTime currentDate;
  @override
  final String selectedPeriod;
  @override
  @JsonKey()
  final bool isNetMode;
  @override
  final WeeklyNutritionData? weeklyData;

  @override
  String toString() {
    return 'NutritionState.error(message: $message, currentDate: $currentDate, selectedPeriod: $selectedPeriod, isNetMode: $isNetMode, weeklyData: $weeklyData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod) &&
            (identical(other.isNetMode, isNetMode) ||
                other.isNetMode == isNetMode) &&
            (identical(other.weeklyData, weeklyData) ||
                other.weeklyData == weeklyData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, currentDate, selectedPeriod, isNetMode, weeklyData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionErrorImplCopyWith<_$NutritionErrorImpl> get copyWith =>
      __$$NutritionErrorImplCopyWithImpl<_$NutritionErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)
        initial,
    required TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)
        loading,
    required TResult Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)
        loaded,
    required TResult Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)
        error,
  }) {
    return error(message, currentDate, selectedPeriod, isNetMode, weeklyData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        initial,
    TResult? Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        loading,
    TResult? Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)?
        loaded,
    TResult? Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)?
        error,
  }) {
    return error?.call(
        message, currentDate, selectedPeriod, isNetMode, weeklyData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        initial,
    TResult Function(
            DateTime currentDate, String selectedPeriod, bool isNetMode)?
        loading,
    TResult Function(
            WeeklyNutritionData weeklyData,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            bool fresh,
            List<String> foodsHighestInCalories,
            List<String> foodsHighestInCarbohydrates,
            List<String> foodsHighestInFat,
            List<String> foodsHighestInProtein)?
        loaded,
    TResult Function(
            String message,
            DateTime currentDate,
            String selectedPeriod,
            bool isNetMode,
            WeeklyNutritionData? weeklyData)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, currentDate, selectedPeriod, isNetMode, weeklyData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NutritionInitial value) initial,
    required TResult Function(NutritionLoading value) loading,
    required TResult Function(NutritionLoaded value) loaded,
    required TResult Function(NutritionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NutritionInitial value)? initial,
    TResult? Function(NutritionLoading value)? loading,
    TResult? Function(NutritionLoaded value)? loaded,
    TResult? Function(NutritionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NutritionInitial value)? initial,
    TResult Function(NutritionLoading value)? loading,
    TResult Function(NutritionLoaded value)? loaded,
    TResult Function(NutritionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class NutritionError implements NutritionState {
  const factory NutritionError(
      {required final String message,
      required final DateTime currentDate,
      required final String selectedPeriod,
      final bool isNetMode,
      final WeeklyNutritionData? weeklyData}) = _$NutritionErrorImpl;

  String get message;
  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  bool get isNetMode;
  WeeklyNutritionData? get weeklyData;
  @override
  @JsonKey(ignore: true)
  _$$NutritionErrorImplCopyWith<_$NutritionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
