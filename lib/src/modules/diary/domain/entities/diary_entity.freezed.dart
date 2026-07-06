// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DiaryEntity _$DiaryEntityFromJson(Map<String, dynamic> json) {
  return _DiaryEntity.fromJson(json);
}

/// @nodoc
mixin _$DiaryEntity {
  DateTime get date => throw _privateConstructorUsedError;
  int get caloriesGoal => throw _privateConstructorUsedError;
  int get caloriesConsumed => throw _privateConstructorUsedError;
  int get caloriesBurned => throw _privateConstructorUsedError;
  double get carbsConsumed => throw _privateConstructorUsedError;
  double get proteinConsumed => throw _privateConstructorUsedError;
  double get fatConsumed => throw _privateConstructorUsedError;

  /// Sum of sodium for the day from diary API (`totalSodiumMg`), mg.
  double get sodiumConsumedMg => throw _privateConstructorUsedError;

  /// Sum of dietary fiber from diary API (`totalDietaryFibersG`), g.
  double get fiberConsumedG => throw _privateConstructorUsedError;
  double get sugarConsumedG => throw _privateConstructorUsedError;
  double get saturatedFatConsumedG => throw _privateConstructorUsedError;
  double get cholesterolConsumedMg => throw _privateConstructorUsedError;
  double get potassiumConsumedMg =>
      throw _privateConstructorUsedError; // ── 13 micronutrient totals ──
  /// Sum of calcium for the day from diary API (`totalCalciumMg`), mg.
  double get totalCalciumMg => throw _privateConstructorUsedError;

  /// Sum of iron for the day from diary API (`totalIronMg`), mg.
  double get totalIronMg => throw _privateConstructorUsedError;

  /// Sum of magnesium for the day from diary API (`totalMagnesiumMg`), mg.
  double get totalMagnesiumMg => throw _privateConstructorUsedError;

  /// Sum of phosphorus for the day from diary API (`totalPhosphorusMg`), mg.
  double get totalPhosphorusMg => throw _privateConstructorUsedError;

  /// Sum of zinc for the day from diary API (`totalZincMg`), mg.
  double get totalZincMg => throw _privateConstructorUsedError;

  /// Sum of vitamin A for the day from diary API (`totalVitaminAUg`), µg.
  double get totalVitaminAUg => throw _privateConstructorUsedError;

  /// Sum of vitamin C for the day from diary API (`totalVitaminCMg`), mg.
  double get totalVitaminCMg => throw _privateConstructorUsedError;

  /// Sum of vitamin D for the day from diary API (`totalVitaminDUg`), µg.
  double get totalVitaminDUg => throw _privateConstructorUsedError;

  /// Sum of vitamin E for the day from diary API (`totalVitaminEMg`), mg.
  double get totalVitaminEMg => throw _privateConstructorUsedError;

  /// Sum of vitamin K for the day from diary API (`totalVitaminKUg`), µg.
  double get totalVitaminKUg => throw _privateConstructorUsedError;

  /// Sum of vitamin B6 for the day from diary API (`totalVitaminB6Mg`), mg.
  double get totalVitaminB6Mg => throw _privateConstructorUsedError;

  /// Sum of vitamin B12 for the day from diary API (`totalVitaminB12Ug`), µg.
  double get totalVitaminB12Ug => throw _privateConstructorUsedError;

  /// Sum of folate DFE for the day from diary API (`totalFolateDfeUg`), µg.
  double get totalFolateDfeUg => throw _privateConstructorUsedError;
  List<FoodEntry> get breakfast => throw _privateConstructorUsedError;
  List<FoodEntry> get lunch => throw _privateConstructorUsedError;
  List<FoodEntry> get dinner => throw _privateConstructorUsedError;
  List<FoodEntry> get snacks => throw _privateConstructorUsedError;
  List<ExerciseEntry> get exercises => throw _privateConstructorUsedError;
  int get waterGlasses => throw _privateConstructorUsedError;
  int get waterAmountMl => throw _privateConstructorUsedError;
  int get waterTargetMl => throw _privateConstructorUsedError;
  bool get isFasting => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  DateTime? get fastingStartTime => throw _privateConstructorUsedError;
  DateTime? get fastingEndTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryEntityCopyWith<DiaryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryEntityCopyWith<$Res> {
  factory $DiaryEntityCopyWith(
          DiaryEntity value, $Res Function(DiaryEntity) then) =
      _$DiaryEntityCopyWithImpl<$Res, DiaryEntity>;
  @useResult
  $Res call(
      {DateTime date,
      int caloriesGoal,
      int caloriesConsumed,
      int caloriesBurned,
      double carbsConsumed,
      double proteinConsumed,
      double fatConsumed,
      double sodiumConsumedMg,
      double fiberConsumedG,
      double sugarConsumedG,
      double saturatedFatConsumedG,
      double cholesterolConsumedMg,
      double potassiumConsumedMg,
      double totalCalciumMg,
      double totalIronMg,
      double totalMagnesiumMg,
      double totalPhosphorusMg,
      double totalZincMg,
      double totalVitaminAUg,
      double totalVitaminCMg,
      double totalVitaminDUg,
      double totalVitaminEMg,
      double totalVitaminKUg,
      double totalVitaminB6Mg,
      double totalVitaminB12Ug,
      double totalFolateDfeUg,
      List<FoodEntry> breakfast,
      List<FoodEntry> lunch,
      List<FoodEntry> dinner,
      List<FoodEntry> snacks,
      List<ExerciseEntry> exercises,
      int waterGlasses,
      int waterAmountMl,
      int waterTargetMl,
      bool isFasting,
      bool isCompleted,
      String? note,
      DateTime? fastingStartTime,
      DateTime? fastingEndTime});
}

/// @nodoc
class _$DiaryEntityCopyWithImpl<$Res, $Val extends DiaryEntity>
    implements $DiaryEntityCopyWith<$Res> {
  _$DiaryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? caloriesGoal = null,
    Object? caloriesConsumed = null,
    Object? caloriesBurned = null,
    Object? carbsConsumed = null,
    Object? proteinConsumed = null,
    Object? fatConsumed = null,
    Object? sodiumConsumedMg = null,
    Object? fiberConsumedG = null,
    Object? sugarConsumedG = null,
    Object? saturatedFatConsumedG = null,
    Object? cholesterolConsumedMg = null,
    Object? potassiumConsumedMg = null,
    Object? totalCalciumMg = null,
    Object? totalIronMg = null,
    Object? totalMagnesiumMg = null,
    Object? totalPhosphorusMg = null,
    Object? totalZincMg = null,
    Object? totalVitaminAUg = null,
    Object? totalVitaminCMg = null,
    Object? totalVitaminDUg = null,
    Object? totalVitaminEMg = null,
    Object? totalVitaminKUg = null,
    Object? totalVitaminB6Mg = null,
    Object? totalVitaminB12Ug = null,
    Object? totalFolateDfeUg = null,
    Object? breakfast = null,
    Object? lunch = null,
    Object? dinner = null,
    Object? snacks = null,
    Object? exercises = null,
    Object? waterGlasses = null,
    Object? waterAmountMl = null,
    Object? waterTargetMl = null,
    Object? isFasting = null,
    Object? isCompleted = null,
    Object? note = freezed,
    Object? fastingStartTime = freezed,
    Object? fastingEndTime = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      caloriesGoal: null == caloriesGoal
          ? _value.caloriesGoal
          : caloriesGoal // ignore: cast_nullable_to_non_nullable
              as int,
      caloriesConsumed: null == caloriesConsumed
          ? _value.caloriesConsumed
          : caloriesConsumed // ignore: cast_nullable_to_non_nullable
              as int,
      caloriesBurned: null == caloriesBurned
          ? _value.caloriesBurned
          : caloriesBurned // ignore: cast_nullable_to_non_nullable
              as int,
      carbsConsumed: null == carbsConsumed
          ? _value.carbsConsumed
          : carbsConsumed // ignore: cast_nullable_to_non_nullable
              as double,
      proteinConsumed: null == proteinConsumed
          ? _value.proteinConsumed
          : proteinConsumed // ignore: cast_nullable_to_non_nullable
              as double,
      fatConsumed: null == fatConsumed
          ? _value.fatConsumed
          : fatConsumed // ignore: cast_nullable_to_non_nullable
              as double,
      sodiumConsumedMg: null == sodiumConsumedMg
          ? _value.sodiumConsumedMg
          : sodiumConsumedMg // ignore: cast_nullable_to_non_nullable
              as double,
      fiberConsumedG: null == fiberConsumedG
          ? _value.fiberConsumedG
          : fiberConsumedG // ignore: cast_nullable_to_non_nullable
              as double,
      sugarConsumedG: null == sugarConsumedG
          ? _value.sugarConsumedG
          : sugarConsumedG // ignore: cast_nullable_to_non_nullable
              as double,
      saturatedFatConsumedG: null == saturatedFatConsumedG
          ? _value.saturatedFatConsumedG
          : saturatedFatConsumedG // ignore: cast_nullable_to_non_nullable
              as double,
      cholesterolConsumedMg: null == cholesterolConsumedMg
          ? _value.cholesterolConsumedMg
          : cholesterolConsumedMg // ignore: cast_nullable_to_non_nullable
              as double,
      potassiumConsumedMg: null == potassiumConsumedMg
          ? _value.potassiumConsumedMg
          : potassiumConsumedMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalCalciumMg: null == totalCalciumMg
          ? _value.totalCalciumMg
          : totalCalciumMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalIronMg: null == totalIronMg
          ? _value.totalIronMg
          : totalIronMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalMagnesiumMg: null == totalMagnesiumMg
          ? _value.totalMagnesiumMg
          : totalMagnesiumMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalPhosphorusMg: null == totalPhosphorusMg
          ? _value.totalPhosphorusMg
          : totalPhosphorusMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalZincMg: null == totalZincMg
          ? _value.totalZincMg
          : totalZincMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminAUg: null == totalVitaminAUg
          ? _value.totalVitaminAUg
          : totalVitaminAUg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminCMg: null == totalVitaminCMg
          ? _value.totalVitaminCMg
          : totalVitaminCMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminDUg: null == totalVitaminDUg
          ? _value.totalVitaminDUg
          : totalVitaminDUg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminEMg: null == totalVitaminEMg
          ? _value.totalVitaminEMg
          : totalVitaminEMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminKUg: null == totalVitaminKUg
          ? _value.totalVitaminKUg
          : totalVitaminKUg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminB6Mg: null == totalVitaminB6Mg
          ? _value.totalVitaminB6Mg
          : totalVitaminB6Mg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminB12Ug: null == totalVitaminB12Ug
          ? _value.totalVitaminB12Ug
          : totalVitaminB12Ug // ignore: cast_nullable_to_non_nullable
              as double,
      totalFolateDfeUg: null == totalFolateDfeUg
          ? _value.totalFolateDfeUg
          : totalFolateDfeUg // ignore: cast_nullable_to_non_nullable
              as double,
      breakfast: null == breakfast
          ? _value.breakfast
          : breakfast // ignore: cast_nullable_to_non_nullable
              as List<FoodEntry>,
      lunch: null == lunch
          ? _value.lunch
          : lunch // ignore: cast_nullable_to_non_nullable
              as List<FoodEntry>,
      dinner: null == dinner
          ? _value.dinner
          : dinner // ignore: cast_nullable_to_non_nullable
              as List<FoodEntry>,
      snacks: null == snacks
          ? _value.snacks
          : snacks // ignore: cast_nullable_to_non_nullable
              as List<FoodEntry>,
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<ExerciseEntry>,
      waterGlasses: null == waterGlasses
          ? _value.waterGlasses
          : waterGlasses // ignore: cast_nullable_to_non_nullable
              as int,
      waterAmountMl: null == waterAmountMl
          ? _value.waterAmountMl
          : waterAmountMl // ignore: cast_nullable_to_non_nullable
              as int,
      waterTargetMl: null == waterTargetMl
          ? _value.waterTargetMl
          : waterTargetMl // ignore: cast_nullable_to_non_nullable
              as int,
      isFasting: null == isFasting
          ? _value.isFasting
          : isFasting // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      fastingStartTime: freezed == fastingStartTime
          ? _value.fastingStartTime
          : fastingStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fastingEndTime: freezed == fastingEndTime
          ? _value.fastingEndTime
          : fastingEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiaryEntityImplCopyWith<$Res>
    implements $DiaryEntityCopyWith<$Res> {
  factory _$$DiaryEntityImplCopyWith(
          _$DiaryEntityImpl value, $Res Function(_$DiaryEntityImpl) then) =
      __$$DiaryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      int caloriesGoal,
      int caloriesConsumed,
      int caloriesBurned,
      double carbsConsumed,
      double proteinConsumed,
      double fatConsumed,
      double sodiumConsumedMg,
      double fiberConsumedG,
      double sugarConsumedG,
      double saturatedFatConsumedG,
      double cholesterolConsumedMg,
      double potassiumConsumedMg,
      double totalCalciumMg,
      double totalIronMg,
      double totalMagnesiumMg,
      double totalPhosphorusMg,
      double totalZincMg,
      double totalVitaminAUg,
      double totalVitaminCMg,
      double totalVitaminDUg,
      double totalVitaminEMg,
      double totalVitaminKUg,
      double totalVitaminB6Mg,
      double totalVitaminB12Ug,
      double totalFolateDfeUg,
      List<FoodEntry> breakfast,
      List<FoodEntry> lunch,
      List<FoodEntry> dinner,
      List<FoodEntry> snacks,
      List<ExerciseEntry> exercises,
      int waterGlasses,
      int waterAmountMl,
      int waterTargetMl,
      bool isFasting,
      bool isCompleted,
      String? note,
      DateTime? fastingStartTime,
      DateTime? fastingEndTime});
}

