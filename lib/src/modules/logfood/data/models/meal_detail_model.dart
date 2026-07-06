import 'food_model.dart';

/// Full meal payload from `GET api/Meal/:id` - not a [FoodModel]; avoids reusing food-detail semantics.
class MealNutritionTotals {
  const MealNutritionTotals({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.fiber,
    required this.sugar,
    required this.saturatedFat,
    required this.cholesterol,
    required this.sodium,
    required this.potassium,
    this.micronutrients = const {},
  });

  final double calories;
  final double carbs;
  final double fat;
  final double protein;
  final double fiber;
  final double sugar;
  final double saturatedFat;
  final double cholesterol;
  final double sodium;
  final double potassium;
  final Map<String, double> micronutrients;

  static double _d(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v.trim()) ?? 0;
    return 0;
  }

  factory MealNutritionTotals.fromJson(Map<String, dynamic>? json) {
    final m = json ?? const <String, dynamic>{};
    return MealNutritionTotals(
      calories: _d(m['calories']),
      carbs: _d(m['carbs']),
      fat: _d(m['fat']),
      protein: _d(m['protein']),
      fiber: _d(m['fiber']),
      sugar: _d(m['sugar'] ?? m['sugars']),
      saturatedFat: _d(m['saturatedFat']),
      cholesterol: _d(m['cholesterol']),
      sodium: _d(m['sodium']),
      potassium: _d(m['potassium']),
      micronutrients: {
        for (final field in AppNutrients.micronutrients)
          if (m[field.apiKey] != null || m[field.key] != null)
            field.key: _d(m[field.apiKey] ?? m[field.key]),
      },
    );
  }

  bool get hasCaloriesLine => calories > 0;
}

class MealItemFoodRef {
  const MealItemFoodRef({
    required this.id,
    required this.foodName,
    this.brandName,
    this.servingSize,
    this.servingUnit,
    this.caloriesPerServing,
    this.isVerified,
  });

  final int id;
  final String foodName;
  final String? brandName;
  final String? servingSize;
  final String? servingUnit;
  final double? caloriesPerServing;
  final bool? isVerified;

  bool get isAiEstimated {
    final b = brandName?.trim().toLowerCase();
    return b == 'ai estimated';
  }

  static MealItemFoodRef? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    int toInt(dynamic v) {
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v.trim()) ?? 0;
      return 0;
    }

    double? toD(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v.trim());
      return null;
    }

    /// API often sends 0 / 0.0 for unset serving; avoid showing "0.0 serving".
    String? positiveServingDisplay(dynamic v) {
      if (v == null) return null;
      double? d;
      if (v is num) {
        d = v.toDouble();
      } else {
        final t = v.toString().trim();
        if (t.isEmpty) return null;
        d = double.tryParse(t.replaceAll(',', '.'));
      }
      if (d == null || d <= 0) return null;
      if ((d - d.round()).abs() < 1e-9) return d.round().toString();
      return d.toString();
    }

    final unitRaw = (json['servingUnit'] ?? json['ServingUnit'])
        ?.toString()
        .trim();
    final unit = (unitRaw != null && unitRaw.isNotEmpty) ? unitRaw : null;

    return MealItemFoodRef(
      id: toInt(json['id']),
      foodName:
          (json['foodName'] as String?) ??
          (json['description'] as String?) ??
          '',
      brandName: json['brandName'] as String?,
      servingSize: positiveServingDisplay(
        json['servingSize'] ?? json['ServingSize'],
      ),
      servingUnit: unit,
      caloriesPerServing: toD(json['calories']),
      isVerified: json['isVerified'] as bool? ?? json['is_verified'] as bool?,
    );
  }
}

class MealLineItem {
  const MealLineItem({
    required this.mealFoodId,
    required this.foodId,
    required this.quantity,
    this.unit,
    required this.lineCalories,
    this.food,
    this.order = 0,
  });

  final int mealFoodId;
  final int foodId;
  final double quantity;
  final String? unit;
  final double lineCalories;
  final MealItemFoodRef? food;
  final int order;

  static double _d(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v.trim()) ?? 0;
    return 0;
  }

  factory MealLineItem.fromJson(Map<String, dynamic> json) {
    int toInt(dynamic v) {
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v.trim()) ?? 0;
      return 0;
    }

    final q = _d(json['quantity']);
    return MealLineItem(
      mealFoodId: toInt(json['mealFoodId'] ?? json['id']),
      foodId: toInt(json['foodId']),
      quantity: q < 0 ? 0 : q,
      unit: json['unit'] as String?,
      lineCalories: _d(json['calories']),
      food: MealItemFoodRef.fromJson(json['food'] as Map<String, dynamic>?),
      order: toInt(json['order']),
    );
  }

  String get displayName =>
      food?.foodName.isNotEmpty == true ? food!.foodName : 'Food #$foodId';
}

class MealDetail {
  const MealDetail({
    required this.id,
    required this.name,
    this.directions,
    required this.shareWith,
    this.imageUrl,
    required this.nutritionSummary,
    required this.items,
  });

  final int id;
  final String name;
  final String? directions;
  final int shareWith;
  final String? imageUrl;
  final MealNutritionTotals nutritionSummary;
  final List<MealLineItem> items;

  static int _i(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v.trim()) ?? 0;
    return 0;
  }

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    final rawItems = (json['items'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    final items = rawItems.map(MealLineItem.fromJson).toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    return MealDetail(
      id: _i(json['id']),
      name: (json['name'] as String?) ?? '',
      directions: json['directions'] as String?,
      shareWith: _i(json['shareWith']),
      imageUrl: json['imageUrl'] as String?,
      nutritionSummary: MealNutritionTotals.fromJson(
        json['nutritionSummary'] as Map<String, dynamic>?,
      ),
      items: items,
    );
  }
}
