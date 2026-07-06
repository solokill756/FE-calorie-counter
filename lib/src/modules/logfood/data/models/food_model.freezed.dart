// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FoodModel _$FoodModelFromJson(Map<String, dynamic> json) {
  return _FoodModel.fromJson(json);
}

/// @nodoc
mixin _$FoodModel {
  String get name => throw _privateConstructorUsedError;
  double get servingPerContainer => throw _privateConstructorUsedError;
  List<String> get units => throw _privateConstructorUsedError;
  List<double> get unitSizes => throw _privateConstructorUsedError;
  int get unitShowIndex => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  /// Set for GET /LogFood rows logged from a saved meal; drives history tap → meal detail.
  int? get mealTemplateId => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get loggedAt =>
      throw _privateConstructorUsedError; // Time when food was logged (for sorting recent foods)
  bool get isVerified => throw _privateConstructorUsedError;
  Map<String, double> get nutrients => throw _privateConstructorUsedError;
  Map<String, double> get baseNutrients => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodModelCopyWith<FoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodModelCopyWith<$Res> {
  factory $FoodModelCopyWith(FoodModel value, $Res Function(FoodModel) then) =
      _$FoodModelCopyWithImpl<$Res, FoodModel>;
  @useResult
  $Res call(
      {String name,
      double servingPerContainer,
      List<String> units,
      List<double> unitSizes,
      int unitShowIndex,
      double quantity,
      int? id,
      int? mealTemplateId,
      String? brand,
      String? description,
      String? createdBy,
      DateTime? createdAt,
      DateTime? loggedAt,
      bool isVerified,
      Map<String, double> nutrients,
      Map<String, double> baseNutrients});
}

/// @nodoc
class _$FoodModelCopyWithImpl<$Res, $Val extends FoodModel>
    implements $FoodModelCopyWith<$Res> {
  _$FoodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? servingPerContainer = null,
    Object? units = null,
    Object? unitSizes = null,
    Object? unitShowIndex = null,
    Object? quantity = null,
    Object? id = freezed,
    Object? mealTemplateId = freezed,
    Object? brand = freezed,
    Object? description = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? loggedAt = freezed,
    Object? isVerified = null,
    Object? nutrients = null,
    Object? baseNutrients = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      servingPerContainer: null == servingPerContainer
          ? _value.servingPerContainer
          : servingPerContainer // ignore: cast_nullable_to_non_nullable
              as double,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unitSizes: null == unitSizes
          ? _value.unitSizes
          : unitSizes // ignore: cast_nullable_to_non_nullable
              as List<double>,
      unitShowIndex: null == unitShowIndex
          ? _value.unitShowIndex
          : unitShowIndex // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      mealTemplateId: freezed == mealTemplateId
          ? _value.mealTemplateId
          : mealTemplateId // ignore: cast_nullable_to_non_nullable
              as int?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      loggedAt: freezed == loggedAt
          ? _value.loggedAt
          : loggedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      nutrients: null == nutrients
          ? _value.nutrients
          : nutrients // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      baseNutrients: null == baseNutrients
          ? _value.baseNutrients
          : baseNutrients // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodModelImplCopyWith<$Res>
    implements $FoodModelCopyWith<$Res> {
  factory _$$FoodModelImplCopyWith(
          _$FoodModelImpl value, $Res Function(_$FoodModelImpl) then) =
      __$$FoodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      double servingPerContainer,
      List<String> units,
      List<double> unitSizes,
      int unitShowIndex,
      double quantity,
      int? id,
      int? mealTemplateId,
      String? brand,
      String? description,
      String? createdBy,
      DateTime? createdAt,
      DateTime? loggedAt,
      bool isVerified,
      Map<String, double> nutrients,
      Map<String, double> baseNutrients});
}