/// @nodoc
class __$$DiaryEntityImplCopyWithImpl<$Res>
    extends _$DiaryEntityCopyWithImpl<$Res, _$DiaryEntityImpl>
    implements _$$DiaryEntityImplCopyWith<$Res> {
  __$$DiaryEntityImplCopyWithImpl(
      _$DiaryEntityImpl _value, $Res Function(_$DiaryEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? caloriesGoal = null,
    Object? caloriesConsumed = null,
    Object? caloriesBurned = null,
    Object? carbsConsumed = null,
    Object? proteinConsumed = null,
    Object? fatConsumed = null,
    Object? sodiumConsumedMg = null,
    Object? fiberConsumedG = null,
    Object? sugarConsumedG = null,
    Object? saturatedFatConsumedG = null,
    Object? cholesterolConsumedMg = null,
    Object? potassiumConsumedMg = null,
    Object? totalCalciumMg = null,
    Object? totalIronMg = null,
    Object? totalMagnesiumMg = null,
    Object? totalPhosphorusMg = null,
    Object? totalZincMg = null,
    Object? totalVitaminAUg = null,
    Object? totalVitaminCMg = null,
    Object? totalVitaminDUg = null,
    Object? totalVitaminEMg = null,
    Object? totalVitaminKUg = null,
    Object? totalVitaminB6Mg = null,
    Object? totalVitaminB12Ug = null,
    Object? totalFolateDfeUg = null,
    Object? breakfast = null,
    Object? lunch = null,
    Object? dinner = null,
    Object? snacks = null,
    Object? exercises = null,
    Object? waterGlasses = null,
    Object? waterAmountMl = null,
    Object? waterTargetMl = null,
    Object? isFasting = null,
    Object? isCompleted = null,
    Object? note = freezed,
    Object? fastingStartTime = freezed,
    Object? fastingEndTime = freezed,
  }) {
    return _then(_$DiaryEntityImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      caloriesGoal: null == caloriesGoal
          ? _value.caloriesGoal
          : caloriesGoal // ignore: cast_nullable_to_non_nullable
              as int,
      caloriesConsumed: null == caloriesConsumed
          ? _value.caloriesConsumed
          : caloriesConsumed // ignore: cast_nullable_to_non_nullable
              as int,
      caloriesBurned: null == caloriesBurned
          ? _value.caloriesBurned
          : caloriesBurned // ignore: cast_nullable_to_non_nullable
              as int,
      carbsConsumed: null == carbsConsumed
          ? _value.carbsConsumed
          : carbsConsumed // ignore: cast_nullable_to_non_nullable
              as double,
      proteinConsumed: null == proteinConsumed
          ? _value.proteinConsumed
          : proteinConsumed // ignore: cast_nullable_to_non_nullable
              as double,
      fatConsumed: null == fatConsumed
          ? _value.fatConsumed
          : fatConsumed // ignore: cast_nullable_to_non_nullable
              as double,
      sodiumConsumedMg: null == sodiumConsumedMg
          ? _value.sodiumConsumedMg
          : sodiumConsumedMg // ignore: cast_nullable_to_non_nullable
              as double,
      fiberConsumedG: null == fiberConsumedG
          ? _value.fiberConsumedG
          : fiberConsumedG // ignore: cast_nullable_to_non_nullable
              as double,
      sugarConsumedG: null == sugarConsumedG
          ? _value.sugarConsumedG
          : sugarConsumedG // ignore: cast_nullable_to_non_nullable
              as double,
      saturatedFatConsumedG: null == saturatedFatConsumedG
          ? _value.saturatedFatConsumedG
          : saturatedFatConsumedG // ignore: cast_nullable_to_non_nullable
              as double,
      cholesterolConsumedMg: null == cholesterolConsumedMg
          ? _value.cholesterolConsumedMg
          : cholesterolConsumedMg // ignore: cast_nullable_to_non_nullable
              as double,
      potassiumConsumedMg: null == potassiumConsumedMg
          ? _value.potassiumConsumedMg
          : potassiumConsumedMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalCalciumMg: null == totalCalciumMg
          ? _value.totalCalciumMg
          : totalCalciumMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalIronMg: null == totalIronMg
          ? _value.totalIronMg
          : totalIronMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalMagnesiumMg: null == totalMagnesiumMg
          ? _value.totalMagnesiumMg
          : totalMagnesiumMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalPhosphorusMg: null == totalPhosphorusMg
          ? _value.totalPhosphorusMg
          : totalPhosphorusMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalZincMg: null == totalZincMg
          ? _value.totalZincMg
          : totalZincMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminAUg: null == totalVitaminAUg
          ? _value.totalVitaminAUg
          : totalVitaminAUg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminCMg: null == totalVitaminCMg
          ? _value.totalVitaminCMg
          : totalVitaminCMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminDUg: null == totalVitaminDUg
          ? _value.totalVitaminDUg
          : totalVitaminDUg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminEMg: null == totalVitaminEMg
          ? _value.totalVitaminEMg
          : totalVitaminEMg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminKUg: null == totalVitaminKUg
          ? _value.totalVitaminKUg
          : totalVitaminKUg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminB6Mg: null == totalVitaminB6Mg
          ? _value.totalVitaminB6Mg
          : totalVitaminB6Mg // ignore: cast_nullable_to_non_nullable
              as double,
      totalVitaminB12Ug: null == totalVitaminB12Ug
          ? _value.totalVitaminB12Ug
          : totalVitaminB12Ug // ignore: cast_nullable_to_non_nullable
              as double,
      totalFolateDfeUg: null == totalFolateDfeUg
          ? _value.totalFolateDfeUg
          : totalFolateDfeUg // ignore: cast_nullable_to_non_nullable
              as double,
      breakfast: null == breakfast
          ? _value._breakfast
          : breakfast // ignore: cast_nullable_to_non_nullable
              as List<FoodEntry>,
      lunch: null == lunch
          ? _value._lunch
          : lunch // ignore: cast_nullable_to_non_nullable
              as List<FoodEntry>,
      dinner: null == dinner
          ? _value._dinner
          : dinner // ignore: cast_nullable_to_non_nullable
              as List<FoodEntry>,
      snacks: null == snacks
          ? _value._snacks
          : snacks // ignore: cast_nullable_to_non_nullable
              as List<FoodEntry>,
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<ExerciseEntry>,
      waterGlasses: null == waterGlasses
          ? _value.waterGlasses
          : waterGlasses // ignore: cast_nullable_to_non_nullable
              as int,
      waterAmountMl: null == waterAmountMl
          ? _value.waterAmountMl
          : waterAmountMl // ignore: cast_nullable_to_non_nullable
              as int,
      waterTargetMl: null == waterTargetMl
          ? _value.waterTargetMl
          : waterTargetMl // ignore: cast_nullable_to_non_nullable
              as int,
      isFasting: null == isFasting
          ? _value.isFasting
          : isFasting // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      fastingStartTime: freezed == fastingStartTime
          ? _value.fastingStartTime
          : fastingStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fastingEndTime: freezed == fastingEndTime
          ? _value.fastingEndTime
          : fastingEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiaryEntityImpl extends _DiaryEntity {
  const _$DiaryEntityImpl(
      {required this.date,
      required this.caloriesGoal,
      required this.caloriesConsumed,
      required this.caloriesBurned,
      required this.carbsConsumed,
      required this.proteinConsumed,
      required this.fatConsumed,
      this.sodiumConsumedMg = 0.0,
      this.fiberConsumedG = 0.0,
      this.sugarConsumedG = 0.0,
      this.saturatedFatConsumedG = 0.0,
      this.cholesterolConsumedMg = 0.0,
      this.potassiumConsumedMg = 0.0,
      this.totalCalciumMg = 0.0,
      this.totalIronMg = 0.0,
      this.totalMagnesiumMg = 0.0,
      this.totalPhosphorusMg = 0.0,
      this.totalZincMg = 0.0,
      this.totalVitaminAUg = 0.0,
      this.totalVitaminCMg = 0.0,
      this.totalVitaminDUg = 0.0,
      this.totalVitaminEMg = 0.0,
      this.totalVitaminKUg = 0.0,
      this.totalVitaminB6Mg = 0.0,
      this.totalVitaminB12Ug = 0.0,
      this.totalFolateDfeUg = 0.0,
      required final List<FoodEntry> breakfast,
      required final List<FoodEntry> lunch,
      required final List<FoodEntry> dinner,
      required final List<FoodEntry> snacks,
      required final List<ExerciseEntry> exercises,
      required this.waterGlasses,
      this.waterAmountMl = 0,
      this.waterTargetMl = 2500,
      required this.isFasting,
      this.isCompleted = false,
      this.note,
      this.fastingStartTime,
      this.fastingEndTime})
      : _breakfast = breakfast,
        _lunch = lunch,
        _dinner = dinner,
        _snacks = snacks,
        _exercises = exercises,
        super._();

  factory _$DiaryEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryEntityImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int caloriesGoal;
  @override
  final int caloriesConsumed;
  @override
  final int caloriesBurned;
  @override
  final double carbsConsumed;
  @override
  final double proteinConsumed;
  @override
  final double fatConsumed;

  /// Sum of sodium for the day from diary API (`totalSodiumMg`), mg.
  @override
  @JsonKey()
  final double sodiumConsumedMg;

  /// Sum of dietary fiber from diary API (`totalDietaryFibersG`), g.
  @override
  @JsonKey()
  final double fiberConsumedG;
  @override
  @JsonKey()
  final double sugarConsumedG;
  @override
  @JsonKey()
  final double saturatedFatConsumedG;
  @override
  @JsonKey()
  final double cholesterolConsumedMg;
  @override
  @JsonKey()
  final double potassiumConsumedMg;
// ── 13 micronutrient totals ──
  /// Sum of calcium for the day from diary API (`totalCalciumMg`), mg.
  @override
  @JsonKey()
  final double totalCalciumMg;

  /// Sum of iron for the day from diary API (`totalIronMg`), mg.
  @override
  @JsonKey()
  final double totalIronMg;

  /// Sum of magnesium for the day from diary API (`totalMagnesiumMg`), mg.
  @override
  @JsonKey()
  final double totalMagnesiumMg;

  /// Sum of phosphorus for the day from diary API (`totalPhosphorusMg`), mg.
  @override
  @JsonKey()
  final double totalPhosphorusMg;

  /// Sum of zinc for the day from diary API (`totalZincMg`), mg.
  @override
  @JsonKey()
  final double totalZincMg;

  /// Sum of vitamin A for the day from diary API (`totalVitaminAUg`), µg.
  @override
  @JsonKey()
  final double totalVitaminAUg;

  /// Sum of vitamin C for the day from diary API (`totalVitaminCMg`), mg.
  @override
  @JsonKey()
  final double totalVitaminCMg;

  /// Sum of vitamin D for the day from diary API (`totalVitaminDUg`), µg.
  @override
  @JsonKey()
  final double totalVitaminDUg;

  /// Sum of vitamin E for the day from diary API (`totalVitaminEMg`), mg.
  @override
  @JsonKey()
  final double totalVitaminEMg;

  /// Sum of vitamin K for the day from diary API (`totalVitaminKUg`), µg.
  @override
  @JsonKey()
  final double totalVitaminKUg;

  /// Sum of vitamin B6 for the day from diary API (`totalVitaminB6Mg`), mg.
  @override
  @JsonKey()
  final double totalVitaminB6Mg;

  /// Sum of vitamin B12 for the day from diary API (`totalVitaminB12Ug`), µg.
  @override
  @JsonKey()
  final double totalVitaminB12Ug;

  /// Sum of folate DFE for the day from diary API (`totalFolateDfeUg`), µg.
  @override
  @JsonKey()
  final double totalFolateDfeUg;
  final List<FoodEntry> _breakfast;
  @override
  List<FoodEntry> get breakfast {
    if (_breakfast is EqualUnmodifiableListView) return _breakfast;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_breakfast);
  }

  final List<FoodEntry> _lunch;
  @override
  List<FoodEntry> get lunch {
    if (_lunch is EqualUnmodifiableListView) return _lunch;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lunch);
  }

  final List<FoodEntry> _dinner;
  @override
  List<FoodEntry> get dinner {
    if (_dinner is EqualUnmodifiableListView) return _dinner;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dinner);
  }

  final List<FoodEntry> _snacks;
  @override
  List<FoodEntry> get snacks {
    if (_snacks is EqualUnmodifiableListView) return _snacks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_snacks);
  }

  final List<ExerciseEntry> _exercises;
  @override
  List<ExerciseEntry> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  final int waterGlasses;
  @override
  @JsonKey()
  final int waterAmountMl;
  @override
  @JsonKey()
  final int waterTargetMl;
  @override
  final bool isFasting;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final String? note;
  @override
  final DateTime? fastingStartTime;
  @override
  final DateTime? fastingEndTime;

  @override
  String toString() {
    return 'DiaryEntity(date: $date, caloriesGoal: $caloriesGoal, caloriesConsumed: $caloriesConsumed, caloriesBurned: $caloriesBurned, carbsConsumed: $carbsConsumed, proteinConsumed: $proteinConsumed, fatConsumed: $fatConsumed, sodiumConsumedMg: $sodiumConsumedMg, fiberConsumedG: $fiberConsumedG, sugarConsumedG: $sugarConsumedG, saturatedFatConsumedG: $saturatedFatConsumedG, cholesterolConsumedMg: $cholesterolConsumedMg, potassiumConsumedMg: $potassiumConsumedMg, totalCalciumMg: $totalCalciumMg, totalIronMg: $totalIronMg, totalMagnesiumMg: $totalMagnesiumMg, totalPhosphorusMg: $totalPhosphorusMg, totalZincMg: $totalZincMg, totalVitaminAUg: $totalVitaminAUg, totalVitaminCMg: $totalVitaminCMg, totalVitaminDUg: $totalVitaminDUg, totalVitaminEMg: $totalVitaminEMg, totalVitaminKUg: $totalVitaminKUg, totalVitaminB6Mg: $totalVitaminB6Mg, totalVitaminB12Ug: $totalVitaminB12Ug, totalFolateDfeUg: $totalFolateDfeUg, breakfast: $breakfast, lunch: $lunch, dinner: $dinner, snacks: $snacks, exercises: $exercises, waterGlasses: $waterGlasses, waterAmountMl: $waterAmountMl, waterTargetMl: $waterTargetMl, isFasting: $isFasting, isCompleted: $isCompleted, note: $note, fastingStartTime: $fastingStartTime, fastingEndTime: $fastingEndTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryEntityImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.caloriesGoal, caloriesGoal) ||
                other.caloriesGoal == caloriesGoal) &&
            (identical(other.caloriesConsumed, caloriesConsumed) ||
                other.caloriesConsumed == caloriesConsumed) &&
            (identical(other.caloriesBurned, caloriesBurned) ||
                other.caloriesBurned == caloriesBurned) &&
            (identical(other.carbsConsumed, carbsConsumed) ||
                other.carbsConsumed == carbsConsumed) &&
            (identical(other.proteinConsumed, proteinConsumed) ||
                other.proteinConsumed == proteinConsumed) &&
            (identical(other.fatConsumed, fatConsumed) ||
                other.fatConsumed == fatConsumed) &&
            (identical(other.sodiumConsumedMg, sodiumConsumedMg) ||
                other.sodiumConsumedMg == sodiumConsumedMg) &&
            (identical(other.fiberConsumedG, fiberConsumedG) ||
                other.fiberConsumedG == fiberConsumedG) &&
            (identical(other.sugarConsumedG, sugarConsumedG) ||
                other.sugarConsumedG == sugarConsumedG) &&
            (identical(other.saturatedFatConsumedG, saturatedFatConsumedG) ||
                other.saturatedFatConsumedG == saturatedFatConsumedG) &&
            (identical(other.cholesterolConsumedMg, cholesterolConsumedMg) ||
                other.cholesterolConsumedMg == cholesterolConsumedMg) &&
            (identical(other.potassiumConsumedMg, potassiumConsumedMg) ||
                other.potassiumConsumedMg == potassiumConsumedMg) &&
            (identical(other.totalCalciumMg, totalCalciumMg) ||
                other.totalCalciumMg == totalCalciumMg) &&
            (identical(other.totalIronMg, totalIronMg) ||
                other.totalIronMg == totalIronMg) &&
            (identical(other.totalMagnesiumMg, totalMagnesiumMg) ||
                other.totalMagnesiumMg == totalMagnesiumMg) &&
            (identical(other.totalPhosphorusMg, totalPhosphorusMg) ||
                other.totalPhosphorusMg == totalPhosphorusMg) &&
            (identical(other.totalZincMg, totalZincMg) ||
                other.totalZincMg == totalZincMg) &&
            (identical(other.totalVitaminAUg, totalVitaminAUg) ||
                other.totalVitaminAUg == totalVitaminAUg) &&
            (identical(other.totalVitaminCMg, totalVitaminCMg) ||
                other.totalVitaminCMg == totalVitaminCMg) &&
            (identical(other.totalVitaminDUg, totalVitaminDUg) ||
                other.totalVitaminDUg == totalVitaminDUg) &&
            (identical(other.totalVitaminEMg, totalVitaminEMg) ||
                other.totalVitaminEMg == totalVitaminEMg) &&
            (identical(other.totalVitaminKUg, totalVitaminKUg) ||
                other.totalVitaminKUg == totalVitaminKUg) &&
            (identical(other.totalVitaminB6Mg, totalVitaminB6Mg) ||
                other.totalVitaminB6Mg == totalVitaminB6Mg) &&
            (identical(other.totalVitaminB12Ug, totalVitaminB12Ug) ||
                other.totalVitaminB12Ug == totalVitaminB12Ug) &&
            (identical(other.totalFolateDfeUg, totalFolateDfeUg) ||
                other.totalFolateDfeUg == totalFolateDfeUg) &&
            const DeepCollectionEquality()
                .equals(other._breakfast, _breakfast) &&
            const DeepCollectionEquality().equals(other._lunch, _lunch) &&
            const DeepCollectionEquality().equals(other._dinner, _dinner) &&
            const DeepCollectionEquality().equals(other._snacks, _snacks) &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises) &&
            (identical(other.waterGlasses, waterGlasses) ||
                other.waterGlasses == waterGlasses) &&
            (identical(other.waterAmountMl, waterAmountMl) ||
                other.waterAmountMl == waterAmountMl) &&
            (identical(other.waterTargetMl, waterTargetMl) ||
                other.waterTargetMl == waterTargetMl) &&
            (identical(other.isFasting, isFasting) ||
                other.isFasting == isFasting) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.fastingStartTime, fastingStartTime) ||
                other.fastingStartTime == fastingStartTime) &&
            (identical(other.fastingEndTime, fastingEndTime) ||
                other.fastingEndTime == fastingEndTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        date,
        caloriesGoal,
        caloriesConsumed,
        caloriesBurned,
        carbsConsumed,
        proteinConsumed,
        fatConsumed,
        sodiumConsumedMg,
        fiberConsumedG,
        sugarConsumedG,
        saturatedFatConsumedG,
        cholesterolConsumedMg,
        potassiumConsumedMg,
        totalCalciumMg,
        totalIronMg,
        totalMagnesiumMg,
        totalPhosphorusMg,
        totalZincMg,
        totalVitaminAUg,
        totalVitaminCMg,
        totalVitaminDUg,
        totalVitaminEMg,
        totalVitaminKUg,
        totalVitaminB6Mg,
        totalVitaminB12Ug,
        totalFolateDfeUg,
        const DeepCollectionEquality().hash(_breakfast),
        const DeepCollectionEquality().hash(_lunch),
        const DeepCollectionEquality().hash(_dinner),
        const DeepCollectionEquality().hash(_snacks),
        const DeepCollectionEquality().hash(_exercises),
        waterGlasses,
        waterAmountMl,
        waterTargetMl,
        isFasting,
        isCompleted,
        note,
        fastingStartTime,
        fastingEndTime
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryEntityImplCopyWith<_$DiaryEntityImpl> get copyWith =>
      __$$DiaryEntityImplCopyWithImpl<_$DiaryEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiaryEntityImplToJson(
      this,
    );
  }
}

