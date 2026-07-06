// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutrition_data_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailyCalorieData {
  DateTime get date => throw _privateConstructorUsedError;
  double get totalCalories => throw _privateConstructorUsedError;
  double get netCalories => throw _privateConstructorUsedError;
  double get goal => throw _privateConstructorUsedError;
  String get dayLabel => throw _privateConstructorUsedError;
  double get breakfastCalories => throw _privateConstructorUsedError;
  double get lunchCalories => throw _privateConstructorUsedError;
  double get dinnerCalories => throw _privateConstructorUsedError;
  double get snacksCalories => throw _privateConstructorUsedError;
  double get carbs => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;
  double get protein => throw _privateConstructorUsedError;
  NutrientsData get breakfastNutrients => throw _privateConstructorUsedError;
  NutrientsData get lunchNutrients => throw _privateConstructorUsedError;
  NutrientsData get dinnerNutrients => throw _privateConstructorUsedError;
  NutrientsData get snacksNutrients => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyCalorieDataCopyWith<DailyCalorieData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyCalorieDataCopyWith<$Res> {
  factory $DailyCalorieDataCopyWith(
          DailyCalorieData value, $Res Function(DailyCalorieData) then) =
      _$DailyCalorieDataCopyWithImpl<$Res, DailyCalorieData>;
  @useResult
  $Res call(
      {DateTime date,
      double totalCalories,
      double netCalories,
      double goal,
      String dayLabel,
      double breakfastCalories,
      double lunchCalories,
      double dinnerCalories,
      double snacksCalories,
      double carbs,
      double fat,
      double protein,
      NutrientsData breakfastNutrients,
      NutrientsData lunchNutrients,
      NutrientsData dinnerNutrients,
      NutrientsData snacksNutrients});

  $NutrientsDataCopyWith<$Res> get breakfastNutrients;
  $NutrientsDataCopyWith<$Res> get lunchNutrients;
  $NutrientsDataCopyWith<$Res> get dinnerNutrients;
  $NutrientsDataCopyWith<$Res> get snacksNutrients;
}

