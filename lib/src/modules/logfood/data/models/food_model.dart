import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_model.freezed.dart';
part 'food_model.g.dart';

class NutrientDisplayNames {
  static const caloriesKcal = 'Calories';
  static const fatTotalG = 'Fat (g)';
  static const fatSaturatedG = 'Saturated Fat (g)';
  static const fatPolyunsatG = 'Polyunsaturated Fat (g)';
  static const fatMonounsatG = 'Monounsaturated Fat (g)';
  static const fatTransG = 'Trans Fat (g)';
  static const cholesterolMg = 'Cholesterol (mg)';
  static const sodiumMg = 'Sodium (mg)';
  static const potassiumMg = 'Potassium (mg)';
  static const carbsTotalG = 'Total Carbohydrates (g)';
  static const fiberG = 'Dietary Fiber (g)';
  static const sugarsG = 'Sugars (g)';
  static const sugarsAddedG = 'Added Sugars (g)';
  static const sugarAlcoholsG = 'Sugar Alcohols (g)';
  static const proteinG = 'Protein (g)';
  static const calciumMg = 'Calcium (mg)';
  static const ironMg = 'Iron (mg)';
  static const magnesiumMg = 'Magnesium (mg)';
  static const phosphorusMg = 'Phosphorus (mg)';
  static const zincMg = 'Zinc (mg)';
  static const vitaminAUg = 'Vitamin A (mcg)';
  static const vitaminCMg = 'Vitamin C (mg)';
  static const vitaminDUg = 'Vitamin D (mcg)';
  static const vitaminEMg = 'Vitamin E (mg)';
  static const vitaminKUg = 'Vitamin K (mcg)';
  static const vitaminB6Mg = 'Vitamin B6 (mg)';
  static const vitaminB12Ug = 'Vitamin B12 (mcg)';
  static const folateDfeUg = 'Folate DFE (mcg)';
  static const vitaminAPercent = 'Vitamin A (%)';
}

class NutrientKeys {
  static const caloriesKcal = 'calories_kcal';
  static const fatTotalG = 'fat_total_g';
  static const fatSaturatedG = 'fat_saturated_g';
  static const fatPolyunsatG = 'fat_polyunsat_g';
  static const fatMonounsatG = 'fat_monounsat_g';
  static const fatTransG = 'fat_trans_g';
  static const cholesterolMg = 'cholesterol_mg';
  static const sodiumMg = 'sodium_mg';
  static const potassiumMg = 'potassium_mg';
  static const carbsTotalG = 'carbs_total_g';
  static const fiberG = 'fiber_g';
  static const sugarsG = 'sugars_g';
  static const sugarsAddedG = 'sugars_added_g';
  static const sugarAlcoholsG = 'sugar_alcohols_g';
  static const proteinG = 'protein_g';
  static const calciumMg = 'calcium_mg';
  static const ironMg = 'iron_mg';
  static const magnesiumMg = 'magnesium_mg';
  static const phosphorusMg = 'phosphorus_mg';
  static const zincMg = 'zinc_mg';
  static const vitaminAUg = 'vitamin_a_ug';
  static const vitaminCMg = 'vitamin_c_mg';
  static const vitaminDUg = 'vitamin_d_ug';
  static const vitaminEMg = 'vitamin_e_mg';
  static const vitaminKUg = 'vitamin_k_ug';
  static const vitaminB6Mg = 'vitamin_b6_mg';
  static const vitaminB12Ug = 'vitamin_b12_ug';
  static const folateDfeUg = 'folate_dfe_ug';
  static const vitaminAPercent = 'vitamin_a_percent';
}

class AppNutrientField {
  final String key;
  final String apiKey;
  final String label;
  final String unit;
  final List<String> aliases;

  const AppNutrientField({
    required this.key,
    required this.apiKey,
    required this.label,
    required this.unit,
    required this.aliases,
  });
}

