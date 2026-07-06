import '../data/models/food_model.dart';
import '../domain/entities/macros_entity.dart';

enum LogType {
  singleFood, // 1 food to 1 day
  multipleDays, // 1 food to multiple days
  multipleFoods, // multiple foods to 1 day
  multipleFoodsMultipleDays, // multiple foods to multiple days
}

class LogFoodHelper {
  String dateKeyFrom(DateTime dt) {
    final local = dt.toLocal();
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// Lịch sử log: **loggedAt giảm dần** (mới nhất trước); thiếu [loggedAt] thì dùng [createdAt].
  /// `bTime.compareTo(aTime)` = descending theo thời gian.
  static void sortByLoggedAtNewestFirst(List<FoodModel> foods) {
    foods.sort((a, b) {
      final aTime = a.loggedAt ?? a.createdAt;
      final bTime = b.loggedAt ?? b.createdAt;
      if (aTime == null && bTime == null) return 0;
      if (aTime == null) return 1;
      if (bTime == null) return -1;
      return bTime.compareTo(aTime);
    });
  }

  // double _r1(num v) => (v * 10).round() / 10.0;

  // Map<String, double> macrosForQty({
  //   required double baseCalories,
  //   double? baseProtein,
  //   double? baseCarbs,
  //   double? baseFat,
  //   double? baseFiber,
  //   required double qty,
  //   required double servingSize,
  // }) {
  //   double scale(num? n) => _r1((n ?? 0) * qty * servingSize);
  //   return {
  //     NutrientKeys.caloriesKcal: scale(baseCalories),
  //     NutrientKeys.proteinG: scale(baseProtein),
  //     NutrientKeys.carbsTotalG: scale(baseCarbs),
  //     NutrientKeys.fatTotalG: scale(baseFat),
  //     NutrientKeys.fiberG: scale(baseFiber),
  //   };
  // }

  // Smart log helper methods
  LogType determineLogType({
    required bool hasMultipleDays,
    required bool hasMultipleFoods,
  }) {
    if (hasMultipleFoods && hasMultipleDays) {
      return LogType.multipleFoodsMultipleDays;
    } else if (hasMultipleDays && !hasMultipleFoods) {
      return LogType.multipleDays;
    } else if (hasMultipleFoods && !hasMultipleDays) {
      return LogType.multipleFoods;
    } else {
      return LogType.singleFood;
    }
  }

  String getLogTypeLabel(LogType logType) {
    switch (logType) {
      case LogType.singleFood:
        return 'SINGLE';
      case LogType.multipleDays:
        return 'MULTI-DAY';
      case LogType.multipleFoods:
        return 'MULTI-FOOD';
      case LogType.multipleFoodsMultipleDays:
        return 'BULK';
    }
  }

  // Get icon data for log type (returns string for icon name)
  String getLogTypeIconName(LogType logType) {
    switch (logType) {
      case LogType.singleFood:
        return 'restaurant_outlined';
      case LogType.multipleDays:
        return 'calendar_today_outlined';
      case LogType.multipleFoods:
        return 'restaurant_menu_outlined';
      case LogType.multipleFoodsMultipleDays:
        return 'grid_view_outlined';
    }
  }

  String getSmartLogDescription({
    required LogType logType,
    required int selectedDaysCount,
    required int selectedFoodsCount,
  }) {
    switch (logType) {
      case LogType.singleFood:
        return 'Log 1 food to today';
      case LogType.multipleDays:
        return 'Log 1 food to $selectedDaysCount days';
      case LogType.multipleFoods:
        return 'Log $selectedFoodsCount foods to today';
      case LogType.multipleFoodsMultipleDays:
        return 'Log $selectedFoodsCount foods to $selectedDaysCount days';
    }
  }

  // Helper to create dates from day indices in the week containing [baseDate].
  List<DateTime> createDatesFromIndices(
    Set<int> dayIndices, {
    DateTime? baseDate,
  }) {
    final now = baseDate ?? DateTime.now();
    final daysFromSunday = now.weekday == 7 ? 0 : now.weekday;
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: daysFromSunday));
    return dayIndices.map((index) {
      return startOfWeek.add(Duration(days: index));
    }).toList();
  }

  static double _nutrientFromMaps(
    FoodModel food,
    Map<String, double> nutrients,
    String key,
  ) =>
      nutrients[key] ?? food.nutrients[key] ?? 0;

  /// Same scaling rules as [LogFoodDetailView] `macros` getter: [qty] servings,
  /// [unitSelectedIndex], optional [mainFoodServingSizeLabel] for the main
  /// food's "container" parsing; other foods use their own unit label.
  static MacrosEntity macrosForQuantity(
    FoodModel food,
    double qty,
    int unitSelectedIndex, {
    String? mainFoodServingSizeLabel,
  }) {
    if (food.unitSizes.isEmpty) {
      return MacrosEntity.fromFood(
        carbs: food.carbs ?? 0,
        fat: food.fat ?? 0,
        protein: food.protein ?? 0,
        calories: food.calories,
        multiplier: qty,
        servingSize: 1.0,
        sodiumPerServing:
            food.sodium ?? food.nutrients[NutrientKeys.sodiumMg] ?? 0,
        fiberPerServing: food.fiber ?? food.nutrients[NutrientKeys.fiberG] ?? 0,
        saturatedFatPerServing: food.nutrients[NutrientKeys.fatSaturatedG] ?? 0,
        cholesterolPerServing: food.nutrients[NutrientKeys.cholesterolMg] ?? 0,
        sugarsPerServing:
            _nutrientFromMaps(food, food.nutrients, NutrientKeys.sugarsG),
        potassiumPerServing:
            _nutrientFromMaps(food, food.nutrients, NutrientKeys.potassiumMg),
      );
    }

    final safeUnit = unitSelectedIndex.clamp(0, food.unitSizes.length - 1);
    final servingLabel =
        mainFoodServingSizeLabel ??
        (food.units.length > safeUnit ? food.units[safeUnit] : '');

    final bool hasBaseNutrients = food.baseNutrients.isNotEmpty;
    final bool isSameAsOriginal =
        hasBaseNutrients &&
        qty == food.quantity &&
        safeUnit == food.unitShowIndex;

    if (isSameAsOriginal) {
      return MacrosEntity.fromFood(
        carbs: food.carbs ?? 0,
        fat: food.fat ?? 0,
        protein: food.protein ?? 0,
        calories: food.calories,
        multiplier: 1.0,
        servingSize: 1.0,
        sodiumPerServing:
            food.sodium ?? food.nutrients[NutrientKeys.sodiumMg] ?? 0,
        fiberPerServing: food.fiber ?? food.nutrients[NutrientKeys.fiberG] ?? 0,
        saturatedFatPerServing: food.nutrients[NutrientKeys.fatSaturatedG] ?? 0,
        cholesterolPerServing: food.nutrients[NutrientKeys.cholesterolMg] ?? 0,
        sugarsPerServing:
            _nutrientFromMaps(food, food.nutrients, NutrientKeys.sugarsG),
        potassiumPerServing:
            _nutrientFromMaps(food, food.nutrients, NutrientKeys.potassiumMg),
      );
    }

    if (hasBaseNutrients) {
      final nutrientsToUse = food.baseNutrients;
      final double baseServingSize = food.unitSizes[food.unitShowIndex];
      final double currentServingSize = food.unitSizes[safeUnit];
      final double originalQuantity = food.quantity;
      final double newMultiplier =
          (currentServingSize * qty) / (baseServingSize * originalQuantity);

      return MacrosEntity.fromFood(
        carbs: (nutrientsToUse[NutrientKeys.carbsTotalG] ?? 0),
        fat: (nutrientsToUse[NutrientKeys.fatTotalG] ?? 0),
        protein: (nutrientsToUse[NutrientKeys.proteinG] ?? 0),
        calories: nutrientsToUse[NutrientKeys.caloriesKcal] ?? 0,
        multiplier: newMultiplier,
        servingSize: 1,
        sodiumPerServing: nutrientsToUse[NutrientKeys.sodiumMg] ?? 0,
        fiberPerServing: nutrientsToUse[NutrientKeys.fiberG] ?? 0,
        saturatedFatPerServing: nutrientsToUse[NutrientKeys.fatSaturatedG] ?? 0,
        cholesterolPerServing: nutrientsToUse[NutrientKeys.cholesterolMg] ?? 0,
        sugarsPerServing:
            _nutrientFromMaps(food, nutrientsToUse, NutrientKeys.sugarsG),
        potassiumPerServing:
            _nutrientFromMaps(food, nutrientsToUse, NutrientKeys.potassiumMg),
      );
    }

    double servingSizeMultiplier = 1.0;
    try {
      final parts = servingLabel.split(' ');
      if (parts.length > 1 && parts[1] == 'container') {
        servingSizeMultiplier = food.servingPerContainer;
      }
    } catch (_) {
      servingSizeMultiplier = 1.0;
    }

    final multiplier = servingSizeMultiplier * qty;
    final servingSizeRatio = safeUnit != food.unitShowIndex
        ? food.unitSizes[safeUnit] / food.unitSizes[food.unitShowIndex]
        : 1.0;

    return MacrosEntity.fromFood(
      carbs: food.carbs ?? 0,
      fat: food.fat ?? 0,
      protein: food.protein ?? 0,
      calories: food.calories,
      multiplier: multiplier,
      servingSize: servingSizeRatio,
      sodiumPerServing:
          food.sodium ?? food.nutrients[NutrientKeys.sodiumMg] ?? 0,
      fiberPerServing: food.fiber ?? food.nutrients[NutrientKeys.fiberG] ?? 0,
      saturatedFatPerServing: food.nutrients[NutrientKeys.fatSaturatedG] ?? 0,
      cholesterolPerServing: food.nutrients[NutrientKeys.cholesterolMg] ?? 0,
      sugarsPerServing:
          _nutrientFromMaps(food, food.nutrients, NutrientKeys.sugarsG),
      potassiumPerServing:
          _nutrientFromMaps(food, food.nutrients, NutrientKeys.potassiumMg),
    );
  }

  // Calculate total macro calories for percentage calculation
  double calculateTotalMacroCalories({
    required int carbs,
    required int fat,
    required int protein,
  }) {
    return (carbs * 4.0) + (fat * 9.0) + (protein * 4.0);
  }

  // Calculate macro percentages
  Map<String, double> calculateMacroPercentages({
    required int carbs,
    required int fat,
    required int protein,
  }) {
    final total = calculateTotalMacroCalories(
      carbs: carbs,
      fat: fat,
      protein: protein,
    );

    if (total == 0) {
      return {'carbs': 0.0, 'fat': 0.0, 'protein': 0.0};
    }

    return {
      'carbs': (carbs * 4.0) / total,
      'fat': (fat * 9.0) / total,
      'protein': (protein * 4.0) / total,
    };
  }

  /// GET /api/LogFood returns per-log macros on the root object; nested [food]
  /// is catalog metadata only (no calories/macros). Merging avoids history = 0.
  static Map<String, dynamic> _mergeLogFoodJsonForModel(
    Map<String, dynamic> json,
  ) {
    final nested = json['food'] as Map<String, dynamic>?;
    final Map<String, dynamic> base = Map<String, dynamic>.from(nested ?? json);
    if (nested == null) {
      // Log rows use [unit] (e.g. "meal"); mapApiFoodToModel reads [servingUnit].
      final su = base['servingUnit'] ?? base['ServingUnit'];
      final suEmpty = su == null || su.toString().trim().isEmpty;
      if (suEmpty) {
        final u = json['unit'] ?? json['Unit'];
        if (u != null && u.toString().trim().isNotEmpty) {
          base['servingUnit'] = u;
        }
      }
      return base;
    }

    for (final key in <String>[
      'calories',
      'totalFatG',
      'totalCarbohydratesG',
      'proteinG',
      'sodiumMg',
      'sugarsG',
      'saturatedFatG',
      'cholesterolMg',
      'potassiumMg',
      ...AppNutrients.micronutrients.map((field) => field.apiKey),
      'servingSize',
      'servingUnit',
      'isVerified',
    ]) {
      if (json[key] == null) continue;
      // Log row may send servingSize 0 for meal/snapshot; keep nested food value.
      if (key == 'servingSize' && _parseLogDouble(json[key]) <= 0) continue;
      base[key] = json[key];
    }
    if (json['is_verified'] != null) {
      base['isVerified'] = json['is_verified'];
    }
    if (json['unit'] != null) {
      base['servingUnit'] = json['unit'];
    }
    final foodName = json['foodName'] as String?;
    if (foodName != null && foodName.isNotEmpty) {
      final desc = base['description'] as String?;
      if (desc == null || desc.isEmpty) {
        base['description'] = foodName;
      }
    }
    final foodId = json['foodId'];
    if (foodId != null && base['id'] == null) {
      base['id'] = foodId is int ? foodId : (foodId as num).toInt();
    }
    return base;
  }

  static bool _logJsonHasMacroSnapshot(Map<String, dynamic> json) {
    return json['calories'] != null ||
        json['totalFatG'] != null ||
        json['totalCarbohydratesG'] != null ||
        json['proteinG'] != null ||
        json['sugarsG'] != null ||
        json['saturatedFatG'] != null ||
        json['cholesterolMg'] != null ||
        json['potassiumMg'] != null ||
        AppNutrients.micronutrients.any((field) => json[field.apiKey] != null);
  }

  static int? _mealTemplateIdFromLogJson(Map<String, dynamic> json) {
    final v = json['mealId'] ?? json['MealId'];
    if (v == null) return null;
    if (v is int) return v > 0 ? v : null;
    if (v is num) return v.toInt() > 0 ? v.toInt() : null;
    final p = int.tryParse(v.toString().trim());
    return (p != null && p > 0) ? p : null;
  }

  /// Saved-meal log: always show serving label as [1 meal] (history, detail).
  static FoodModel _withMealTemplateUnits(FoodModel m) {
    return m.copyWith(
      units: const ['1 meal'],
      unitSizes: const [1.0],
      unitShowIndex: 0,
    );
  }

  /// LogFood API may send numeric fields as [num] or [String] (Postgres numeric).
  static double _parseLogDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    if (v is String) {
      final t = v.trim();
      if (t.isEmpty) return 0.0;
      return double.tryParse(t) ?? 0.0;
    }
    return 0.0;
  }

  static FoodModel mapLogFoodToModel(Map<String, dynamic> json) {
    final foodData = _mergeLogFoodJsonForModel(json);
    final foodModel = mapApiFoodToModel(foodData);
    final int? mealTemplateId = _mealTemplateIdFromLogJson(json);
    // Per-log macros on the row are final; do not rescale (meal logs have no nested food).
    final bool skipServingRescale = _logJsonHasMacroSnapshot(json);

    // Get servingSize and numberOfServings from log food item (if available)
    final double loggedServingSize = _parseLogDouble(
      json['servingSize'] ?? json['ServingSize'],
    );
    final double loggedNumberOfServings = _parseLogDouble(
      json['numberOfServings'] ?? json['NumberOfServings'],
    );

    // Parse loggedAt time from API response
    DateTime? loggedAt;
    if (json['loggedAt'] != null) {
      try {
        loggedAt = DateTime.parse(json['loggedAt'] as String).toLocal();
      } catch (e) {
        // If parsing fails, try LoggedAt (capital L)
        try {
          loggedAt = DateTime.parse(json['LoggedAt'] as String).toLocal();
        } catch (e) {
          loggedAt = null;
        }
      }
    } else if (json['LoggedAt'] != null) {
      try {
        loggedAt = DateTime.parse(json['LoggedAt'] as String).toLocal();
      } catch (e) {
        loggedAt = null;
      }
    }

    // If servingSize and numberOfServings are provided, recalculate nutrients
    // from catalog base — skip when API already sent per-log macro snapshot.
    if (!skipServingRescale &&
        loggedServingSize > 0 &&
        loggedNumberOfServings > 0) {
      // Find the unit index that matches the logged serving size
      int unitShowIndex = foodModel.unitSizes.indexWhere(
        (size) => (size - loggedServingSize).abs() < 0.001,
      );
      if (unitShowIndex == -1) {
        // If exact match not found, use the closest one or default to first
        unitShowIndex = 0;
      }

      // Get base serving size from food (the original serving size for nutrients)
      final double baseServingSize = foodModel.unitSizes.isNotEmpty
          ? foodModel.unitSizes[0] // Use first unit size as base
          : 1.0;

      // Calculate multiplier: (loggedServingSize * loggedNumberOfServings) / baseServingSize
      final double multiplier =
          (loggedServingSize * loggedNumberOfServings) / baseServingSize;

      // Save base nutrients (original nutrients before recalculation)
      final baseNutrients = Map<String, double>.from(foodModel.nutrients);

      // Recalculate all nutrients based on the multiplier
      final recalculatedNutrients = <String, double>{};
      foodModel.nutrients.forEach((key, value) {
        recalculatedNutrients[key] = value * multiplier;
      });

      // Return food model with recalculated nutrients and updated quantity/unit
      var out = foodModel.copyWith(
        unitShowIndex: unitShowIndex,
        quantity: loggedNumberOfServings,
        nutrients: recalculatedNutrients,
        baseNutrients: baseNutrients, // Save base nutrients for detail page
        loggedAt: loggedAt, // Save logged time for sorting
        mealTemplateId: mealTemplateId,
      );
      if (mealTemplateId != null) {
        out = _withMealTemplateUnits(out);
      }
      return out;
    }

    // Macro snapshot path: nutrients already match the log row; still expose servings.
    final double quantity = loggedNumberOfServings > 0
        ? loggedNumberOfServings
        : (foodModel.quantity > 0 ? foodModel.quantity : 1.0);

    var snapshotOut = foodModel.copyWith(
      loggedAt: loggedAt,
      quantity: quantity,
      mealTemplateId: mealTemplateId,
    );
    if (mealTemplateId != null) {
      snapshotOut = _withMealTemplateUnits(snapshotOut);
    }
    return snapshotOut;
  }

  static FoodModel mapApiFoodToModel(Map<String, dynamic> json) {
    double toDoubleValue(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      if (v is String) {
        final parsed = double.tryParse(v.trim());
        return parsed ?? 0.0;
      }
      return 0.0;
    }

    double? toDoubleOrNull(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) {
        final t = v.trim();
        if (t.isEmpty) return null;
        return double.tryParse(t.replaceAll(',', '.'));
      }
      return null;
    }

    /// Only add when JSON actually contains one of [keys] and the value parses to a number (including 0). Omits key when missing/null so UI can show "—".
    void putNutrientIfKeyPresent(
      Map<String, double> m,
      String nutrientKey,
      List<String> keys,
    ) {
      dynamic raw;
      var found = false;
      for (final k in keys) {
        if (json.containsKey(k)) {
          raw = json[k];
          found = true;
          break;
        }
      }
      if (!found) return;
      final v = toDoubleOrNull(raw);
      if (v == null) return;
      m[nutrientKey] = v;
    }

    int toIntValue(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v.trim()) ?? 0;
      return 0;
    }

    // Missing/0 servingSize (e.g. meal log snapshot) would show "0 serving"; default to 1.
    final double rawServingSize = toDoubleValue(
      json['servingSize'] ?? json['ServingSize'],
    );
    final double servingSize = rawServingSize > 0 ? rawServingSize : 1.0;
    var unitRaw =
        (json['servingUnit'] ?? json['ServingUnit'])?.toString().trim() ?? '';
    // Legacy rows may store full label "1 meal" in [unit] / servingUnit.
    final mealCompound = RegExp(
      r'^(\d+(?:\.\d+)?)\s+meal$',
      caseSensitive: false,
    ).firstMatch(unitRaw);
    if (mealCompound != null) {
      unitRaw = 'meal';
    }
    final String servingUnit = unitRaw.isNotEmpty ? unitRaw : 'serving';
    String formatServingLabelAmount(double d) {
      if ((d - d.round()).abs() < 1e-9) return d.round().toString();
      return d.toString();
    }

    final double servingsPerContainer = toDoubleValue(
      json['servingsPerContainer'] ??
          json['servingPerContainer'] ??
          json['servings_per_container'],
    );

    final List<String> units = [];
    final List<double> unitSizes = [];

    // Đơn vị gốc từ server
    units.add('${formatServingLabelAmount(servingSize)} $servingUnit');
    unitSizes.add(servingSize);

    // Đơn vị 1 <unit>
    units.add('1 $servingUnit');
    unitSizes.add(1.0);

    // Đơn vị 1 container
    if (servingsPerContainer > 0) {
      units.add('1 container');
      unitSizes.add(servingSize * servingsPerContainer);
    }

    final nutrients = <String, double>{};
    putNutrientIfKeyPresent(nutrients, NutrientKeys.caloriesKcal, [
      'calories',
      'Calories',
      'caloriesKcal',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.fatTotalG, [
      'totalFatG',
      'TotalFatG',
      'fat',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.fatSaturatedG, [
      'saturatedFatG',
      'SaturatedFatG',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.fatTransG, [
      'transFatG',
      'TransFatG',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.fatPolyunsatG, [
      'polyunsaturatedFatG',
      'PolyunsaturatedFatG',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.fatMonounsatG, [
      'monounsaturatedFatG',
      'MonounsaturatedFatG',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.cholesterolMg, [
      'cholesterolMg',
      'CholesterolMg',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.sodiumMg, [
      'sodiumMg',
      'SodiumMg',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.carbsTotalG, [
      'totalCarbohydratesG',
      'TotalCarbohydratesG',
      'carbs',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.fiberG, [
      'dietaryFibersG',
      'DietaryFibersG',
      'fiber',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.sugarsG, [
      'sugarsG',
      'SugarsG',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.proteinG, [
      'proteinG',
      'ProteinG',
      'protein',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.potassiumMg, [
      'potassiumMg',
      'PotassiumMg',
    ]);
    putNutrientIfKeyPresent(nutrients, NutrientKeys.vitaminAPercent, [
      'vitaminAPercent',
      'VitaminAPercent',
    ]);
    for (final field in AppNutrients.micronutrients) {
      putNutrientIfKeyPresent(nutrients, field.key, field.aliases);
    }

    // Calories thiếu hoặc = 0 nhưng có macro: ước lượng Atwater tổng quát (4/9/4 kcal/g).
    final existingCal = nutrients[NutrientKeys.caloriesKcal];
    final carbsG = nutrients[NutrientKeys.carbsTotalG] ?? 0.0;
    final fatG = nutrients[NutrientKeys.fatTotalG] ?? 0.0;
    final proteinG = nutrients[NutrientKeys.proteinG] ?? 0.0;
    final derivedKcal = carbsG * 4 + fatG * 9 + proteinG * 4;
    if ((existingCal == null || existingCal == 0) && derivedKcal > 0) {
      nutrients[NutrientKeys.caloriesKcal] = derivedKcal;
    }

    DateTime? createdAt;
    final dynamic createdAtValue = json['createdAt'] ?? json['CreatedAt'];
    if (createdAtValue is String && createdAtValue.isNotEmpty) {
      createdAt = DateTime.tryParse(createdAtValue)?.toLocal();
    }

    return FoodModel(
      id: toIntValue(json['id']),
      name:
          (json['foodName'] as String?) ??
          (json['description'] as String?) ??
          '',
      description:
          (json['brandName'] as String?) ??
          (json['category'] as String?) ??
          json['description'] as String?,
      brand: json['brandName'] as String?,
      servingPerContainer: servingsPerContainer,
      units: units,
      unitSizes: unitSizes,
      unitShowIndex: 0,
      quantity: 1,
      isVerified:
          (json['isVerified'] as bool?) ??
          (json['is_verified'] as bool?) ??
          false,
      nutrients: nutrients,
      createdAt: createdAt,
    );
  }

  static Map<String, dynamic> mapFoodToApiPayload(FoodModel food) {
    final int safeUnitIndex = food.unitSizes.isNotEmpty
        ? food.unitShowIndex.clamp(0, food.unitSizes.length - 1)
        : 0;
    final double servingSize = food.unitSizes.isNotEmpty
        ? food.unitSizes[safeUnitIndex]
        : 1.0;
    final String baseUnitLabel = food.units.isNotEmpty
        ? food.units[safeUnitIndex.clamp(0, food.units.length - 1)]
        : '1 serving';
    final List<String> parts = baseUnitLabel.trim().split(RegExp(r'\s+'));
    final bool firstTokenIsNumber =
        parts.isNotEmpty &&
        double.tryParse(parts.first.replaceAll(',', '.')) != null;
    final String servingUnit = parts.length > 1 && firstTokenIsNumber
        ? parts.sublist(1).join(' ')
        : (parts.isNotEmpty ? parts.join(' ') : 'serving');

    double nutrient(String key) => food.nutrients[key]?.toDouble() ?? 0.0;

    return {
      'brandName': food.description?.trim().isNotEmpty == true
          ? food.description
          : food.brand,
      'category': food.name,
      'description': food.name,
      'servingSize': servingSize,
      'servingUnit': servingUnit,
      'servingsPerContainer': food.servingPerContainer,
      'servingPerContainer': food.servingPerContainer,
      'calories': nutrient(NutrientKeys.caloriesKcal),
      'totalFatG': nutrient(NutrientKeys.fatTotalG),
      'saturatedFatG': nutrient(NutrientKeys.fatSaturatedG),
      'cholesterolMg': nutrient(NutrientKeys.cholesterolMg),
      'sodiumMg': nutrient(NutrientKeys.sodiumMg),
      'totalCarbohydratesG': nutrient(NutrientKeys.carbsTotalG),
      'dietaryFibersG': nutrient(NutrientKeys.fiberG),
      'sugarsG': nutrient(NutrientKeys.sugarsG),
      'proteinG': nutrient(NutrientKeys.proteinG),
      'potassiumMg': nutrient(NutrientKeys.potassiumMg),
      for (final field in AppNutrients.micronutrients)
        field.apiKey: nutrient(field.key),
    };
  }
}