abstract class _DiaryEntity extends DiaryEntity {
  const factory _DiaryEntity(
      {required final DateTime date,
      required final int caloriesGoal,
      required final int caloriesConsumed,
      required final int caloriesBurned,
      required final double carbsConsumed,
      required final double proteinConsumed,
      required final double fatConsumed,
      final double sodiumConsumedMg,
      final double fiberConsumedG,
      final double sugarConsumedG,
      final double saturatedFatConsumedG,
      final double cholesterolConsumedMg,
      final double potassiumConsumedMg,
      final double totalCalciumMg,
      final double totalIronMg,
      final double totalMagnesiumMg,
      final double totalPhosphorusMg,
      final double totalZincMg,
      final double totalVitaminAUg,
      final double totalVitaminCMg,
      final double totalVitaminDUg,
      final double totalVitaminEMg,
      final double totalVitaminKUg,
      final double totalVitaminB6Mg,
      final double totalVitaminB12Ug,
      final double totalFolateDfeUg,
      required final List<FoodEntry> breakfast,
      required final List<FoodEntry> lunch,
      required final List<FoodEntry> dinner,
      required final List<FoodEntry> snacks,
      required final List<ExerciseEntry> exercises,
      required final int waterGlasses,
      final int waterAmountMl,
      final int waterTargetMl,
      required final bool isFasting,
      final bool isCompleted,
      final String? note,
      final DateTime? fastingStartTime,
      final DateTime? fastingEndTime}) = _$DiaryEntityImpl;
  const _DiaryEntity._() : super._();