class AppNutrients {
  static const minerals = <AppNutrientField>[
    AppNutrientField(
      key: NutrientKeys.calciumMg,
      apiKey: 'calciumMg',
      label: 'Calcium',
      unit: 'mg',
      aliases: ['calciumMg', 'CalciumMg', 'calcium'],
    ),
    AppNutrientField(
      key: NutrientKeys.ironMg,
      apiKey: 'ironMg',
      label: 'Iron',
      unit: 'mg',
      aliases: ['ironMg', 'IronMg', 'iron'],
    ),
    AppNutrientField(
      key: NutrientKeys.magnesiumMg,
      apiKey: 'magnesiumMg',
      label: 'Magnesium',
      unit: 'mg',
      aliases: ['magnesiumMg', 'MagnesiumMg', 'magnesium'],
    ),
    AppNutrientField(
      key: NutrientKeys.phosphorusMg,
      apiKey: 'phosphorusMg',
      label: 'Phosphorus',
      unit: 'mg',
      aliases: ['phosphorusMg', 'PhosphorusMg', 'phosphorus'],
    ),
    AppNutrientField(
      key: NutrientKeys.zincMg,
      apiKey: 'zincMg',
      label: 'Zinc',
      unit: 'mg',
      aliases: ['zincMg', 'ZincMg', 'zinc'],
    ),
  ];

  static const vitamins = <AppNutrientField>[
    AppNutrientField(
      key: NutrientKeys.vitaminAUg,
      apiKey: 'vitaminAUg',
      label: 'Vitamin A',
      unit: 'mcg',
      aliases: ['vitaminAUg', 'VitaminAUg', 'vitaminA'],
    ),
    AppNutrientField(
      key: NutrientKeys.vitaminCMg,
      apiKey: 'vitaminCMg',
      label: 'Vitamin C',
      unit: 'mg',
      aliases: ['vitaminCMg', 'VitaminCMg', 'vitaminC'],
    ),
    AppNutrientField(
      key: NutrientKeys.vitaminDUg,
      apiKey: 'vitaminDUg',
      label: 'Vitamin D',
      unit: 'mcg',
      aliases: ['vitaminDUg', 'VitaminDUg', 'vitaminD'],
    ),
    AppNutrientField(
      key: NutrientKeys.vitaminEMg,
      apiKey: 'vitaminEMg',
      label: 'Vitamin E',
      unit: 'mg',
      aliases: ['vitaminEMg', 'VitaminEMg', 'vitaminE'],
    ),
    AppNutrientField(
      key: NutrientKeys.vitaminKUg,
      apiKey: 'vitaminKUg',
      label: 'Vitamin K',
      unit: 'mcg',
      aliases: ['vitaminKUg', 'VitaminKUg', 'vitaminK'],
    ),
    AppNutrientField(
      key: NutrientKeys.vitaminB6Mg,
      apiKey: 'vitaminB6Mg',
      label: 'Vitamin B6',
      unit: 'mg',
      aliases: ['vitaminB6Mg', 'VitaminB6Mg', 'vitaminB6'],
    ),
    AppNutrientField(
      key: NutrientKeys.vitaminB12Ug,
      apiKey: 'vitaminB12Ug',
      label: 'Vitamin B12',
      unit: 'mcg',
      aliases: ['vitaminB12Ug', 'VitaminB12Ug', 'vitaminB12'],
    ),
    AppNutrientField(
      key: NutrientKeys.folateDfeUg,
      apiKey: 'folateDfeUg',
      label: 'Folate DFE',
      unit: 'mcg',
      aliases: ['folateDfeUg', 'FolateDfeUg', 'folateDfe'],
    ),
  ];

  static const micronutrients = <AppNutrientField>[...minerals, ...vitamins];
}

@freezed
class FoodModel with _$FoodModel {
  const factory FoodModel({
    required String name,
    required double servingPerContainer,
    required List<String> units,
    required List<double> unitSizes,
    required int unitShowIndex,
    required double quantity,
    int? id,

    /// Set for GET /LogFood rows logged from a saved meal; drives history tap → meal detail.
    int? mealTemplateId,
    String? brand,
    String? description,
    String? createdBy,
    DateTime? createdAt,
    DateTime? loggedAt, // Time when food was logged (for sorting recent foods)
    @Default(false) bool isVerified,
    @Default({}) Map<String, double> nutrients,
    @Default({}) Map<String, double> baseNutrients,
  }) = _FoodModel;

