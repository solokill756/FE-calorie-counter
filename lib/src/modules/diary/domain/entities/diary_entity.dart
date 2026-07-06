import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_entity.freezed.dart';
part 'diary_entity.g.dart';

@freezed
class DiaryEntity with _$DiaryEntity {
  const factory DiaryEntity({
    required DateTime date,
    required int caloriesGoal,
    required int caloriesConsumed,
    required int caloriesBurned,
    required double carbsConsumed,
    required double proteinConsumed,
    required double fatConsumed,

    /// Sum of sodium for the day from diary API (`totalSodiumMg`), mg.
    @Default(0.0) double sodiumConsumedMg,

    /// Sum of dietary fiber from diary API (`totalDietaryFibersG`), g.
    @Default(0.0) double fiberConsumedG,
    @Default(0.0) double sugarConsumedG,
    @Default(0.0) double saturatedFatConsumedG,
    @Default(0.0) double cholesterolConsumedMg,
    @Default(0.0) double potassiumConsumedMg,

    // ── 13 micronutrient totals ──
    /// Sum of calcium for the day from diary API (`totalCalciumMg`), mg.
    @Default(0.0) double totalCalciumMg,
    /// Sum of iron for the day from diary API (`totalIronMg`), mg.
    @Default(0.0) double totalIronMg,
    /// Sum of magnesium for the day from diary API (`totalMagnesiumMg`), mg.
    @Default(0.0) double totalMagnesiumMg,
    /// Sum of phosphorus for the day from diary API (`totalPhosphorusMg`), mg.
    @Default(0.0) double totalPhosphorusMg,
    /// Sum of zinc for the day from diary API (`totalZincMg`), mg.
    @Default(0.0) double totalZincMg,
    /// Sum of vitamin A for the day from diary API (`totalVitaminAUg`), µg.
    @Default(0.0) double totalVitaminAUg,
    /// Sum of vitamin C for the day from diary API (`totalVitaminCMg`), mg.
    @Default(0.0) double totalVitaminCMg,
    /// Sum of vitamin D for the day from diary API (`totalVitaminDUg`), µg.
    @Default(0.0) double totalVitaminDUg,
    /// Sum of vitamin E for the day from diary API (`totalVitaminEMg`), mg.
    @Default(0.0) double totalVitaminEMg,
    /// Sum of vitamin K for the day from diary API (`totalVitaminKUg`), µg.
    @Default(0.0) double totalVitaminKUg,
    /// Sum of vitamin B6 for the day from diary API (`totalVitaminB6Mg`), mg.
    @Default(0.0) double totalVitaminB6Mg,
    /// Sum of vitamin B12 for the day from diary API (`totalVitaminB12Ug`), µg.
    @Default(0.0) double totalVitaminB12Ug,
    /// Sum of folate DFE for the day from diary API (`totalFolateDfeUg`), µg.
    @Default(0.0) double totalFolateDfeUg,

    required List<FoodEntry> breakfast,
    required List<FoodEntry> lunch,
    required List<FoodEntry> dinner,
    required List<FoodEntry> snacks,
    required List<ExerciseEntry> exercises,
    required int waterGlasses,
    @Default(0) int waterAmountMl,
    @Default(2500) int waterTargetMl,
    required bool isFasting,
    @Default(false) bool isCompleted,
    String? note,
    DateTime? fastingStartTime,
    DateTime? fastingEndTime,
  }) = _DiaryEntity;

  const DiaryEntity._();

  factory DiaryEntity.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntityFromJson(json);

  int get caloriesRemaining => caloriesGoal - caloriesConsumed + caloriesBurned;

  /// Remove a food entry from the specified meal and recalculate totals
  DiaryEntity removeFoodEntry(String mealType, String foodId) {
    List<FoodEntry> updatedBreakfast = breakfast;
    List<FoodEntry> updatedLunch = lunch;
    List<FoodEntry> updatedDinner = dinner;
    List<FoodEntry> updatedSnacks = snacks;

    FoodEntry? removedEntry;

    // Remove from the appropriate meal list
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        final index = updatedBreakfast.indexWhere((e) => e.id == foodId);
        if (index == -1) return this;
        removedEntry = updatedBreakfast[index];
        updatedBreakfast = updatedBreakfast.where((e) => e.id != foodId).toList();
        break;
      case 'lunch':
        final index = updatedLunch.indexWhere((e) => e.id == foodId);
        if (index == -1) return this;
        removedEntry = updatedLunch[index];
        updatedLunch = updatedLunch.where((e) => e.id != foodId).toList();
        break;
      case 'dinner':
        final index = updatedDinner.indexWhere((e) => e.id == foodId);
        if (index == -1) return this;
        removedEntry = updatedDinner[index];
        updatedDinner = updatedDinner.where((e) => e.id != foodId).toList();
        break;
      case 'snacks':
      case 'snack':
        final index = updatedSnacks.indexWhere((e) => e.id == foodId);
        if (index == -1) return this;
        removedEntry = updatedSnacks[index];
        updatedSnacks = updatedSnacks.where((e) => e.id != foodId).toList();
        break;
      default:
        return this;
    }

    // Helper to subtract a nutrient value with floor-at-zero clamping
    double _sub(double total, double entry) =>
        (total - entry).clamp(0.0, double.infinity);