  factory _DiaryEntity.fromJson(Map<String, dynamic> json) =
      _$DiaryEntityImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get caloriesGoal;
  @override
  int get caloriesConsumed;
  @override
  int get caloriesBurned;
  @override
  double get carbsConsumed;
  @override
  double get proteinConsumed;
  @override
  double get fatConsumed;
  @override

  /// Sum of sodium for the day from diary API (`totalSodiumMg`), mg.
  double get sodiumConsumedMg;
  @override

  /// Sum of dietary fiber from diary API (`totalDietaryFibersG`), g.
  double get fiberConsumedG;
  @override
  double get sugarConsumedG;
  @override
  double get saturatedFatConsumedG;
  @override
  double get cholesterolConsumedMg;
  @override
  double get potassiumConsumedMg;
  @override // ── 13 micronutrient totals ──
  /// Sum of calcium for the day from diary API (`totalCalciumMg`), mg.
  double get totalCalciumMg;
  @override

  /// Sum of iron for the day from diary API (`totalIronMg`), mg.
  double get totalIronMg;
  @override

  /// Sum of magnesium for the day from diary API (`totalMagnesiumMg`), mg.
  double get totalMagnesiumMg;
  @override

  /// Sum of phosphorus for the day from diary API (`totalPhosphorusMg`), mg.
  double get totalPhosphorusMg;
  @override

