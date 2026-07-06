// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutrient_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NutrientDetailState {
  DateTime get currentDate => throw _privateConstructorUsedError;
  String get selectedPeriod => throw _privateConstructorUsedError;
  String? get nutrientName => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)
        initial,
    required TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)
        loading,
    required TResult Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)
        loaded,
    required TResult Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        initial,
    TResult? Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        loading,
    TResult? Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)?
        loaded,
    TResult? Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        initial,
    TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        loading,
    TResult Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)?
        loaded,
    TResult Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NutrientDetailInitial value) initial,
    required TResult Function(NutrientDetailLoading value) loading,
    required TResult Function(NutrientDetailLoaded value) loaded,
    required TResult Function(NutrientDetailError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NutrientDetailInitial value)? initial,
    TResult? Function(NutrientDetailLoading value)? loading,
    TResult? Function(NutrientDetailLoaded value)? loaded,
    TResult? Function(NutrientDetailError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NutrientDetailInitial value)? initial,
    TResult Function(NutrientDetailLoading value)? loading,
    TResult Function(NutrientDetailLoaded value)? loaded,
    TResult Function(NutrientDetailError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NutrientDetailStateCopyWith<NutrientDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutrientDetailStateCopyWith<$Res> {
  factory $NutrientDetailStateCopyWith(
          NutrientDetailState value, $Res Function(NutrientDetailState) then) =
      _$NutrientDetailStateCopyWithImpl<$Res, NutrientDetailState>;
  @useResult
  $Res call(
      {DateTime currentDate, String selectedPeriod, String? nutrientName});
}

/// @nodoc
class _$NutrientDetailStateCopyWithImpl<$Res, $Val extends NutrientDetailState>
    implements $NutrientDetailStateCopyWith<$Res> {
  _$NutrientDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? selectedPeriod = null,
    Object? nutrientName = freezed,
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
      nutrientName: freezed == nutrientName
          ? _value.nutrientName
          : nutrientName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutrientDetailInitialImplCopyWith<$Res>
    implements $NutrientDetailStateCopyWith<$Res> {
  factory _$$NutrientDetailInitialImplCopyWith(
          _$NutrientDetailInitialImpl value,
          $Res Function(_$NutrientDetailInitialImpl) then) =
      __$$NutrientDetailInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime currentDate, String selectedPeriod, String? nutrientName});
}