/// @nodoc
class _$DailyCalorieDataCopyWithImpl<$Res, $Val extends DailyCalorieData>
    implements $DailyCalorieDataCopyWith<$Res> {
  _$DailyCalorieDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? totalCalories = null,
    Object? netCalories = null,
    Object? goal = null,
    Object? dayLabel = null,
    Object? breakfastCalories = null,
    Object? lunchCalories = null,
    Object? dinnerCalories = null,
    Object? snacksCalories = null,
    Object? carbs = null,
    Object? fat = null,
    Object? protein = null,
    Object? breakfastNutrients = null,
    Object? lunchNutrients = null,
    Object? dinnerNutrients = null,
    Object? snacksNutrients = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalCalories: null == totalCalories
          ? _value.totalCalories
          : totalCalories // ignore: cast_nullable_to_non_nullable
              as double,
      netCalories: null == netCalories
          ? _value.netCalories
          : netCalories // ignore: cast_nullable_to_non_nullable
              as double,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as double,
      dayLabel: null == dayLabel
          ? _value.dayLabel
          : dayLabel // ignore: cast_nullable_to_non_nullable
              as String,
      breakfastCalories: null == breakfastCalories
          ? _value.breakfastCalories
          : breakfastCalories // ignore: cast_nullable_to_non_nullable
              as double,
      lunchCalories: null == lunchCalories
          ? _value.lunchCalories
          : lunchCalories // ignore: cast_nullable_to_non_nullable
              as double,
      dinnerCalories: null == dinnerCalories
          ? _value.dinnerCalories
          : dinnerCalories // ignore: cast_nullable_to_non_nullable
              as double,
      snacksCalories: null == snacksCalories
          ? _value.snacksCalories
          : snacksCalories // ignore: cast_nullable_to_non_nullable
              as double,
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      breakfastNutrients: null == breakfastNutrients
          ? _value.breakfastNutrients
          : breakfastNutrients // ignore: cast_nullable_to_non_nullable
              as NutrientsData,
      lunchNutrients: null == lunchNutrients
          ? _value.lunchNutrients
          : lunchNutrients // ignore: cast_nullable_to_non_nullable
              as NutrientsData,
      dinnerNutrients: null == dinnerNutrients
          ? _value.dinnerNutrients
          : dinnerNutrients // ignore: cast_nullable_to_non_nullable
              as NutrientsData,
      snacksNutrients: null == snacksNutrients
          ? _value.snacksNutrients
          : snacksNutrients // ignore: cast_nullable_to_non_nullable
              as NutrientsData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NutrientsDataCopyWith<$Res> get breakfastNutrients {
    return $NutrientsDataCopyWith<$Res>(_value.breakfastNutrients, (value) {
      return _then(_value.copyWith(breakfastNutrients: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NutrientsDataCopyWith<$Res> get lunchNutrients {
    return $NutrientsDataCopyWith<$Res>(_value.lunchNutrients, (value) {
      return _then(_value.copyWith(lunchNutrients: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NutrientsDataCopyWith<$Res> get dinnerNutrients {
    return $NutrientsDataCopyWith<$Res>(_value.dinnerNutrients, (value) {
      return _then(_value.copyWith(dinnerNutrients: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NutrientsDataCopyWith<$Res> get snacksNutrients {
    return $NutrientsDataCopyWith<$Res>(_value.snacksNutrients, (value) {
      return _then(_value.copyWith(snacksNutrients: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailyCalorieDataImplCopyWith<$Res>
    implements $DailyCalorieDataCopyWith<$Res> {
  factory _$$DailyCalorieDataImplCopyWith(_$DailyCalorieDataImpl value,
          $Res Function(_$DailyCalorieDataImpl) then) =
      __$$DailyCalorieDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      double totalCalories,
      double netCalories,
      double goal,
      String dayLabel,
      double breakfastCalories,
      double lunchCalories,
      double dinnerCalories,
      double snacksCalories,
      double carbs,
      double fat,
      double protein,
      NutrientsData breakfastNutrients,
      NutrientsData lunchNutrients,
      NutrientsData dinnerNutrients,
      NutrientsData snacksNutrients});

  @override
  $NutrientsDataCopyWith<$Res> get breakfastNutrients;
  @override
  $NutrientsDataCopyWith<$Res> get lunchNutrients;
  @override
  $NutrientsDataCopyWith<$Res> get dinnerNutrients;
  @override
  $NutrientsDataCopyWith<$Res> get snacksNutrients;
}

/// @nodoc
class __$$DailyCalorieDataImplCopyWithImpl<$Res>
    extends _$DailyCalorieDataCopyWithImpl<$Res, _$DailyCalorieDataImpl>
    implements _$$DailyCalorieDataImplCopyWith<$Res> {
  __$$DailyCalorieDataImplCopyWithImpl(_$DailyCalorieDataImpl _value,
      $Res Function(_$DailyCalorieDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? totalCalories = null,
    Object? netCalories = null,
    Object? goal = null,
    Object? dayLabel = null,
    Object? breakfastCalories = null,
    Object? lunchCalories = null,
    Object? dinnerCalories = null,
    Object? snacksCalories = null,
    Object? carbs = null,
    Object? fat = null,
    Object? protein = null,
    Object? breakfastNutrients = null,
    Object? lunchNutrients = null,
    Object? dinnerNutrients = null,
    Object? snacksNutrients = null,
  }) {
    return _then(_$DailyCalorieDataImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalCalories: null == totalCalories
          ? _value.totalCalories
          : totalCalories // ignore: cast_nullable_to_non_nullable
              as double,
      netCalories: null == netCalories
          ? _value.netCalories
          : netCalories // ignore: cast_nullable_to_non_nullable
              as double,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as double,
      dayLabel: null == dayLabel
          ? _value.dayLabel
          : dayLabel // ignore: cast_nullable_to_non_nullable
              as String,
      breakfastCalories: null == breakfastCalories
          ? _value.breakfastCalories
          : breakfastCalories // ignore: cast_nullable_to_non_nullable
              as double,
      lunchCalories: null == lunchCalories
          ? _value.lunchCalories
          : lunchCalories // ignore: cast_nullable_to_non_nullable
              as double,
      dinnerCalories: null == dinnerCalories
          ? _value.dinnerCalories
          : dinnerCalories // ignore: cast_nullable_to_non_nullable
              as double,
      snacksCalories: null == snacksCalories
          ? _value.snacksCalories
          : snacksCalories // ignore: cast_nullable_to_non_nullable
              as double,
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      breakfastNutrients: null == breakfastNutrients
          ? _value.breakfastNutrients
          : breakfastNutrients // ignore: cast_nullable_to_non_nullable
              as NutrientsData,
      lunchNutrients: null == lunchNutrients
          ? _value.lunchNutrients
          : lunchNutrients // ignore: cast_nullable_to_non_nullable
              as NutrientsData,
      dinnerNutrients: null == dinnerNutrients
          ? _value.dinnerNutrients
          : dinnerNutrients // ignore: cast_nullable_to_non_nullable
              as NutrientsData,
      snacksNutrients: null == snacksNutrients
          ? _value.snacksNutrients
          : snacksNutrients // ignore: cast_nullable_to_non_nullable
              as NutrientsData,
    ));
  }
}

/// @nodoc

class _$DailyCalorieDataImpl implements _DailyCalorieData {
  const _$DailyCalorieDataImpl(
      {required this.date,
      required this.totalCalories,
      required this.netCalories,
      required this.goal,
      required this.dayLabel,
      this.breakfastCalories = 0.0,
      this.lunchCalories = 0.0,
      this.dinnerCalories = 0.0,
      this.snacksCalories = 0.0,
      this.carbs = 0.0,
      this.fat = 0.0,
      this.protein = 0.0,
      this.breakfastNutrients = const NutrientsData(),
      this.lunchNutrients = const NutrientsData(),
      this.dinnerNutrients = const NutrientsData(),
      this.snacksNutrients = const NutrientsData()});

  @override
  final DateTime date;
  @override
  final double totalCalories;
  @override
  final double netCalories;
  @override
  final double goal;
  @override
  final String dayLabel;
  @override
  @JsonKey()
  final double breakfastCalories;
  @override
  @JsonKey()
  final double lunchCalories;
  @override
  @JsonKey()
  final double dinnerCalories;
  @override
  @JsonKey()
  final double snacksCalories;
  @override
  @JsonKey()
  final double carbs;
  @override
  @JsonKey()
  final double fat;
  @override
  @JsonKey()
  final double protein;
  @override
  @JsonKey()
  final NutrientsData breakfastNutrients;
  @override
  @JsonKey()
  final NutrientsData lunchNutrients;
  @override
  @JsonKey()
  final NutrientsData dinnerNutrients;
  @override
  @JsonKey()
  final NutrientsData snacksNutrients;

  @override
  String toString() {
    return 'DailyCalorieData(date: $date, totalCalories: $totalCalories, netCalories: $netCalories, goal: $goal, dayLabel: $dayLabel, breakfastCalories: $breakfastCalories, lunchCalories: $lunchCalories, dinnerCalories: $dinnerCalories, snacksCalories: $snacksCalories, carbs: $carbs, fat: $fat, protein: $protein, breakfastNutrients: $breakfastNutrients, lunchNutrients: $lunchNutrients, dinnerNutrients: $dinnerNutrients, snacksNutrients: $snacksNutrients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyCalorieDataImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalCalories, totalCalories) ||
                other.totalCalories == totalCalories) &&
            (identical(other.netCalories, netCalories) ||
                other.netCalories == netCalories) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.dayLabel, dayLabel) ||
                other.dayLabel == dayLabel) &&
            (identical(other.breakfastCalories, breakfastCalories) ||
                other.breakfastCalories == breakfastCalories) &&
            (identical(other.lunchCalories, lunchCalories) ||
                other.lunchCalories == lunchCalories) &&
            (identical(other.dinnerCalories, dinnerCalories) ||
                other.dinnerCalories == dinnerCalories) &&
            (identical(other.snacksCalories, snacksCalories) ||
                other.snacksCalories == snacksCalories) &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.breakfastNutrients, breakfastNutrients) ||
                other.breakfastNutrients == breakfastNutrients) &&
            (identical(other.lunchNutrients, lunchNutrients) ||
                other.lunchNutrients == lunchNutrients) &&
            (identical(other.dinnerNutrients, dinnerNutrients) ||
                other.dinnerNutrients == dinnerNutrients) &&
            (identical(other.snacksNutrients, snacksNutrients) ||
                other.snacksNutrients == snacksNutrients));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      totalCalories,
      netCalories,
      goal,
      dayLabel,
      breakfastCalories,
      lunchCalories,
      dinnerCalories,
      snacksCalories,
      carbs,
      fat,
      protein,
      breakfastNutrients,
      lunchNutrients,
      dinnerNutrients,
      snacksNutrients);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyCalorieDataImplCopyWith<_$DailyCalorieDataImpl> get copyWith =>
      __$$DailyCalorieDataImplCopyWithImpl<_$DailyCalorieDataImpl>(
          this, _$identity);
}

abstract class _DailyCalorieData implements DailyCalorieData {
  const factory _DailyCalorieData(
      {required final DateTime date,
      required final double totalCalories,
      required final double netCalories,
      required final double goal,
      required final String dayLabel,
      final double breakfastCalories,
      final double lunchCalories,
      final double dinnerCalories,
      final double snacksCalories,
      final double carbs,
      final double fat,
      final double protein,
      final NutrientsData breakfastNutrients,
      final NutrientsData lunchNutrients,
      final NutrientsData dinnerNutrients,
      final NutrientsData snacksNutrients}) = _$DailyCalorieDataImpl;

  @override
  DateTime get date;
  @override
  double get totalCalories;
  @override
  double get netCalories;
  @override
  double get goal;
  @override
  String get dayLabel;
  @override
  double get breakfastCalories;
  @override
  double get lunchCalories;
  @override
  double get dinnerCalories;
  @override
  double get snacksCalories;
  @override
  double get carbs;
  @override
  double get fat;
  @override
  double get protein;
  @override
  NutrientsData get breakfastNutrients;
  @override
  NutrientsData get lunchNutrients;
  @override
  NutrientsData get dinnerNutrients;
  @override
  NutrientsData get snacksNutrients;
  @override
  @JsonKey(ignore: true)
  _$$DailyCalorieDataImplCopyWith<_$DailyCalorieDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NutrientsData {
  double get protein => throw _privateConstructorUsedError;
  double get carbohydrates => throw _privateConstructorUsedError;
  double get fiber => throw _privateConstructorUsedError;
  double get sugar => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;
  double get saturatedFat => throw _privateConstructorUsedError;
  double get polyunsaturatedFat => throw _privateConstructorUsedError;
  double get monounsaturatedFat => throw _privateConstructorUsedError;
  double get transFat => throw _privateConstructorUsedError;
  double get cholesterol => throw _privateConstructorUsedError;
  double get sodium => throw _privateConstructorUsedError;
  double get potassium => throw _privateConstructorUsedError;
  double get calcium => throw _privateConstructorUsedError;
  double get iron => throw _privateConstructorUsedError;
  double get magnesium => throw _privateConstructorUsedError;
  double get phosphorus => throw _privateConstructorUsedError;
  double get zinc => throw _privateConstructorUsedError;
  double get vitaminA => throw _privateConstructorUsedError;
  double get vitaminC => throw _privateConstructorUsedError;
  double get vitaminD => throw _privateConstructorUsedError;
  double get vitaminE => throw _privateConstructorUsedError;
  double get vitaminK => throw _privateConstructorUsedError;
  double get vitaminB6 => throw _privateConstructorUsedError;
  double get vitaminB12 => throw _privateConstructorUsedError;
  double get folateDfe => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NutrientsDataCopyWith<NutrientsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutrientsDataCopyWith<$Res> {
  factory $NutrientsDataCopyWith(
          NutrientsData value, $Res Function(NutrientsData) then) =
      _$NutrientsDataCopyWithImpl<$Res, NutrientsData>;
  @useResult
  $Res call(
      {double protein,
      double carbohydrates,
      double fiber,
      double sugar,
      double fat,
      double saturatedFat,
      double polyunsaturatedFat,
      double monounsaturatedFat,
      double transFat,
      double cholesterol,
      double sodium,
      double potassium,
      double calcium,
      double iron,
      double magnesium,
      double phosphorus,
      double zinc,
      double vitaminA,
      double vitaminC,
      double vitaminD,
      double vitaminE,
      double vitaminK,
      double vitaminB6,
      double vitaminB12,
      double folateDfe});
}

/// @nodoc
class _$NutrientsDataCopyWithImpl<$Res, $Val extends NutrientsData>
    implements $NutrientsDataCopyWith<$Res> {
  _$NutrientsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? protein = null,
    Object? carbohydrates = null,
    Object? fiber = null,
    Object? sugar = null,
    Object? fat = null,
    Object? saturatedFat = null,
    Object? polyunsaturatedFat = null,
    Object? monounsaturatedFat = null,
    Object? transFat = null,
    Object? cholesterol = null,
    Object? sodium = null,
    Object? potassium = null,
    Object? calcium = null,
    Object? iron = null,
    Object? magnesium = null,
    Object? phosphorus = null,
    Object? zinc = null,
    Object? vitaminA = null,
    Object? vitaminC = null,
    Object? vitaminD = null,
    Object? vitaminE = null,
    Object? vitaminK = null,
    Object? vitaminB6 = null,
    Object? vitaminB12 = null,
    Object? folateDfe = null,
  }) {
    return _then(_value.copyWith(
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carbohydrates: null == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: null == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double,
      sugar: null == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      saturatedFat: null == saturatedFat
          ? _value.saturatedFat
          : saturatedFat // ignore: cast_nullable_to_non_nullable
              as double,
      polyunsaturatedFat: null == polyunsaturatedFat
          ? _value.polyunsaturatedFat
          : polyunsaturatedFat // ignore: cast_nullable_to_non_nullable
              as double,
      monounsaturatedFat: null == monounsaturatedFat
          ? _value.monounsaturatedFat
          : monounsaturatedFat // ignore: cast_nullable_to_non_nullable
              as double,
      transFat: null == transFat
          ? _value.transFat
          : transFat // ignore: cast_nullable_to_non_nullable
              as double,
      cholesterol: null == cholesterol
          ? _value.cholesterol
          : cholesterol // ignore: cast_nullable_to_non_nullable
              as double,
      sodium: null == sodium
          ? _value.sodium
          : sodium // ignore: cast_nullable_to_non_nullable
              as double,
      potassium: null == potassium
          ? _value.potassium
          : potassium // ignore: cast_nullable_to_non_nullable
              as double,
      calcium: null == calcium
          ? _value.calcium
          : calcium // ignore: cast_nullable_to_non_nullable
              as double,
      iron: null == iron
          ? _value.iron
          : iron // ignore: cast_nullable_to_non_nullable
              as double,
      magnesium: null == magnesium
          ? _value.magnesium
          : magnesium // ignore: cast_nullable_to_non_nullable
              as double,
      phosphorus: null == phosphorus
          ? _value.phosphorus
          : phosphorus // ignore: cast_nullable_to_non_nullable
              as double,
      zinc: null == zinc
          ? _value.zinc
          : zinc // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminA: null == vitaminA
          ? _value.vitaminA
          : vitaminA // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminC: null == vitaminC
          ? _value.vitaminC
          : vitaminC // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminD: null == vitaminD
          ? _value.vitaminD
          : vitaminD // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminE: null == vitaminE
          ? _value.vitaminE
          : vitaminE // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminK: null == vitaminK
          ? _value.vitaminK
          : vitaminK // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminB6: null == vitaminB6
          ? _value.vitaminB6
          : vitaminB6 // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminB12: null == vitaminB12
          ? _value.vitaminB12
          : vitaminB12 // ignore: cast_nullable_to_non_nullable
              as double,
      folateDfe: null == folateDfe
          ? _value.folateDfe
          : folateDfe // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutrientsDataImplCopyWith<$Res>
    implements $NutrientsDataCopyWith<$Res> {
  factory _$$NutrientsDataImplCopyWith(
          _$NutrientsDataImpl value, $Res Function(_$NutrientsDataImpl) then) =
      __$$NutrientsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double protein,
      double carbohydrates,
      double fiber,
      double sugar,
      double fat,
      double saturatedFat,
      double polyunsaturatedFat,
      double monounsaturatedFat,
      double transFat,
      double cholesterol,
      double sodium,
      double potassium,
      double calcium,
      double iron,
      double magnesium,
      double phosphorus,
      double zinc,
      double vitaminA,
      double vitaminC,
      double vitaminD,
      double vitaminE,
      double vitaminK,
      double vitaminB6,
      double vitaminB12,
      double folateDfe});
}

/// @nodoc
class __$$NutrientsDataImplCopyWithImpl<$Res>
    extends _$NutrientsDataCopyWithImpl<$Res, _$NutrientsDataImpl>
    implements _$$NutrientsDataImplCopyWith<$Res> {
  __$$NutrientsDataImplCopyWithImpl(
      _$NutrientsDataImpl _value, $Res Function(_$NutrientsDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? protein = null,
    Object? carbohydrates = null,
    Object? fiber = null,
    Object? sugar = null,
    Object? fat = null,
    Object? saturatedFat = null,
    Object? polyunsaturatedFat = null,
    Object? monounsaturatedFat = null,
    Object? transFat = null,
    Object? cholesterol = null,
    Object? sodium = null,
    Object? potassium = null,
    Object? calcium = null,
    Object? iron = null,
    Object? magnesium = null,
    Object? phosphorus = null,
    Object? zinc = null,
    Object? vitaminA = null,
    Object? vitaminC = null,
    Object? vitaminD = null,
    Object? vitaminE = null,
    Object? vitaminK = null,
    Object? vitaminB6 = null,
    Object? vitaminB12 = null,
    Object? folateDfe = null,
  }) {
    return _then(_$NutrientsDataImpl(
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carbohydrates: null == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: null == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double,
      sugar: null == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      saturatedFat: null == saturatedFat
          ? _value.saturatedFat
          : saturatedFat // ignore: cast_nullable_to_non_nullable
              as double,
      polyunsaturatedFat: null == polyunsaturatedFat
          ? _value.polyunsaturatedFat
          : polyunsaturatedFat // ignore: cast_nullable_to_non_nullable
              as double,
      monounsaturatedFat: null == monounsaturatedFat
          ? _value.monounsaturatedFat
          : monounsaturatedFat // ignore: cast_nullable_to_non_nullable
              as double,
      transFat: null == transFat
          ? _value.transFat
          : transFat // ignore: cast_nullable_to_non_nullable
              as double,
      cholesterol: null == cholesterol
          ? _value.cholesterol
          : cholesterol // ignore: cast_nullable_to_non_nullable
              as double,
      sodium: null == sodium
          ? _value.sodium
          : sodium // ignore: cast_nullable_to_non_nullable
              as double,
      potassium: null == potassium
          ? _value.potassium
          : potassium // ignore: cast_nullable_to_non_nullable
              as double,
      calcium: null == calcium
          ? _value.calcium
          : calcium // ignore: cast_nullable_to_non_nullable
              as double,
      iron: null == iron
          ? _value.iron
          : iron // ignore: cast_nullable_to_non_nullable
              as double,
      magnesium: null == magnesium
          ? _value.magnesium
          : magnesium // ignore: cast_nullable_to_non_nullable
              as double,
      phosphorus: null == phosphorus
          ? _value.phosphorus
          : phosphorus // ignore: cast_nullable_to_non_nullable
              as double,
      zinc: null == zinc
          ? _value.zinc
          : zinc // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminA: null == vitaminA
          ? _value.vitaminA
          : vitaminA // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminC: null == vitaminC
          ? _value.vitaminC
          : vitaminC // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminD: null == vitaminD
          ? _value.vitaminD
          : vitaminD // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminE: null == vitaminE
          ? _value.vitaminE
          : vitaminE // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminK: null == vitaminK
          ? _value.vitaminK
          : vitaminK // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminB6: null == vitaminB6
          ? _value.vitaminB6
          : vitaminB6 // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminB12: null == vitaminB12
          ? _value.vitaminB12
          : vitaminB12 // ignore: cast_nullable_to_non_nullable
              as double,
      folateDfe: null == folateDfe
          ? _value.folateDfe
          : folateDfe // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$NutrientsDataImpl implements _NutrientsData {
  const _$NutrientsDataImpl(
      {this.protein = 0.0,
      this.carbohydrates = 0.0,
      this.fiber = 0.0,
      this.sugar = 0.0,
      this.fat = 0.0,
      this.saturatedFat = 0.0,
      this.polyunsaturatedFat = 0.0,
      this.monounsaturatedFat = 0.0,
      this.transFat = 0.0,
      this.cholesterol = 0.0,
      this.sodium = 0.0,
      this.potassium = 0.0,
      this.calcium = 0.0,
      this.iron = 0.0,
      this.magnesium = 0.0,
      this.phosphorus = 0.0,
      this.zinc = 0.0,
      this.vitaminA = 0.0,
      this.vitaminC = 0.0,
      this.vitaminD = 0.0,
      this.vitaminE = 0.0,
      this.vitaminK = 0.0,
      this.vitaminB6 = 0.0,
      this.vitaminB12 = 0.0,
      this.folateDfe = 0.0});

  @override
  @JsonKey()
  final double protein;
  @override
  @JsonKey()
  final double carbohydrates;
  @override
  @JsonKey()
  final double fiber;
  @override
  @JsonKey()
  final double sugar;
  @override
  @JsonKey()
  final double fat;
  @override
  @JsonKey()
  final double saturatedFat;
  @override
  @JsonKey()
  final double polyunsaturatedFat;
  @override
  @JsonKey()
  final double monounsaturatedFat;
  @override
  @JsonKey()
  final double transFat;
  @override
  @JsonKey()
  final double cholesterol;
  @override
  @JsonKey()
  final double sodium;
  @override
  @JsonKey()
  final double potassium;
  @override
  @JsonKey()
  final double calcium;
  @override
  @JsonKey()
  final double iron;
  @override
  @JsonKey()
  final double magnesium;
  @override
  @JsonKey()
  final double phosphorus;
  @override
  @JsonKey()
  final double zinc;
  @override
  @JsonKey()
  final double vitaminA;
  @override
  @JsonKey()
  final double vitaminC;
  @override
  @JsonKey()
  final double vitaminD;
  @override
  @JsonKey()
  final double vitaminE;
  @override
  @JsonKey()
  final double vitaminK;
  @override
  @JsonKey()
  final double vitaminB6;
  @override
  @JsonKey()
  final double vitaminB12;
  @override
  @JsonKey()
  final double folateDfe;

  @override
  String toString() {
    return 'NutrientsData(protein: $protein, carbohydrates: $carbohydrates, fiber: $fiber, sugar: $sugar, fat: $fat, saturatedFat: $saturatedFat, polyunsaturatedFat: $polyunsaturatedFat, monounsaturatedFat: $monounsaturatedFat, transFat: $transFat, cholesterol: $cholesterol, sodium: $sodium, potassium: $potassium, calcium: $calcium, iron: $iron, magnesium: $magnesium, phosphorus: $phosphorus, zinc: $zinc, vitaminA: $vitaminA, vitaminC: $vitaminC, vitaminD: $vitaminD, vitaminE: $vitaminE, vitaminK: $vitaminK, vitaminB6: $vitaminB6, vitaminB12: $vitaminB12, folateDfe: $folateDfe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutrientsDataImpl &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.carbohydrates, carbohydrates) ||
                other.carbohydrates == carbohydrates) &&
            (identical(other.fiber, fiber) || other.fiber == fiber) &&
            (identical(other.sugar, sugar) || other.sugar == sugar) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.saturatedFat, saturatedFat) ||
                other.saturatedFat == saturatedFat) &&
            (identical(other.polyunsaturatedFat, polyunsaturatedFat) ||
                other.polyunsaturatedFat == polyunsaturatedFat) &&
            (identical(other.monounsaturatedFat, monounsaturatedFat) ||
                other.monounsaturatedFat == monounsaturatedFat) &&
            (identical(other.transFat, transFat) ||
                other.transFat == transFat) &&
            (identical(other.cholesterol, cholesterol) ||
                other.cholesterol == cholesterol) &&
            (identical(other.sodium, sodium) || other.sodium == sodium) &&
            (identical(other.potassium, potassium) ||
                other.potassium == potassium) &&
            (identical(other.calcium, calcium) || other.calcium == calcium) &&
            (identical(other.iron, iron) || other.iron == iron) &&
            (identical(other.magnesium, magnesium) ||
                other.magnesium == magnesium) &&
            (identical(other.phosphorus, phosphorus) ||
                other.phosphorus == phosphorus) &&
            (identical(other.zinc, zinc) || other.zinc == zinc) &&
            (identical(other.vitaminA, vitaminA) ||
                other.vitaminA == vitaminA) &&
            (identical(other.vitaminC, vitaminC) ||
                other.vitaminC == vitaminC) &&
            (identical(other.vitaminD, vitaminD) ||
                other.vitaminD == vitaminD) &&
            (identical(other.vitaminE, vitaminE) ||
                other.vitaminE == vitaminE) &&
            (identical(other.vitaminK, vitaminK) ||
                other.vitaminK == vitaminK) &&
            (identical(other.vitaminB6, vitaminB6) ||
                other.vitaminB6 == vitaminB6) &&
            (identical(other.vitaminB12, vitaminB12) ||
                other.vitaminB12 == vitaminB12) &&
            (identical(other.folateDfe, folateDfe) ||
                other.folateDfe == folateDfe));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        protein,
        carbohydrates,
        fiber,
        sugar,
        fat,
        saturatedFat,
        polyunsaturatedFat,
        monounsaturatedFat,
        transFat,
        cholesterol,
        sodium,
        potassium,
        calcium,
        iron,
        magnesium,
        phosphorus,
        zinc,
        vitaminA,
        vitaminC,
        vitaminD,
        vitaminE,
        vitaminK,
        vitaminB6,
        vitaminB12,
        folateDfe
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutrientsDataImplCopyWith<_$NutrientsDataImpl> get copyWith =>
      __$$NutrientsDataImplCopyWithImpl<_$NutrientsDataImpl>(this, _$identity);
}

abstract class _NutrientsData implements NutrientsData {
  const factory _NutrientsData(
      {final double protein,
      final double carbohydrates,
      final double fiber,
      final double sugar,
      final double fat,
      final double saturatedFat,
      final double polyunsaturatedFat,
      final double monounsaturatedFat,
      final double transFat,
      final double cholesterol,
      final double sodium,
      final double potassium,
      final double calcium,
      final double iron,
      final double magnesium,
      final double phosphorus,
      final double zinc,
      final double vitaminA,
      final double vitaminC,
      final double vitaminD,
      final double vitaminE,
      final double vitaminK,
      final double vitaminB6,
      final double vitaminB12,
      final double folateDfe}) = _$NutrientsDataImpl;

  @override
  double get protein;
  @override
  double get carbohydrates;
  @override
  double get fiber;
  @override
  double get sugar;
  @override
  double get fat;
  @override
  double get saturatedFat;
  @override
  double get polyunsaturatedFat;
  @override
  double get monounsaturatedFat;
  @override
  double get transFat;
  @override
  double get cholesterol;
  @override
  double get sodium;
  @override
  double get potassium;
  @override
  double get calcium;
  @override
  double get iron;
  @override
  double get magnesium;
  @override
  double get phosphorus;
  @override
  double get zinc;
  @override
  double get vitaminA;
  @override
  double get vitaminC;
  @override
  double get vitaminD;
  @override
  double get vitaminE;
  @override
  double get vitaminK;
  @override
  double get vitaminB6;
  @override
  double get vitaminB12;
  @override
  double get folateDfe;
  @override
  @JsonKey(ignore: true)
  _$$NutrientsDataImplCopyWith<_$NutrientsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MacrosData {
  double get carbs => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;
  double get protein => throw _privateConstructorUsedError;
  double get carbsGoal => throw _privateConstructorUsedError;
  double get fatGoal => throw _privateConstructorUsedError;
  double get proteinGoal => throw _privateConstructorUsedError;
  double get carbsGoalPercent => throw _privateConstructorUsedError;
  double get fatGoalPercent => throw _privateConstructorUsedError;
  double get proteinGoalPercent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MacrosDataCopyWith<MacrosData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MacrosDataCopyWith<$Res> {
  factory $MacrosDataCopyWith(
          MacrosData value, $Res Function(MacrosData) then) =
      _$MacrosDataCopyWithImpl<$Res, MacrosData>;
  @useResult
  $Res call(
      {double carbs,
      double fat,
      double protein,
      double carbsGoal,
      double fatGoal,
      double proteinGoal,
      double carbsGoalPercent,
      double fatGoalPercent,
      double proteinGoalPercent});
}

/// @nodoc
class _$MacrosDataCopyWithImpl<$Res, $Val extends MacrosData>
    implements $MacrosDataCopyWith<$Res> {
  _$MacrosDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carbs = null,
    Object? fat = null,
    Object? protein = null,
    Object? carbsGoal = null,
    Object? fatGoal = null,
    Object? proteinGoal = null,
    Object? carbsGoalPercent = null,
    Object? fatGoalPercent = null,
    Object? proteinGoalPercent = null,
  }) {
    return _then(_value.copyWith(
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carbsGoal: null == carbsGoal
          ? _value.carbsGoal
          : carbsGoal // ignore: cast_nullable_to_non_nullable
              as double,
      fatGoal: null == fatGoal
          ? _value.fatGoal
          : fatGoal // ignore: cast_nullable_to_non_nullable
              as double,
      proteinGoal: null == proteinGoal
          ? _value.proteinGoal
          : proteinGoal // ignore: cast_nullable_to_non_nullable
              as double,
      carbsGoalPercent: null == carbsGoalPercent
          ? _value.carbsGoalPercent
          : carbsGoalPercent // ignore: cast_nullable_to_non_nullable
              as double,
      fatGoalPercent: null == fatGoalPercent
          ? _value.fatGoalPercent
          : fatGoalPercent // ignore: cast_nullable_to_non_nullable
              as double,
      proteinGoalPercent: null == proteinGoalPercent
          ? _value.proteinGoalPercent
          : proteinGoalPercent // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MacrosDataImplCopyWith<$Res>
    implements $MacrosDataCopyWith<$Res> {
  factory _$$MacrosDataImplCopyWith(
          _$MacrosDataImpl value, $Res Function(_$MacrosDataImpl) then) =
      __$$MacrosDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double carbs,
      double fat,
      double protein,
      double carbsGoal,
      double fatGoal,
      double proteinGoal,
      double carbsGoalPercent,
      double fatGoalPercent,
      double proteinGoalPercent});
}

/// @nodoc
class __$$MacrosDataImplCopyWithImpl<$Res>
    extends _$MacrosDataCopyWithImpl<$Res, _$MacrosDataImpl>
    implements _$$MacrosDataImplCopyWith<$Res> {
  __$$MacrosDataImplCopyWithImpl(
      _$MacrosDataImpl _value, $Res Function(_$MacrosDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carbs = null,
    Object? fat = null,
    Object? protein = null,
    Object? carbsGoal = null,
    Object? fatGoal = null,
    Object? proteinGoal = null,
    Object? carbsGoalPercent = null,
    Object? fatGoalPercent = null,
    Object? proteinGoalPercent = null,
  }) {
    return _then(_$MacrosDataImpl(
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carbsGoal: null == carbsGoal
          ? _value.carbsGoal
          : carbsGoal // ignore: cast_nullable_to_non_nullable
              as double,
      fatGoal: null == fatGoal
          ? _value.fatGoal
          : fatGoal // ignore: cast_nullable_to_non_nullable
              as double,
      proteinGoal: null == proteinGoal
          ? _value.proteinGoal
          : proteinGoal // ignore: cast_nullable_to_non_nullable
              as double,
      carbsGoalPercent: null == carbsGoalPercent
          ? _value.carbsGoalPercent
          : carbsGoalPercent // ignore: cast_nullable_to_non_nullable
              as double,
      fatGoalPercent: null == fatGoalPercent
          ? _value.fatGoalPercent
          : fatGoalPercent // ignore: cast_nullable_to_non_nullable
              as double,
      proteinGoalPercent: null == proteinGoalPercent
          ? _value.proteinGoalPercent
          : proteinGoalPercent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$MacrosDataImpl implements _MacrosData {
  const _$MacrosDataImpl(
      {this.carbs = 0.0,
      this.fat = 0.0,
      this.protein = 0.0,
      this.carbsGoal = 0.0,
      this.fatGoal = 0.0,
      this.proteinGoal = 0.0,
      this.carbsGoalPercent = 0.0,
      this.fatGoalPercent = 0.0,
      this.proteinGoalPercent = 0.0});

  @override
  @JsonKey()
  final double carbs;
  @override
  @JsonKey()
  final double fat;
  @override
  @JsonKey()
  final double protein;
  @override
  @JsonKey()
  final double carbsGoal;
  @override
  @JsonKey()
  final double fatGoal;
  @override
  @JsonKey()
  final double proteinGoal;
  @override
  @JsonKey()
  final double carbsGoalPercent;
  @override
  @JsonKey()
  final double fatGoalPercent;
  @override
  @JsonKey()
  final double proteinGoalPercent;

  @override
  String toString() {
    return 'MacrosData(carbs: $carbs, fat: $fat, protein: $protein, carbsGoal: $carbsGoal, fatGoal: $fatGoal, proteinGoal: $proteinGoal, carbsGoalPercent: $carbsGoalPercent, fatGoalPercent: $fatGoalPercent, proteinGoalPercent: $proteinGoalPercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MacrosDataImpl &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.carbsGoal, carbsGoal) ||
                other.carbsGoal == carbsGoal) &&
            (identical(other.fatGoal, fatGoal) || other.fatGoal == fatGoal) &&
            (identical(other.proteinGoal, proteinGoal) ||
                other.proteinGoal == proteinGoal) &&
            (identical(other.carbsGoalPercent, carbsGoalPercent) ||
                other.carbsGoalPercent == carbsGoalPercent) &&
            (identical(other.fatGoalPercent, fatGoalPercent) ||
                other.fatGoalPercent == fatGoalPercent) &&
            (identical(other.proteinGoalPercent, proteinGoalPercent) ||
                other.proteinGoalPercent == proteinGoalPercent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      carbs,
      fat,
      protein,
      carbsGoal,
      fatGoal,
      proteinGoal,
      carbsGoalPercent,
      fatGoalPercent,
      proteinGoalPercent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MacrosDataImplCopyWith<_$MacrosDataImpl> get copyWith =>
      __$$MacrosDataImplCopyWithImpl<_$MacrosDataImpl>(this, _$identity);
}

abstract class _MacrosData implements MacrosData {
  const factory _MacrosData(
      {final double carbs,
      final double fat,
      final double protein,
      final double carbsGoal,
      final double fatGoal,
      final double proteinGoal,
      final double carbsGoalPercent,
      final double fatGoalPercent,
      final double proteinGoalPercent}) = _$MacrosDataImpl;

  @override
  double get carbs;
  @override
  double get fat;
  @override
  double get protein;
  @override
  double get carbsGoal;
  @override
  double get fatGoal;
  @override
  double get proteinGoal;
  @override
  double get carbsGoalPercent;
  @override
  double get fatGoalPercent;
  @override
  double get proteinGoalPercent;
  @override
  @JsonKey(ignore: true)
  _$$MacrosDataImplCopyWith<_$MacrosDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WeeklyNutritionData {
  List<DailyCalorieData> get dailyData => throw _privateConstructorUsedError;
  double get weeklyGoal => throw _privateConstructorUsedError;
  double get netAverage => throw _privateConstructorUsedError;
  double get netCaloriesUnderGoal => throw _privateConstructorUsedError;
  NutrientsData get nutrients => throw _privateConstructorUsedError;
  MacrosData get macros => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeeklyNutritionDataCopyWith<WeeklyNutritionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyNutritionDataCopyWith<$Res> {
  factory $WeeklyNutritionDataCopyWith(
          WeeklyNutritionData value, $Res Function(WeeklyNutritionData) then) =
      _$WeeklyNutritionDataCopyWithImpl<$Res, WeeklyNutritionData>;
  @useResult
  $Res call(
      {List<DailyCalorieData> dailyData,
      double weeklyGoal,
      double netAverage,
      double netCaloriesUnderGoal,
      NutrientsData nutrients,
      MacrosData macros});

  $NutrientsDataCopyWith<$Res> get nutrients;
  $MacrosDataCopyWith<$Res> get macros;
}

/// @nodoc
class _$WeeklyNutritionDataCopyWithImpl<$Res, $Val extends WeeklyNutritionData>
    implements $WeeklyNutritionDataCopyWith<$Res> {
  _$WeeklyNutritionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyData = null,
    Object? weeklyGoal = null,
    Object? netAverage = null,
    Object? netCaloriesUnderGoal = null,
    Object? nutrients = null,
    Object? macros = null,
  }) {
    return _then(_value.copyWith(
      dailyData: null == dailyData
          ? _value.dailyData
          : dailyData // ignore: cast_nullable_to_non_nullable
              as List<DailyCalorieData>,
      weeklyGoal: null == weeklyGoal
          ? _value.weeklyGoal
          : weeklyGoal // ignore: cast_nullable_to_non_nullable
              as double,
      netAverage: null == netAverage
          ? _value.netAverage
          : netAverage // ignore: cast_nullable_to_non_nullable
              as double,
      netCaloriesUnderGoal: null == netCaloriesUnderGoal
          ? _value.netCaloriesUnderGoal
          : netCaloriesUnderGoal // ignore: cast_nullable_to_non_nullable
              as double,
      nutrients: null == nutrients
          ? _value.nutrients
          : nutrients // ignore: cast_nullable_to_non_nullable
              as NutrientsData,
      macros: null == macros
          ? _value.macros
          : macros // ignore: cast_nullable_to_non_nullable
              as MacrosData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NutrientsDataCopyWith<$Res> get nutrients {
    return $NutrientsDataCopyWith<$Res>(_value.nutrients, (value) {
      return _then(_value.copyWith(nutrients: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MacrosDataCopyWith<$Res> get macros {
    return $MacrosDataCopyWith<$Res>(_value.macros, (value) {
      return _then(_value.copyWith(macros: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeeklyNutritionDataImplCopyWith<$Res>
    implements $WeeklyNutritionDataCopyWith<$Res> {
  factory _$$WeeklyNutritionDataImplCopyWith(_$WeeklyNutritionDataImpl value,
          $Res Function(_$WeeklyNutritionDataImpl) then) =
      __$$WeeklyNutritionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<DailyCalorieData> dailyData,
      double weeklyGoal,
      double netAverage,
      double netCaloriesUnderGoal,
      NutrientsData nutrients,
      MacrosData macros});

  @override
  $NutrientsDataCopyWith<$Res> get nutrients;
  @override
  $MacrosDataCopyWith<$Res> get macros;
}

/// @nodoc
class __$$WeeklyNutritionDataImplCopyWithImpl<$Res>
    extends _$WeeklyNutritionDataCopyWithImpl<$Res, _$WeeklyNutritionDataImpl>
    implements _$$WeeklyNutritionDataImplCopyWith<$Res> {
  __$$WeeklyNutritionDataImplCopyWithImpl(_$WeeklyNutritionDataImpl _value,
      $Res Function(_$WeeklyNutritionDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyData = null,
    Object? weeklyGoal = null,
    Object? netAverage = null,
    Object? netCaloriesUnderGoal = null,
    Object? nutrients = null,
    Object? macros = null,
  }) {
    return _then(_$WeeklyNutritionDataImpl(
      dailyData: null == dailyData
          ? _value._dailyData
          : dailyData // ignore: cast_nullable_to_non_nullable
              as List<DailyCalorieData>,
      weeklyGoal: null == weeklyGoal
          ? _value.weeklyGoal
          : weeklyGoal // ignore: cast_nullable_to_non_nullable
              as double,
      netAverage: null == netAverage
          ? _value.netAverage
          : netAverage // ignore: cast_nullable_to_non_nullable
              as double,
      netCaloriesUnderGoal: null == netCaloriesUnderGoal
          ? _value.netCaloriesUnderGoal
          : netCaloriesUnderGoal // ignore: cast_nullable_to_non_nullable
              as double,
      nutrients: null == nutrients
          ? _value.nutrients
          : nutrients // ignore: cast_nullable_to_non_nullable
              as NutrientsData,
      macros: null == macros
          ? _value.macros
          : macros // ignore: cast_nullable_to_non_nullable
              as MacrosData,
    ));
  }
}

/// @nodoc

class _$WeeklyNutritionDataImpl implements _WeeklyNutritionData {
  const _$WeeklyNutritionDataImpl(
      {required final List<DailyCalorieData> dailyData,
      required this.weeklyGoal,
      required this.netAverage,
      required this.netCaloriesUnderGoal,
      this.nutrients = const NutrientsData(),
      this.macros = const MacrosData()})
      : _dailyData = dailyData;

  final List<DailyCalorieData> _dailyData;
  @override
  List<DailyCalorieData> get dailyData {
    if (_dailyData is EqualUnmodifiableListView) return _dailyData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyData);
  }

  @override
  final double weeklyGoal;
  @override
  final double netAverage;
  @override
  final double netCaloriesUnderGoal;
  @override
  @JsonKey()
  final NutrientsData nutrients;
  @override
  @JsonKey()
  final MacrosData macros;

  @override
  String toString() {
    return 'WeeklyNutritionData(dailyData: $dailyData, weeklyGoal: $weeklyGoal, netAverage: $netAverage, netCaloriesUnderGoal: $netCaloriesUnderGoal, nutrients: $nutrients, macros: $macros)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyNutritionDataImpl &&
            const DeepCollectionEquality()
                .equals(other._dailyData, _dailyData) &&
            (identical(other.weeklyGoal, weeklyGoal) ||
                other.weeklyGoal == weeklyGoal) &&
            (identical(other.netAverage, netAverage) ||
                other.netAverage == netAverage) &&
            (identical(other.netCaloriesUnderGoal, netCaloriesUnderGoal) ||
                other.netCaloriesUnderGoal == netCaloriesUnderGoal) &&
            (identical(other.nutrients, nutrients) ||
                other.nutrients == nutrients) &&
            (identical(other.macros, macros) || other.macros == macros));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_dailyData),
      weeklyGoal,
      netAverage,
      netCaloriesUnderGoal,
      nutrients,
      macros);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyNutritionDataImplCopyWith<_$WeeklyNutritionDataImpl> get copyWith =>
      __$$WeeklyNutritionDataImplCopyWithImpl<_$WeeklyNutritionDataImpl>(
          this, _$identity);
}

abstract class _WeeklyNutritionData implements WeeklyNutritionData {
  const factory _WeeklyNutritionData(
      {required final List<DailyCalorieData> dailyData,
      required final double weeklyGoal,
      required final double netAverage,
      required final double netCaloriesUnderGoal,
      final NutrientsData nutrients,
      final MacrosData macros}) = _$WeeklyNutritionDataImpl;

  @override
  List<DailyCalorieData> get dailyData;
  @override
  double get weeklyGoal;
  @override
  double get netAverage;
  @override
  double get netCaloriesUnderGoal;
  @override
  NutrientsData get nutrients;
  @override
  MacrosData get macros;
  @override
  @JsonKey(ignore: true)
  _$$WeeklyNutritionDataImplCopyWith<_$WeeklyNutritionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