    // Recalculate totals by subtracting the removed entry's values
    final newCaloriesConsumed = _sub(caloriesConsumed.toDouble(), removedEntry.calories.toDouble()).toInt();
    final newCarbsConsumed = _sub(carbsConsumed, removedEntry.carbs);
    final newProteinConsumed = _sub(proteinConsumed, removedEntry.protein);
    final newFatConsumed = _sub(fatConsumed, removedEntry.fat);
    final newSodium = _sub(sodiumConsumedMg, removedEntry.sodiumMg);
    final newFiber = _sub(fiberConsumedG, removedEntry.fiberG);
    final newSugar = _sub(sugarConsumedG, removedEntry.sugarG);
    final newSaturatedFat = _sub(saturatedFatConsumedG, removedEntry.saturatedFatG);
    final newCholesterol = _sub(cholesterolConsumedMg, removedEntry.cholesterolMg);
    final newPotassium = _sub(potassiumConsumedMg, removedEntry.potassiumMg);
    final newCalcium = _sub(totalCalciumMg, removedEntry.calciumMg);
    final newIron = _sub(totalIronMg, removedEntry.ironMg);
    final newMagnesium = _sub(totalMagnesiumMg, removedEntry.magnesiumMg);
    final newPhosphorus = _sub(totalPhosphorusMg, removedEntry.phosphorusMg);
    final newZinc = _sub(totalZincMg, removedEntry.zincMg);
    final newVitaminA = _sub(totalVitaminAUg, removedEntry.vitaminAUg);
    final newVitaminC = _sub(totalVitaminCMg, removedEntry.vitaminCMg);
    final newVitaminD = _sub(totalVitaminDUg, removedEntry.vitaminDUg);
    final newVitaminE = _sub(totalVitaminEMg, removedEntry.vitaminEMg);
    final newVitaminK = _sub(totalVitaminKUg, removedEntry.vitaminKUg);
    final newVitaminB6 = _sub(totalVitaminB6Mg, removedEntry.vitaminB6Mg);
    final newVitaminB12 = _sub(totalVitaminB12Ug, removedEntry.vitaminB12Ug);
    final newFolate = _sub(totalFolateDfeUg, removedEntry.folateDfeUg);

    return copyWith(
      breakfast: updatedBreakfast,
      lunch: updatedLunch,
      dinner: updatedDinner,
      snacks: updatedSnacks,
      caloriesConsumed: newCaloriesConsumed,
      carbsConsumed: newCarbsConsumed,
      proteinConsumed: newProteinConsumed,
      fatConsumed: newFatConsumed,
      sodiumConsumedMg: newSodium,
      fiberConsumedG: newFiber,
      sugarConsumedG: newSugar,
      saturatedFatConsumedG: newSaturatedFat,
      cholesterolConsumedMg: newCholesterol,
      potassiumConsumedMg: newPotassium,
      totalCalciumMg: newCalcium,
      totalIronMg: newIron,
      totalMagnesiumMg: newMagnesium,
      totalPhosphorusMg: newPhosphorus,
      totalZincMg: newZinc,
      totalVitaminAUg: newVitaminA,
      totalVitaminCMg: newVitaminC,
      totalVitaminDUg: newVitaminD,
      totalVitaminEMg: newVitaminE,
      totalVitaminKUg: newVitaminK,
      totalVitaminB6Mg: newVitaminB6,
      totalVitaminB12Ug: newVitaminB12,
      totalFolateDfeUg: newFolate,
    );
  }
}

@freezed
class FoodEntry with _$FoodEntry {
  const factory FoodEntry({
    required String id,
    required String name,
    required int calories,
    required double quantity,
    required String unit,
    @Default(0.0) double carbs,
    @Default(0.0) double protein,
    @Default(0.0) double fat,
    @Default(0.0) double sodiumMg,
    @Default(0.0) double fiberG,
    @Default(0.0) double sugarG,
    @Default(0.0) double saturatedFatG,
    @Default(0.0) double cholesterolMg,
    @Default(0.0) double potassiumMg,
    // ── 13 micronutrients ──
    @Default(0.0) double calciumMg,
    @Default(0.0) double ironMg,
    @Default(0.0) double magnesiumMg,
    @Default(0.0) double phosphorusMg,
    @Default(0.0) double zincMg,
    @Default(0.0) double vitaminAUg,
    @Default(0.0) double vitaminCMg,
    @Default(0.0) double vitaminDUg,
    @Default(0.0) double vitaminEMg,
    @Default(0.0) double vitaminKUg,
    @Default(0.0) double vitaminB6Mg,
    @Default(0.0) double vitaminB12Ug,
    @Default(0.0) double folateDfeUg,
  }) = _FoodEntry;

  factory FoodEntry.fromJson(Map<String, dynamic> json) =>
      _$FoodEntryFromJson(json);
}

@freezed
class ExerciseEntry with _$ExerciseEntry {
  const factory ExerciseEntry({
    required String id,
    required String name,
    required int caloriesBurned,
    required int duration, // in minutes
  }) = _ExerciseEntry;

  factory ExerciseEntry.fromJson(Map<String, dynamic> json) =>
      _$ExerciseEntryFromJson(json);
}