  const FoodModel._();

  /// True when this `Food` row is an AI meal-plan estimate (`Category = AI Estimated` on server → `brandName` here).
  bool get isAiEstimated {
    final b = brand?.trim().toLowerCase();
    return b == 'ai estimated';
  }

  /// Brand label for list rows; null when empty, redundant, or shown via another chip.
  String? get listBrandLabel {
    if (isAiEstimated) return null;
    final label = brand?.trim();
    if (label == null || label.isEmpty) return null;
    if (name.trim().toLowerCase() == label.toLowerCase()) return null;
    return label;
  }

  // Computed properties
  double get calories => nutrients[NutrientKeys.caloriesKcal] ?? 0;

  /// True when API provided a calorie value (including 0). False when calories were omitted/null.
  bool get hasCaloriesData => nutrients.containsKey(NutrientKeys.caloriesKcal);
  double? get carbs => nutrients[NutrientKeys.carbsTotalG];
  double? get protein => nutrients[NutrientKeys.proteinG];
  double? get fat => nutrients[NutrientKeys.fatTotalG];
  double? get fiber => nutrients[NutrientKeys.fiberG];
  double? get sodium => nutrients[NutrientKeys.sodiumMg];

  // JSON serialization
  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);

  // Custom factory constructors

  factory FoodModel.fromJsonWithFallback(Map<String, dynamic> json) {
    double? asNum(dynamic v) => (v as num?)?.toDouble();

    final n =
        (json['nutrients'] as Map<String, dynamic>?)?.map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ) ??
        const <String, double>{};

    // Handle nutrients fallback
    final nutrients = n.isNotEmpty
        ? n
        : <String, double>{
            if (json['calories'] != null)
              NutrientKeys.caloriesKcal: asNum(json['calories']) ?? 0,
            if (json['fat'] != null)
              NutrientKeys.fatTotalG: asNum(json['fat'])!,
            if (json['protein'] != null)
              NutrientKeys.proteinG: asNum(json['protein'])!,
            if (json['carbs'] != null)
              NutrientKeys.carbsTotalG: asNum(json['carbs'])!,
            if (json['fiber'] != null)
              NutrientKeys.fiberG: asNum(json['fiber'])!,
            if (json['sugarsG'] != null || json['sugar'] != null)
              NutrientKeys.sugarsG:
                  asNum(json['sugarsG'] ?? json['sugar']) ?? 0,
            if (json['saturatedFatG'] != null || json['saturatedFat'] != null)
              NutrientKeys.fatSaturatedG:
                  asNum(json['saturatedFatG'] ?? json['saturatedFat']) ?? 0,
            if (json['cholesterolMg'] != null || json['cholesterol'] != null)
              NutrientKeys.cholesterolMg:
                  asNum(json['cholesterolMg'] ?? json['cholesterol']) ?? 0,
            if (json['potassiumMg'] != null || json['potassium'] != null)
              NutrientKeys.potassiumMg:
                  asNum(json['potassiumMg'] ?? json['potassium']) ?? 0,
            for (final field in AppNutrients.micronutrients)
              if (field.aliases.any((key) => json[key] != null))
                field.key:
                    asNum(
                      field.aliases
                          .map((key) => json[key])
                          .firstWhere((value) => value != null),
                    ) ??
                    0,
          };

    return FoodModel(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '') as String,
      description: json['description'] as String?,
      units:
          (json['units'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          ['units'],
      unitSizes:
          (json['unit_sizes'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [1.0],
      unitShowIndex: (json['unit_show_index'] as int?) ?? 0,
      servingPerContainer:
          asNum(
            json['servingsPerContainer'] ??
                json['servingPerContainer'] ??
                json['servings_per_container'],
          ) ??
          1.0,
      brand: json['brand'] as String?,
      createdBy: json['createdBy'] as String?,
      isVerified: (json['is_verified'] as bool?) ?? false,
      nutrients: nutrients,
      quantity: (json['quantity'] as double?) ?? 1,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