  /// Sum of zinc for the day from diary API (`totalZincMg`), mg.
  double get totalZincMg;
  @override

  /// Sum of vitamin A for the day from diary API (`totalVitaminAUg`), µg.
  double get totalVitaminAUg;
  @override

  /// Sum of vitamin C for the day from diary API (`totalVitaminCMg`), mg.
  double get totalVitaminCMg;
  @override

  /// Sum of vitamin D for the day from diary API (`totalVitaminDUg`), µg.
  double get totalVitaminDUg;
  @override

  /// Sum of vitamin E for the day from diary API (`totalVitaminEMg`), mg.
  double get totalVitaminEMg;
  @override

  /// Sum of vitamin K for the day from diary API (`totalVitaminKUg`), µg.
  double get totalVitaminKUg;
  @override

  /// Sum of vitamin B6 for the day from diary API (`totalVitaminB6Mg`), mg.
  double get totalVitaminB6Mg;
  @override

  /// Sum of vitamin B12 for the day from diary API (`totalVitaminB12Ug`), µg.
  double get totalVitaminB12Ug;
  @override

  /// Sum of folate DFE for the day from diary API (`totalFolateDfeUg`), µg.
  double get totalFolateDfeUg;
  @override
  List<FoodEntry> get breakfast;
  @override
  List<FoodEntry> get lunch;
  @override
  List<FoodEntry> get dinner;
  @override
  List<FoodEntry> get snacks;
  @override
  List<ExerciseEntry> get exercises;
  @override
  int get waterGlasses;
  @override
  int get waterAmountMl;
  @override
  int get waterTargetMl;
  @override
  bool get isFasting;
  @override
  bool get isCompleted;
  @override
  String? get note;
  @override
  DateTime? get fastingStartTime;
  @override
  DateTime? get fastingEndTime;
  @override
  @JsonKey(ignore: true)
  _$$DiaryEntityImplCopyWith<_$DiaryEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FoodEntry _$FoodEntryFromJson(Map<String, dynamic> json) {
  return _FoodEntry.fromJson(json);
}

/// @nodoc
mixin _$FoodEntry {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get calories => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  double get carbs => throw _privateConstructorUsedError;
  double get protein => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;
  double get sodiumMg => throw _privateConstructorUsedError;
  double get fiberG => throw _privateConstructorUsedError;
  double get sugarG => throw _privateConstructorUsedError;
  double get saturatedFatG => throw _privateConstructorUsedError;
  double get cholesterolMg => throw _privateConstructorUsedError;
  double get potassiumMg =>
      throw _privateConstructorUsedError; // ── 13 micronutrients ──
  double get calciumMg => throw _privateConstructorUsedError;
  double get ironMg => throw _privateConstructorUsedError;
  double get magnesiumMg => throw _privateConstructorUsedError;
  double get phosphorusMg => throw _privateConstructorUsedError;
  double get zincMg => throw _privateConstructorUsedError;
  double get vitaminAUg => throw _privateConstructorUsedError;
  double get vitaminCMg => throw _privateConstructorUsedError;
  double get vitaminDUg => throw _privateConstructorUsedError;
  double get vitaminEMg => throw _privateConstructorUsedError;
  double get vitaminKUg => throw _privateConstructorUsedError;
  double get vitaminB6Mg => throw _privateConstructorUsedError;
  double get vitaminB12Ug => throw _privateConstructorUsedError;
  double get folateDfeUg => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodEntryCopyWith<FoodEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodEntryCopyWith<$Res> {
  factory $FoodEntryCopyWith(FoodEntry value, $Res Function(FoodEntry) then) =
      _$FoodEntryCopyWithImpl<$Res, FoodEntry>;
  @useResult
  $Res call(
      {String id,
      String name,
      int calories,
      double quantity,
      String unit,
      double carbs,
      double protein,
      double fat,
      double sodiumMg,
      double fiberG,
      double sugarG,
      double saturatedFatG,
      double cholesterolMg,
      double potassiumMg,
      double calciumMg,
      double ironMg,
      double magnesiumMg,
      double phosphorusMg,
      double zincMg,
      double vitaminAUg,
      double vitaminCMg,
      double vitaminDUg,
      double vitaminEMg,
      double vitaminKUg,
      double vitaminB6Mg,
      double vitaminB12Ug,
      double folateDfeUg});
}

/// @nodoc
class _$FoodEntryCopyWithImpl<$Res, $Val extends FoodEntry>
    implements $FoodEntryCopyWith<$Res> {
  _$FoodEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? calories = null,
    Object? quantity = null,
    Object? unit = null,
    Object? carbs = null,
    Object? protein = null,
    Object? fat = null,
    Object? sodiumMg = null,
    Object? fiberG = null,
    Object? sugarG = null,
    Object? saturatedFatG = null,
    Object? cholesterolMg = null,
    Object? potassiumMg = null,
    Object? calciumMg = null,
    Object? ironMg = null,
    Object? magnesiumMg = null,
    Object? phosphorusMg = null,
    Object? zincMg = null,
    Object? vitaminAUg = null,
    Object? vitaminCMg = null,
    Object? vitaminDUg = null,
    Object? vitaminEMg = null,
    Object? vitaminKUg = null,
    Object? vitaminB6Mg = null,
    Object? vitaminB12Ug = null,
    Object? folateDfeUg = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      sodiumMg: null == sodiumMg
          ? _value.sodiumMg
          : sodiumMg // ignore: cast_nullable_to_non_nullable
              as double,
      fiberG: null == fiberG
          ? _value.fiberG
          : fiberG // ignore: cast_nullable_to_non_nullable
              as double,
      sugarG: null == sugarG
          ? _value.sugarG
          : sugarG // ignore: cast_nullable_to_non_nullable
              as double,
      saturatedFatG: null == saturatedFatG
          ? _value.saturatedFatG
          : saturatedFatG // ignore: cast_nullable_to_non_nullable
              as double,
      cholesterolMg: null == cholesterolMg
          ? _value.cholesterolMg
          : cholesterolMg // ignore: cast_nullable_to_non_nullable
              as double,
      potassiumMg: null == potassiumMg
          ? _value.potassiumMg
          : potassiumMg // ignore: cast_nullable_to_non_nullable
              as double,
      calciumMg: null == calciumMg
          ? _value.calciumMg
          : calciumMg // ignore: cast_nullable_to_non_nullable
              as double,
      ironMg: null == ironMg
          ? _value.ironMg
          : ironMg // ignore: cast_nullable_to_non_nullable
              as double,
      magnesiumMg: null == magnesiumMg
          ? _value.magnesiumMg
          : magnesiumMg // ignore: cast_nullable_to_non_nullable
              as double,
      phosphorusMg: null == phosphorusMg
          ? _value.phosphorusMg
          : phosphorusMg // ignore: cast_nullable_to_non_nullable
              as double,
      zincMg: null == zincMg
          ? _value.zincMg
          : zincMg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminAUg: null == vitaminAUg
          ? _value.vitaminAUg
          : vitaminAUg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminCMg: null == vitaminCMg
          ? _value.vitaminCMg
          : vitaminCMg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminDUg: null == vitaminDUg
          ? _value.vitaminDUg
          : vitaminDUg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminEMg: null == vitaminEMg
          ? _value.vitaminEMg
          : vitaminEMg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminKUg: null == vitaminKUg
          ? _value.vitaminKUg
          : vitaminKUg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminB6Mg: null == vitaminB6Mg
          ? _value.vitaminB6Mg
          : vitaminB6Mg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminB12Ug: null == vitaminB12Ug
          ? _value.vitaminB12Ug
          : vitaminB12Ug // ignore: cast_nullable_to_non_nullable
              as double,
      folateDfeUg: null == folateDfeUg
          ? _value.folateDfeUg
          : folateDfeUg // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodEntryImplCopyWith<$Res>
    implements $FoodEntryCopyWith<$Res> {
  factory _$$FoodEntryImplCopyWith(
          _$FoodEntryImpl value, $Res Function(_$FoodEntryImpl) then) =
      __$$FoodEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int calories,
      double quantity,
      String unit,
      double carbs,
      double protein,
      double fat,
      double sodiumMg,
      double fiberG,
      double sugarG,
      double saturatedFatG,
      double cholesterolMg,
      double potassiumMg,
      double calciumMg,
      double ironMg,
      double magnesiumMg,
      double phosphorusMg,
      double zincMg,
      double vitaminAUg,
      double vitaminCMg,
      double vitaminDUg,
      double vitaminEMg,
      double vitaminKUg,
      double vitaminB6Mg,
      double vitaminB12Ug,
      double folateDfeUg});
}

/// @nodoc
class __$$FoodEntryImplCopyWithImpl<$Res>
    extends _$FoodEntryCopyWithImpl<$Res, _$FoodEntryImpl>
    implements _$$FoodEntryImplCopyWith<$Res> {
  __$$FoodEntryImplCopyWithImpl(
      _$FoodEntryImpl _value, $Res Function(_$FoodEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? calories = null,
    Object? quantity = null,
    Object? unit = null,
    Object? carbs = null,
    Object? protein = null,
    Object? fat = null,
    Object? sodiumMg = null,
    Object? fiberG = null,
    Object? sugarG = null,
    Object? saturatedFatG = null,
    Object? cholesterolMg = null,
    Object? potassiumMg = null,
    Object? calciumMg = null,
    Object? ironMg = null,
    Object? magnesiumMg = null,
    Object? phosphorusMg = null,
    Object? zincMg = null,
    Object? vitaminAUg = null,
    Object? vitaminCMg = null,
    Object? vitaminDUg = null,
    Object? vitaminEMg = null,
    Object? vitaminKUg = null,
    Object? vitaminB6Mg = null,
    Object? vitaminB12Ug = null,
    Object? folateDfeUg = null,
  }) {
    return _then(_$FoodEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      sodiumMg: null == sodiumMg
          ? _value.sodiumMg
          : sodiumMg // ignore: cast_nullable_to_non_nullable
              as double,
      fiberG: null == fiberG
          ? _value.fiberG
          : fiberG // ignore: cast_nullable_to_non_nullable
              as double,
      sugarG: null == sugarG
          ? _value.sugarG
          : sugarG // ignore: cast_nullable_to_non_nullable
              as double,
      saturatedFatG: null == saturatedFatG
          ? _value.saturatedFatG
          : saturatedFatG // ignore: cast_nullable_to_non_nullable
              as double,
      cholesterolMg: null == cholesterolMg
          ? _value.cholesterolMg
          : cholesterolMg // ignore: cast_nullable_to_non_nullable
              as double,
      potassiumMg: null == potassiumMg
          ? _value.potassiumMg
          : potassiumMg // ignore: cast_nullable_to_non_nullable
              as double,
      calciumMg: null == calciumMg
          ? _value.calciumMg
          : calciumMg // ignore: cast_nullable_to_non_nullable
              as double,
      ironMg: null == ironMg
          ? _value.ironMg
          : ironMg // ignore: cast_nullable_to_non_nullable
              as double,
      magnesiumMg: null == magnesiumMg
          ? _value.magnesiumMg
          : magnesiumMg // ignore: cast_nullable_to_non_nullable
              as double,
      phosphorusMg: null == phosphorusMg
          ? _value.phosphorusMg
          : phosphorusMg // ignore: cast_nullable_to_non_nullable
              as double,
      zincMg: null == zincMg
          ? _value.zincMg
          : zincMg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminAUg: null == vitaminAUg
          ? _value.vitaminAUg
          : vitaminAUg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminCMg: null == vitaminCMg
          ? _value.vitaminCMg
          : vitaminCMg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminDUg: null == vitaminDUg
          ? _value.vitaminDUg
          : vitaminDUg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminEMg: null == vitaminEMg
          ? _value.vitaminEMg
          : vitaminEMg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminKUg: null == vitaminKUg
          ? _value.vitaminKUg
          : vitaminKUg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminB6Mg: null == vitaminB6Mg
          ? _value.vitaminB6Mg
          : vitaminB6Mg // ignore: cast_nullable_to_non_nullable
              as double,
      vitaminB12Ug: null == vitaminB12Ug
          ? _value.vitaminB12Ug
          : vitaminB12Ug // ignore: cast_nullable_to_non_nullable
              as double,
      folateDfeUg: null == folateDfeUg
          ? _value.folateDfeUg
          : folateDfeUg // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodEntryImpl implements _FoodEntry {
  const _$FoodEntryImpl(
      {required this.id,
      required this.name,
      required this.calories,
      required this.quantity,
      required this.unit,
      this.carbs = 0.0,
      this.protein = 0.0,
      this.fat = 0.0,
      this.sodiumMg = 0.0,
      this.fiberG = 0.0,
      this.sugarG = 0.0,
      this.saturatedFatG = 0.0,
      this.cholesterolMg = 0.0,
      this.potassiumMg = 0.0,
      this.calciumMg = 0.0,
      this.ironMg = 0.0,
      this.magnesiumMg = 0.0,
      this.phosphorusMg = 0.0,
      this.zincMg = 0.0,
      this.vitaminAUg = 0.0,
      this.vitaminCMg = 0.0,
      this.vitaminDUg = 0.0,
      this.vitaminEMg = 0.0,
      this.vitaminKUg = 0.0,
      this.vitaminB6Mg = 0.0,
      this.vitaminB12Ug = 0.0,
      this.folateDfeUg = 0.0});

  factory _$FoodEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int calories;
  @override
  final double quantity;
  @override
  final String unit;
  @override
  @JsonKey()
  final double carbs;
  @override
  @JsonKey()
  final double protein;
  @override
  @JsonKey()
  final double fat;
  @override
  @JsonKey()
  final double sodiumMg;
  @override
  @JsonKey()
  final double fiberG;
  @override
  @JsonKey()
  final double sugarG;
  @override
  @JsonKey()
  final double saturatedFatG;
  @override
  @JsonKey()
  final double cholesterolMg;
  @override
  @JsonKey()
  final double potassiumMg;
// ── 13 micronutrients ──
  @override
  @JsonKey()
  final double calciumMg;
  @override
  @JsonKey()
  final double ironMg;
  @override
  @JsonKey()
  final double magnesiumMg;
  @override
  @JsonKey()
  final double phosphorusMg;
  @override
  @JsonKey()
  final double zincMg;
  @override
  @JsonKey()
  final double vitaminAUg;
  @override
  @JsonKey()
  final double vitaminCMg;
  @override
  @JsonKey()
  final double vitaminDUg;
  @override
  @JsonKey()
  final double vitaminEMg;
  @override
  @JsonKey()
  final double vitaminKUg;
  @override
  @JsonKey()
  final double vitaminB6Mg;
  @override
  @JsonKey()
  final double vitaminB12Ug;
  @override
  @JsonKey()
  final double folateDfeUg;

  @override
  String toString() {
    return 'FoodEntry(id: $id, name: $name, calories: $calories, quantity: $quantity, unit: $unit, carbs: $carbs, protein: $protein, fat: $fat, sodiumMg: $sodiumMg, fiberG: $fiberG, sugarG: $sugarG, saturatedFatG: $saturatedFatG, cholesterolMg: $cholesterolMg, potassiumMg: $potassiumMg, calciumMg: $calciumMg, ironMg: $ironMg, magnesiumMg: $magnesiumMg, phosphorusMg: $phosphorusMg, zincMg: $zincMg, vitaminAUg: $vitaminAUg, vitaminCMg: $vitaminCMg, vitaminDUg: $vitaminDUg, vitaminEMg: $vitaminEMg, vitaminKUg: $vitaminKUg, vitaminB6Mg: $vitaminB6Mg, vitaminB12Ug: $vitaminB12Ug, folateDfeUg: $folateDfeUg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.sodiumMg, sodiumMg) ||
                other.sodiumMg == sodiumMg) &&
            (identical(other.fiberG, fiberG) || other.fiberG == fiberG) &&
            (identical(other.sugarG, sugarG) || other.sugarG == sugarG) &&
            (identical(other.saturatedFatG, saturatedFatG) ||
                other.saturatedFatG == saturatedFatG) &&
            (identical(other.cholesterolMg, cholesterolMg) ||
                other.cholesterolMg == cholesterolMg) &&
            (identical(other.potassiumMg, potassiumMg) ||
                other.potassiumMg == potassiumMg) &&
            (identical(other.calciumMg, calciumMg) ||
                other.calciumMg == calciumMg) &&
            (identical(other.ironMg, ironMg) || other.ironMg == ironMg) &&
            (identical(other.magnesiumMg, magnesiumMg) ||
                other.magnesiumMg == magnesiumMg) &&
            (identical(other.phosphorusMg, phosphorusMg) ||
                other.phosphorusMg == phosphorusMg) &&
            (identical(other.zincMg, zincMg) || other.zincMg == zincMg) &&
            (identical(other.vitaminAUg, vitaminAUg) ||
                other.vitaminAUg == vitaminAUg) &&
            (identical(other.vitaminCMg, vitaminCMg) ||
                other.vitaminCMg == vitaminCMg) &&
            (identical(other.vitaminDUg, vitaminDUg) ||
                other.vitaminDUg == vitaminDUg) &&
            (identical(other.vitaminEMg, vitaminEMg) ||
                other.vitaminEMg == vitaminEMg) &&
            (identical(other.vitaminKUg, vitaminKUg) ||
                other.vitaminKUg == vitaminKUg) &&
            (identical(other.vitaminB6Mg, vitaminB6Mg) ||
                other.vitaminB6Mg == vitaminB6Mg) &&
            (identical(other.vitaminB12Ug, vitaminB12Ug) ||
                other.vitaminB12Ug == vitaminB12Ug) &&
            (identical(other.folateDfeUg, folateDfeUg) ||
                other.folateDfeUg == folateDfeUg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        calories,
        quantity,
        unit,
        carbs,
        protein,
        fat,
        sodiumMg,
        fiberG,
        sugarG,
        saturatedFatG,
        cholesterolMg,
        potassiumMg,
        calciumMg,
        ironMg,
        magnesiumMg,
        phosphorusMg,
        zincMg,
        vitaminAUg,
        vitaminCMg,
        vitaminDUg,
        vitaminEMg,
        vitaminKUg,
        vitaminB6Mg,
        vitaminB12Ug,
        folateDfeUg
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodEntryImplCopyWith<_$FoodEntryImpl> get copyWith =>
      __$$FoodEntryImplCopyWithImpl<_$FoodEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodEntryImplToJson(
      this,
    );
  }
}

abstract class _FoodEntry implements FoodEntry {
  const factory _FoodEntry(
      {required final String id,
      required final String name,
      required final int calories,
      required final double quantity,
      required final String unit,
      final double carbs,
      final double protein,
      final double fat,
      final double sodiumMg,
      final double fiberG,
      final double sugarG,
      final double saturatedFatG,
      final double cholesterolMg,
      final double potassiumMg,
      final double calciumMg,
      final double ironMg,
      final double magnesiumMg,
      final double phosphorusMg,
      final double zincMg,
      final double vitaminAUg,
      final double vitaminCMg,
      final double vitaminDUg,
      final double vitaminEMg,
      final double vitaminKUg,
      final double vitaminB6Mg,
      final double vitaminB12Ug,
      final double folateDfeUg}) = _$FoodEntryImpl;

  factory _FoodEntry.fromJson(Map<String, dynamic> json) =
      _$FoodEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get calories;
  @override
  double get quantity;
  @override
  String get unit;
  @override
  double get carbs;
  @override
  double get protein;
  @override
  double get fat;
  @override
  double get sodiumMg;
  @override
  double get fiberG;
  @override
  double get sugarG;
  @override
  double get saturatedFatG;
  @override
  double get cholesterolMg;
  @override
  double get potassiumMg;
  @override // ── 13 micronutrients ──
  double get calciumMg;
  @override
  double get ironMg;
  @override
  double get magnesiumMg;
  @override
  double get phosphorusMg;
  @override
  double get zincMg;
  @override
  double get vitaminAUg;
  @override
  double get vitaminCMg;
  @override
  double get vitaminDUg;
  @override
  double get vitaminEMg;
  @override
  double get vitaminKUg;
  @override
  double get vitaminB6Mg;
  @override
  double get vitaminB12Ug;
  @override
  double get folateDfeUg;
  @override
  @JsonKey(ignore: true)
  _$$FoodEntryImplCopyWith<_$FoodEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExerciseEntry _$ExerciseEntryFromJson(Map<String, dynamic> json) {
  return _ExerciseEntry.fromJson(json);
}

/// @nodoc
mixin _$ExerciseEntry {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get caloriesBurned => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseEntryCopyWith<ExerciseEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseEntryCopyWith<$Res> {
  factory $ExerciseEntryCopyWith(
          ExerciseEntry value, $Res Function(ExerciseEntry) then) =
      _$ExerciseEntryCopyWithImpl<$Res, ExerciseEntry>;
  @useResult
  $Res call({String id, String name, int caloriesBurned, int duration});
}

/// @nodoc
class _$ExerciseEntryCopyWithImpl<$Res, $Val extends ExerciseEntry>
    implements $ExerciseEntryCopyWith<$Res> {
  _$ExerciseEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? caloriesBurned = null,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      caloriesBurned: null == caloriesBurned
          ? _value.caloriesBurned
          : caloriesBurned // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseEntryImplCopyWith<$Res>
    implements $ExerciseEntryCopyWith<$Res> {
  factory _$$ExerciseEntryImplCopyWith(
          _$ExerciseEntryImpl value, $Res Function(_$ExerciseEntryImpl) then) =
      __$$ExerciseEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int caloriesBurned, int duration});
}

/// @nodoc
class __$$ExerciseEntryImplCopyWithImpl<$Res>
    extends _$ExerciseEntryCopyWithImpl<$Res, _$ExerciseEntryImpl>
    implements _$$ExerciseEntryImplCopyWith<$Res> {
  __$$ExerciseEntryImplCopyWithImpl(
      _$ExerciseEntryImpl _value, $Res Function(_$ExerciseEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? caloriesBurned = null,
    Object? duration = null,
  }) {
    return _then(_$ExerciseEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      caloriesBurned: null == caloriesBurned
          ? _value.caloriesBurned
          : caloriesBurned // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseEntryImpl implements _ExerciseEntry {
  const _$ExerciseEntryImpl(
      {required this.id,
      required this.name,
      required this.caloriesBurned,
      required this.duration});

  factory _$ExerciseEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int caloriesBurned;
  @override
  final int duration;

  @override
  String toString() {
    return 'ExerciseEntry(id: $id, name: $name, caloriesBurned: $caloriesBurned, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.caloriesBurned, caloriesBurned) ||
                other.caloriesBurned == caloriesBurned) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, caloriesBurned, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseEntryImplCopyWith<_$ExerciseEntryImpl> get copyWith =>
      __$$ExerciseEntryImplCopyWithImpl<_$ExerciseEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseEntryImplToJson(
      this,
    );
  }
}

abstract class _ExerciseEntry implements ExerciseEntry {
  const factory _ExerciseEntry(
      {required final String id,
      required final String name,
      required final int caloriesBurned,
      required final int duration}) = _$ExerciseEntryImpl;

  factory _ExerciseEntry.fromJson(Map<String, dynamic> json) =
      _$ExerciseEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get caloriesBurned;
  @override
  int get duration;
  @override
  @JsonKey(ignore: true)
  _$$ExerciseEntryImplCopyWith<_$ExerciseEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