/// @nodoc
class __$$FoodModelImplCopyWithImpl<$Res>
    extends _$FoodModelCopyWithImpl<$Res, _$FoodModelImpl>
    implements _$$FoodModelImplCopyWith<$Res> {
  __$$FoodModelImplCopyWithImpl(
      _$FoodModelImpl _value, $Res Function(_$FoodModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? servingPerContainer = null,
    Object? units = null,
    Object? unitSizes = null,
    Object? unitShowIndex = null,
    Object? quantity = null,
    Object? id = freezed,
    Object? mealTemplateId = freezed,
    Object? brand = freezed,
    Object? description = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? loggedAt = freezed,
    Object? isVerified = null,
    Object? nutrients = null,
    Object? baseNutrients = null,
  }) {
    return _then(_$FoodModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      servingPerContainer: null == servingPerContainer
          ? _value.servingPerContainer
          : servingPerContainer // ignore: cast_nullable_to_non_nullable
              as double,
      units: null == units
          ? _value._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unitSizes: null == unitSizes
          ? _value._unitSizes
          : unitSizes // ignore: cast_nullable_to_non_nullable
              as List<double>,
      unitShowIndex: null == unitShowIndex
          ? _value.unitShowIndex
          : unitShowIndex // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      mealTemplateId: freezed == mealTemplateId
          ? _value.mealTemplateId
          : mealTemplateId // ignore: cast_nullable_to_non_nullable
              as int?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      loggedAt: freezed == loggedAt
          ? _value.loggedAt
          : loggedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      nutrients: null == nutrients
          ? _value._nutrients
          : nutrients // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      baseNutrients: null == baseNutrients
          ? _value._baseNutrients
          : baseNutrients // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodModelImpl extends _FoodModel {
  const _$FoodModelImpl(
      {required this.name,
      required this.servingPerContainer,
      required final List<String> units,
      required final List<double> unitSizes,
      required this.unitShowIndex,
      required this.quantity,
      this.id,
      this.mealTemplateId,
      this.brand,
      this.description,
      this.createdBy,
      this.createdAt,
      this.loggedAt,
      this.isVerified = false,
      final Map<String, double> nutrients = const {},
      final Map<String, double> baseNutrients = const {}})
      : _units = units,
        _unitSizes = unitSizes,
        _nutrients = nutrients,
        _baseNutrients = baseNutrients,
        super._();

  factory _$FoodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodModelImplFromJson(json);

  @override
  final String name;
  @override
  final double servingPerContainer;
  final List<String> _units;
  @override
  List<String> get units {
    if (_units is EqualUnmodifiableListView) return _units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

  final List<double> _unitSizes;
  @override
  List<double> get unitSizes {
    if (_unitSizes is EqualUnmodifiableListView) return _unitSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unitSizes);
  }

  @override
  final int unitShowIndex;
  @override
  final double quantity;
  @override
  final int? id;

  /// Set for GET /LogFood rows logged from a saved meal; drives history tap → meal detail.
  @override
  final int? mealTemplateId;
  @override
  final String? brand;
  @override
  final String? description;
  @override
  final String? createdBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? loggedAt;
// Time when food was logged (for sorting recent foods)
  @override
  @JsonKey()
  final bool isVerified;
  final Map<String, double> _nutrients;
  @override
  @JsonKey()
  Map<String, double> get nutrients {
    if (_nutrients is EqualUnmodifiableMapView) return _nutrients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nutrients);
  }

  final Map<String, double> _baseNutrients;
  @override
  @JsonKey()
  Map<String, double> get baseNutrients {
    if (_baseNutrients is EqualUnmodifiableMapView) return _baseNutrients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_baseNutrients);
  }

  @override
  String toString() {
    return 'FoodModel(name: $name, servingPerContainer: $servingPerContainer, units: $units, unitSizes: $unitSizes, unitShowIndex: $unitShowIndex, quantity: $quantity, id: $id, mealTemplateId: $mealTemplateId, brand: $brand, description: $description, createdBy: $createdBy, createdAt: $createdAt, loggedAt: $loggedAt, isVerified: $isVerified, nutrients: $nutrients, baseNutrients: $baseNutrients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.servingPerContainer, servingPerContainer) ||
                other.servingPerContainer == servingPerContainer) &&
            const DeepCollectionEquality().equals(other._units, _units) &&
            const DeepCollectionEquality()
                .equals(other._unitSizes, _unitSizes) &&
            (identical(other.unitShowIndex, unitShowIndex) ||
                other.unitShowIndex == unitShowIndex) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mealTemplateId, mealTemplateId) ||
                other.mealTemplateId == mealTemplateId) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.loggedAt, loggedAt) ||
                other.loggedAt == loggedAt) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            const DeepCollectionEquality()
                .equals(other._nutrients, _nutrients) &&
            const DeepCollectionEquality()
                .equals(other._baseNutrients, _baseNutrients));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      servingPerContainer,
      const DeepCollectionEquality().hash(_units),
      const DeepCollectionEquality().hash(_unitSizes),
      unitShowIndex,
      quantity,
      id,
      mealTemplateId,
      brand,
      description,
      createdBy,
      createdAt,
      loggedAt,
      isVerified,
      const DeepCollectionEquality().hash(_nutrients),
      const DeepCollectionEquality().hash(_baseNutrients));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodModelImplCopyWith<_$FoodModelImpl> get copyWith =>
      __$$FoodModelImplCopyWithImpl<_$FoodModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodModelImplToJson(
      this,
    );
  }
}

abstract class _FoodModel extends FoodModel {
  const factory _FoodModel(
      {required final String name,
      required final double servingPerContainer,
      required final List<String> units,
      required final List<double> unitSizes,
      required final int unitShowIndex,
      required final double quantity,
      final int? id,
      final int? mealTemplateId,
      final String? brand,
      final String? description,
      final String? createdBy,
      final DateTime? createdAt,
      final DateTime? loggedAt,
      final bool isVerified,
      final Map<String, double> nutrients,
      final Map<String, double> baseNutrients}) = _$FoodModelImpl;
  const _FoodModel._() : super._();

  factory _FoodModel.fromJson(Map<String, dynamic> json) =
      _$FoodModelImpl.fromJson;

  @override
  String get name;
  @override
  double get servingPerContainer;
  @override
  List<String> get units;
  @override
  List<double> get unitSizes;
  @override
  int get unitShowIndex;
  @override
  double get quantity;
  @override
  int? get id;
  @override

  /// Set for GET /LogFood rows logged from a saved meal; drives history tap → meal detail.
  int? get mealTemplateId;
  @override
  String? get brand;
  @override
  String? get description;
  @override
  String? get createdBy;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get loggedAt;
  @override // Time when food was logged (for sorting recent foods)
  bool get isVerified;
  @override
  Map<String, double> get nutrients;
  @override
  Map<String, double> get baseNutrients;
  @override
  @JsonKey(ignore: true)
  _$$FoodModelImplCopyWith<_$FoodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