/// @nodoc
class __$$NutrientDetailInitialImplCopyWithImpl<$Res>
    extends _$NutrientDetailStateCopyWithImpl<$Res, _$NutrientDetailInitialImpl>
    implements _$$NutrientDetailInitialImplCopyWith<$Res> {
  __$$NutrientDetailInitialImplCopyWithImpl(_$NutrientDetailInitialImpl _value,
      $Res Function(_$NutrientDetailInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? selectedPeriod = null,
    Object? nutrientName = freezed,
  }) {
    return _then(_$NutrientDetailInitialImpl(
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      nutrientName: freezed == nutrientName
          ? _value.nutrientName
          : nutrientName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NutrientDetailInitialImpl implements NutrientDetailInitial {
  const _$NutrientDetailInitialImpl(
      {required this.currentDate,
      this.selectedPeriod = 'Week View',
      this.nutrientName});

  @override
  final DateTime currentDate;
  @override
  @JsonKey()
  final String selectedPeriod;
  @override
  final String? nutrientName;

  @override
  String toString() {
    return 'NutrientDetailState.initial(currentDate: $currentDate, selectedPeriod: $selectedPeriod, nutrientName: $nutrientName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutrientDetailInitialImpl &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod) &&
            (identical(other.nutrientName, nutrientName) ||
                other.nutrientName == nutrientName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentDate, selectedPeriod, nutrientName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutrientDetailInitialImplCopyWith<_$NutrientDetailInitialImpl>
      get copyWith => __$$NutrientDetailInitialImplCopyWithImpl<
          _$NutrientDetailInitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)
        initial,
    required TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)
        loading,
    required TResult Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)
        loaded,
    required TResult Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)
        error,
  }) {
    return initial(currentDate, selectedPeriod, nutrientName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        initial,
    TResult? Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        loading,
    TResult? Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)?
        loaded,
    TResult? Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)?
        error,
  }) {
    return initial?.call(currentDate, selectedPeriod, nutrientName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        initial,
    TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        loading,
    TResult Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)?
        loaded,
    TResult Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(currentDate, selectedPeriod, nutrientName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NutrientDetailInitial value) initial,
    required TResult Function(NutrientDetailLoading value) loading,
    required TResult Function(NutrientDetailLoaded value) loaded,
    required TResult Function(NutrientDetailError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NutrientDetailInitial value)? initial,
    TResult? Function(NutrientDetailLoading value)? loading,
    TResult? Function(NutrientDetailLoaded value)? loaded,
    TResult? Function(NutrientDetailError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NutrientDetailInitial value)? initial,
    TResult Function(NutrientDetailLoading value)? loading,
    TResult Function(NutrientDetailLoaded value)? loaded,
    TResult Function(NutrientDetailError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class NutrientDetailInitial implements NutrientDetailState {
  const factory NutrientDetailInitial(
      {required final DateTime currentDate,
      final String selectedPeriod,
      final String? nutrientName}) = _$NutrientDetailInitialImpl;

  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  String? get nutrientName;
  @override
  @JsonKey(ignore: true)
  _$$NutrientDetailInitialImplCopyWith<_$NutrientDetailInitialImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NutrientDetailLoadingImplCopyWith<$Res>
    implements $NutrientDetailStateCopyWith<$Res> {
  factory _$$NutrientDetailLoadingImplCopyWith(
          _$NutrientDetailLoadingImpl value,
          $Res Function(_$NutrientDetailLoadingImpl) then) =
      __$$NutrientDetailLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime currentDate, String selectedPeriod, String? nutrientName});
}

/// @nodoc
class __$$NutrientDetailLoadingImplCopyWithImpl<$Res>
    extends _$NutrientDetailStateCopyWithImpl<$Res, _$NutrientDetailLoadingImpl>
    implements _$$NutrientDetailLoadingImplCopyWith<$Res> {
  __$$NutrientDetailLoadingImplCopyWithImpl(_$NutrientDetailLoadingImpl _value,
      $Res Function(_$NutrientDetailLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? selectedPeriod = null,
    Object? nutrientName = freezed,
  }) {
    return _then(_$NutrientDetailLoadingImpl(
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      nutrientName: freezed == nutrientName
          ? _value.nutrientName
          : nutrientName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NutrientDetailLoadingImpl implements NutrientDetailLoading {
  const _$NutrientDetailLoadingImpl(
      {required this.currentDate,
      required this.selectedPeriod,
      this.nutrientName});

  @override
  final DateTime currentDate;
  @override
  final String selectedPeriod;
  @override
  final String? nutrientName;

  @override
  String toString() {
    return 'NutrientDetailState.loading(currentDate: $currentDate, selectedPeriod: $selectedPeriod, nutrientName: $nutrientName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutrientDetailLoadingImpl &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod) &&
            (identical(other.nutrientName, nutrientName) ||
                other.nutrientName == nutrientName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentDate, selectedPeriod, nutrientName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutrientDetailLoadingImplCopyWith<_$NutrientDetailLoadingImpl>
      get copyWith => __$$NutrientDetailLoadingImplCopyWithImpl<
          _$NutrientDetailLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)
        initial,
    required TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)
        loading,
    required TResult Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)
        loaded,
    required TResult Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)
        error,
  }) {
    return loading(currentDate, selectedPeriod, nutrientName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        initial,
    TResult? Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        loading,
    TResult? Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)?
        loaded,
    TResult? Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)?
        error,
  }) {
    return loading?.call(currentDate, selectedPeriod, nutrientName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        initial,
    TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        loading,
    TResult Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)?
        loaded,
    TResult Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(currentDate, selectedPeriod, nutrientName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NutrientDetailInitial value) initial,
    required TResult Function(NutrientDetailLoading value) loading,
    required TResult Function(NutrientDetailLoaded value) loaded,
    required TResult Function(NutrientDetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NutrientDetailInitial value)? initial,
    TResult? Function(NutrientDetailLoading value)? loading,
    TResult? Function(NutrientDetailLoaded value)? loaded,
    TResult? Function(NutrientDetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NutrientDetailInitial value)? initial,
    TResult Function(NutrientDetailLoading value)? loading,
    TResult Function(NutrientDetailLoaded value)? loaded,
    TResult Function(NutrientDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NutrientDetailLoading implements NutrientDetailState {
  const factory NutrientDetailLoading(
      {required final DateTime currentDate,
      required final String selectedPeriod,
      final String? nutrientName}) = _$NutrientDetailLoadingImpl;

  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  String? get nutrientName;
  @override
  @JsonKey(ignore: true)
  _$$NutrientDetailLoadingImplCopyWith<_$NutrientDetailLoadingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NutrientDetailLoadedImplCopyWith<$Res>
    implements $NutrientDetailStateCopyWith<$Res> {
  factory _$$NutrientDetailLoadedImplCopyWith(_$NutrientDetailLoadedImpl value,
          $Res Function(_$NutrientDetailLoadedImpl) then) =
      __$$NutrientDetailLoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WeeklyNutritionData weeklyData,
      List<String> foodsHighestInNutrient,
      DateTime currentDate,
      String selectedPeriod,
      String? nutrientName});

  $WeeklyNutritionDataCopyWith<$Res> get weeklyData;
}

/// @nodoc
class __$$NutrientDetailLoadedImplCopyWithImpl<$Res>
    extends _$NutrientDetailStateCopyWithImpl<$Res, _$NutrientDetailLoadedImpl>
    implements _$$NutrientDetailLoadedImplCopyWith<$Res> {
  __$$NutrientDetailLoadedImplCopyWithImpl(_$NutrientDetailLoadedImpl _value,
      $Res Function(_$NutrientDetailLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weeklyData = null,
    Object? foodsHighestInNutrient = null,
    Object? currentDate = null,
    Object? selectedPeriod = null,
    Object? nutrientName = freezed,
  }) {
    return _then(_$NutrientDetailLoadedImpl(
      weeklyData: null == weeklyData
          ? _value.weeklyData
          : weeklyData // ignore: cast_nullable_to_non_nullable
              as WeeklyNutritionData,
      foodsHighestInNutrient: null == foodsHighestInNutrient
          ? _value._foodsHighestInNutrient
          : foodsHighestInNutrient // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      nutrientName: freezed == nutrientName
          ? _value.nutrientName
          : nutrientName // ignore: cast_nullable_to_non_nullable
              as String?,
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

class _$NutrientDetailLoadedImpl implements NutrientDetailLoaded {
  const _$NutrientDetailLoadedImpl(
      {required this.weeklyData,
      required final List<String> foodsHighestInNutrient,
      required this.currentDate,
      required this.selectedPeriod,
      this.nutrientName})
      : _foodsHighestInNutrient = foodsHighestInNutrient;

  @override
  final WeeklyNutritionData weeklyData;
  final List<String> _foodsHighestInNutrient;
  @override
  List<String> get foodsHighestInNutrient {
    if (_foodsHighestInNutrient is EqualUnmodifiableListView)
      return _foodsHighestInNutrient;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodsHighestInNutrient);
  }

  @override
  final DateTime currentDate;
  @override
  final String selectedPeriod;
  @override
  final String? nutrientName;

  @override
  String toString() {
    return 'NutrientDetailState.loaded(weeklyData: $weeklyData, foodsHighestInNutrient: $foodsHighestInNutrient, currentDate: $currentDate, selectedPeriod: $selectedPeriod, nutrientName: $nutrientName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutrientDetailLoadedImpl &&
            (identical(other.weeklyData, weeklyData) ||
                other.weeklyData == weeklyData) &&
            const DeepCollectionEquality().equals(
                other._foodsHighestInNutrient, _foodsHighestInNutrient) &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod) &&
            (identical(other.nutrientName, nutrientName) ||
                other.nutrientName == nutrientName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      weeklyData,
      const DeepCollectionEquality().hash(_foodsHighestInNutrient),
      currentDate,
      selectedPeriod,
      nutrientName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutrientDetailLoadedImplCopyWith<_$NutrientDetailLoadedImpl>
      get copyWith =>
          __$$NutrientDetailLoadedImplCopyWithImpl<_$NutrientDetailLoadedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)
        initial,
    required TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)
        loading,
    required TResult Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)
        loaded,
    required TResult Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)
        error,
  }) {
    return loaded(weeklyData, foodsHighestInNutrient, currentDate,
        selectedPeriod, nutrientName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        initial,
    TResult? Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        loading,
    TResult? Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)?
        loaded,
    TResult? Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)?
        error,
  }) {
    return loaded?.call(weeklyData, foodsHighestInNutrient, currentDate,
        selectedPeriod, nutrientName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        initial,
    TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        loading,
    TResult Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)?
        loaded,
    TResult Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(weeklyData, foodsHighestInNutrient, currentDate,
          selectedPeriod, nutrientName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NutrientDetailInitial value) initial,
    required TResult Function(NutrientDetailLoading value) loading,
    required TResult Function(NutrientDetailLoaded value) loaded,
    required TResult Function(NutrientDetailError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NutrientDetailInitial value)? initial,
    TResult? Function(NutrientDetailLoading value)? loading,
    TResult? Function(NutrientDetailLoaded value)? loaded,
    TResult? Function(NutrientDetailError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NutrientDetailInitial value)? initial,
    TResult Function(NutrientDetailLoading value)? loading,
    TResult Function(NutrientDetailLoaded value)? loaded,
    TResult Function(NutrientDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class NutrientDetailLoaded implements NutrientDetailState {
  const factory NutrientDetailLoaded(
      {required final WeeklyNutritionData weeklyData,
      required final List<String> foodsHighestInNutrient,
      required final DateTime currentDate,
      required final String selectedPeriod,
      final String? nutrientName}) = _$NutrientDetailLoadedImpl;

  WeeklyNutritionData get weeklyData;
  List<String> get foodsHighestInNutrient;
  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  String? get nutrientName;
  @override
  @JsonKey(ignore: true)
  _$$NutrientDetailLoadedImplCopyWith<_$NutrientDetailLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NutrientDetailErrorImplCopyWith<$Res>
    implements $NutrientDetailStateCopyWith<$Res> {
  factory _$$NutrientDetailErrorImplCopyWith(_$NutrientDetailErrorImpl value,
          $Res Function(_$NutrientDetailErrorImpl) then) =
      __$$NutrientDetailErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      DateTime currentDate,
      String selectedPeriod,
      String? nutrientName});
}

/// @nodoc
class __$$NutrientDetailErrorImplCopyWithImpl<$Res>
    extends _$NutrientDetailStateCopyWithImpl<$Res, _$NutrientDetailErrorImpl>
    implements _$$NutrientDetailErrorImplCopyWith<$Res> {
  __$$NutrientDetailErrorImplCopyWithImpl(_$NutrientDetailErrorImpl _value,
      $Res Function(_$NutrientDetailErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? currentDate = null,
    Object? selectedPeriod = null,
    Object? nutrientName = freezed,
  }) {
    return _then(_$NutrientDetailErrorImpl(
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
      nutrientName: freezed == nutrientName
          ? _value.nutrientName
          : nutrientName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NutrientDetailErrorImpl implements NutrientDetailError {
  const _$NutrientDetailErrorImpl(
      {required this.message,
      required this.currentDate,
      required this.selectedPeriod,
      this.nutrientName});

  @override
  final String message;
  @override
  final DateTime currentDate;
  @override
  final String selectedPeriod;
  @override
  final String? nutrientName;

  @override
  String toString() {
    return 'NutrientDetailState.error(message: $message, currentDate: $currentDate, selectedPeriod: $selectedPeriod, nutrientName: $nutrientName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutrientDetailErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod) &&
            (identical(other.nutrientName, nutrientName) ||
                other.nutrientName == nutrientName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, currentDate, selectedPeriod, nutrientName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutrientDetailErrorImplCopyWith<_$NutrientDetailErrorImpl> get copyWith =>
      __$$NutrientDetailErrorImplCopyWithImpl<_$NutrientDetailErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)
        initial,
    required TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)
        loading,
    required TResult Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)
        loaded,
    required TResult Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)
        error,
  }) {
    return error(message, currentDate, selectedPeriod, nutrientName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        initial,
    TResult? Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        loading,
    TResult? Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)?
        loaded,
    TResult? Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)?
        error,
  }) {
    return error?.call(message, currentDate, selectedPeriod, nutrientName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        initial,
    TResult Function(
            DateTime currentDate, String selectedPeriod, String? nutrientName)?
        loading,
    TResult Function(
            WeeklyNutritionData weeklyData,
            List<String> foodsHighestInNutrient,
            DateTime currentDate,
            String selectedPeriod,
            String? nutrientName)?
        loaded,
    TResult Function(String message, DateTime currentDate,
            String selectedPeriod, String? nutrientName)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, currentDate, selectedPeriod, nutrientName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NutrientDetailInitial value) initial,
    required TResult Function(NutrientDetailLoading value) loading,
    required TResult Function(NutrientDetailLoaded value) loaded,
    required TResult Function(NutrientDetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NutrientDetailInitial value)? initial,
    TResult? Function(NutrientDetailLoading value)? loading,
    TResult? Function(NutrientDetailLoaded value)? loaded,
    TResult? Function(NutrientDetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NutrientDetailInitial value)? initial,
    TResult Function(NutrientDetailLoading value)? loading,
    TResult Function(NutrientDetailLoaded value)? loaded,
    TResult Function(NutrientDetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class NutrientDetailError implements NutrientDetailState {
  const factory NutrientDetailError(
      {required final String message,
      required final DateTime currentDate,
      required final String selectedPeriod,
      final String? nutrientName}) = _$NutrientDetailErrorImpl;

  String get message;
  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  String? get nutrientName;
  @override
  @JsonKey(ignore: true)
  _$$NutrientDetailErrorImplCopyWith<_$NutrientDetailErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
