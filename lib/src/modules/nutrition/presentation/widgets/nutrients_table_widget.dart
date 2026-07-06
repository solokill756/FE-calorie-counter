import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/nutrition_data_entity.dart';
import '../application/nutrition_cubit/nutrition_cubit.dart';
import '../pages/nutrient_detail_page.dart';
import '../../../logfood/data/models/food_model.dart';
import '../../../auth/data/models/user_nutritional_threshold_model.dart';
import '../../../auth/presentation/application/cubit/user_profile_access.dart';

class NutrientsTableWidget extends StatelessWidget {
  final NutritionState state;

  const NutrientsTableWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Header row
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: Container()),
                Expanded(
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Goal',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Left',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),

          // Nutrient rows
          _buildNutrientRows(context),
        ],
      ),
    );
  }

  Widget _buildNutrientRows(BuildContext context) {
    final nutrients = _nutrientsForSelectedPeriod();
    final macros = state.weeklyData?.macros ?? const MacrosData();
    final userProfile = readServerProfile();
    final periodDays = _periodDayCount();

    final thresholds = userProfile?.nutritionalThresholds ?? const [];

    // Get macro goals from data, aligned with active thresholds when available.
    final proteinGoal =
        (macros.proteinGoal > 0
            ? macros.proteinGoal
            : (userProfile?.proteinGoalG ?? 111.0)) *
        periodDays;
    final carbsGoal =
        (_thresholdAmount(thresholds, 'carbs', useMax: true) ??
            (macros.carbsGoal > 0
                ? macros.carbsGoal
                : (userProfile?.carbsGoalG ?? 279.0))) *
        periodDays;
    final fatGoal =
        (_thresholdAmount(thresholds, 'fat', useMax: true) ??
            (macros.fatGoal > 0
                ? macros.fatGoal
                : (userProfile?.fatGoalG ?? 74.0))) *
        periodDays;

    // Calculate other nutrient goals based on daily calories
    final dailyCalories = userProfile?.resolvedDailyCalorieGoal() ?? 2220;

    // Fiber: 14g per 1000 calories (recommended)
    final fiberGoal =
        (_thresholdAmount(thresholds, 'fiber', useMax: false) ??
            (dailyCalories / 1000) * 14) *
        periodDays;

    final sugarGoal =
        (_thresholdAmount(thresholds, 'sugars', useMax: true) ??
            dailyCalories * 0.10 / 4) *
        periodDays;
    final saturatedFatGoal =
        (_thresholdAmount(thresholds, 'saturatedFat', useMax: true) ??
            dailyCalories * 0.10 / 9) *
        periodDays;
    final cholesterolGoal =
        (_thresholdAmount(thresholds, 'cholesterol', useMax: true) ?? 300.0) *
        periodDays;
    final sodiumGoal =
        (_thresholdAmount(thresholds, 'sodium', useMax: true) ?? 2300.0) *
        periodDays;
    final potassiumGoal =
        (_thresholdAmount(thresholds, 'potassium', useMax: false) ?? 3400.0) *
        periodDays;

    String formatValue(double value, String unit) {
      if (value == 0) return '0$unit';
      if (value < 1) return '${value.toStringAsFixed(1)}$unit';
      return '${value.round()}$unit';
    }

    String formatGoal(double value, String unit) {
      if (value >= 1000) {
        return '${(value / 1000).toStringAsFixed(1)}k$unit';
      }
      return '${value.round()}$unit';
    }

    String formatLeft(double avg, double goal, String unit) {
      final left = goal - avg;
      if (left <= 0) return '0$unit';
      return formatValue(left, unit);
    }

    return Column(
      children: [
        _buildNutrientRow(
          context,
          NutrientDisplayNames.proteinG.replaceAll(' (g)', ''),
          formatValue(nutrients.protein, 'g'),
          formatGoal(proteinGoal, 'g'),
          formatLeft(nutrients.protein, proteinGoal, 'g'),
        ),
        _buildNutrientRow(
          context,
          NutrientDisplayNames.carbsTotalG.replaceAll(' (g)', ''),
          formatValue(nutrients.carbohydrates, 'g'),
          formatGoal(carbsGoal, 'g'),
          formatLeft(nutrients.carbohydrates, carbsGoal, 'g'),
        ),
        _buildNutrientRow(
          context,
          NutrientDisplayNames.fiberG.replaceAll(' (g)', ''),
          formatValue(nutrients.fiber, 'g'),
          formatGoal(fiberGoal, 'g'),
          formatLeft(nutrients.fiber, fiberGoal, 'g'),
        ),
        _buildNutrientRow(
          context,
          NutrientDisplayNames.sugarsG.replaceAll('s (g)', ''),
          formatValue(nutrients.sugar, 'g'),
          formatGoal(sugarGoal, 'g'),
          formatLeft(nutrients.sugar, sugarGoal, 'g'),
        ),
        _buildNutrientRow(
          context,
          NutrientDisplayNames.fatTotalG.replaceAll(' (g)', ''),
          formatValue(nutrients.fat, 'g'),
          formatGoal(fatGoal, 'g'),
          formatLeft(nutrients.fat, fatGoal, 'g'),
        ),
        _buildNutrientRow(
          context,
          NutrientDisplayNames.fatSaturatedG.replaceAll(' (g)', ''),
          formatValue(nutrients.saturatedFat, 'g'),
          formatGoal(saturatedFatGoal, 'g'),
          formatLeft(nutrients.saturatedFat, saturatedFatGoal, 'g'),
        ),
        _buildNutrientRow(
          context,
          NutrientDisplayNames.cholesterolMg.replaceAll(' (mg)', ''),
          formatValue(nutrients.cholesterol, 'mg'),
          formatGoal(cholesterolGoal, 'mg'),
          formatLeft(nutrients.cholesterol, cholesterolGoal, 'mg'),
        ),
        _buildNutrientRow(
          context,
          NutrientDisplayNames.sodiumMg.replaceAll(' (mg)', ''),
          formatValue(nutrients.sodium, 'mg'),
          formatGoal(sodiumGoal, 'mg'),
          formatLeft(nutrients.sodium, sodiumGoal, 'mg'),
        ),
        _buildNutrientRow(
          context,
          NutrientDisplayNames.potassiumMg.replaceAll(' (mg)', ''),
          formatValue(nutrients.potassium, 'mg'),
          formatGoal(potassiumGoal, 'mg'),
          formatLeft(nutrients.potassium, potassiumGoal, 'mg'),
        ),
        for (final row
            in <({String name, String nutrientKey, double value, String unit})>[
              (
                name: 'Calcium',
                nutrientKey: 'calcium',
                value: nutrients.calcium,
                unit: 'mg',
              ),
              (
                name: 'Iron',
                nutrientKey: 'iron',
                value: nutrients.iron,
                unit: 'mg',
              ),
              (
                name: 'Magnesium',
                nutrientKey: 'magnesium',
                value: nutrients.magnesium,
                unit: 'mg',
              ),
              (
                name: 'Phosphorus',
                nutrientKey: 'phosphorus',
                value: nutrients.phosphorus,
                unit: 'mg',
              ),
              (
                name: 'Zinc',
                nutrientKey: 'zinc',
                value: nutrients.zinc,
                unit: 'mg',
              ),
              (
                name: 'Vitamin A',
                nutrientKey: 'vitaminA',
                value: nutrients.vitaminA,
                unit: 'mcg',
              ),
              (
                name: 'Vitamin C',
                nutrientKey: 'vitaminC',
                value: nutrients.vitaminC,
                unit: 'mg',
              ),
              (
                name: 'Vitamin D',
                nutrientKey: 'vitaminD',
                value: nutrients.vitaminD,
                unit: 'mcg',
              ),
              (
                name: 'Vitamin E',
                nutrientKey: 'vitaminE',
                value: nutrients.vitaminE,
                unit: 'mg',
              ),
              (
                name: 'Vitamin K',
                nutrientKey: 'vitaminK',
                value: nutrients.vitaminK,
                unit: 'mcg',
              ),
              (
                name: 'Vitamin B6',
                nutrientKey: 'vitaminB6',
                value: nutrients.vitaminB6,
                unit: 'mg',
              ),
              (
                name: 'Vitamin B12',
                nutrientKey: 'vitaminB12',
                value: nutrients.vitaminB12,
                unit: 'mcg',
              ),
              (
                name: 'Folate DFE',
                nutrientKey: 'folateDfe',
                value: nutrients.folateDfe,
                unit: 'mcg',
              ),
            ])
          _buildNutrientRow(
            context,
            row.name,
            formatValue(row.value, row.unit),
            _thresholdAmount(thresholds, row.nutrientKey, useMax: false) == null
                ? '--'
                : formatGoal(
                    _thresholdAmount(
                          thresholds,
                          row.nutrientKey,
                          useMax: false,
                        )! *
                        periodDays,
                    row.unit,
                  ),
            _thresholdAmount(thresholds, row.nutrientKey, useMax: false) == null
                ? '--'
                : formatLeft(
                    row.value,
                    _thresholdAmount(
                          thresholds,
                          row.nutrientKey,
                          useMax: false,
                        )! *
                        periodDays,
                    row.unit,
                  ),
          ),
      ],
    );
  }

  double? _thresholdAmount(
    List<UserNutritionalThreshold> thresholds,
    String nutrient, {
    required bool useMax,
  }) {
    final targetKey = _normalizeNutrientKey(nutrient);
    for (final threshold in thresholds) {
      final key = _normalizeNutrientKey(threshold.nutrient);
      if (key != targetKey) continue;

      final value = useMax ? threshold.maxAmount : threshold.minAmount;
      if (value != null && value > 0) return value;
    }
    return null;
  }

  String _normalizeNutrientKey(String? value) {
    final key = (value ?? '').trim().toLowerCase().replaceAll(
      RegExp('[^a-z0-9]'),
      '',
    );
    if (key == 'dietaryfiber' || key == 'dietaryfibers') return 'fiber';
    return key;
  }

  _DisplayedNutrients _nutrientsForSelectedPeriod() {
    final weeklyData = state.weeklyData;
    if (weeklyData == null || weeklyData.dailyData.isEmpty) {
      return const _DisplayedNutrients();
    }

    if (state.selectedPeriod == 'Day View') {
      final day = _selectedDayData(weeklyData.dailyData);
      final mealNutrients = _mealNutrientsTotal(day);
      final fallback = weeklyData.nutrients;

      return _DisplayedNutrients(
        protein: day.protein,
        carbohydrates: day.carbs,
        fiber: mealNutrients.fiber > 0 ? mealNutrients.fiber : fallback.fiber,
        sugar: mealNutrients.sugar > 0 ? mealNutrients.sugar : fallback.sugar,
        fat: day.fat,
        saturatedFat: mealNutrients.saturatedFat > 0
            ? mealNutrients.saturatedFat
            : fallback.saturatedFat,
        cholesterol: mealNutrients.cholesterol > 0
            ? mealNutrients.cholesterol
            : fallback.cholesterol,
        sodium: mealNutrients.sodium > 0
            ? mealNutrients.sodium
            : fallback.sodium,
        potassium: mealNutrients.potassium > 0
            ? mealNutrients.potassium
            : fallback.potassium,
        calcium: mealNutrients.calcium > 0
            ? mealNutrients.calcium
            : fallback.calcium,
        iron: mealNutrients.iron > 0 ? mealNutrients.iron : fallback.iron,
        magnesium: mealNutrients.magnesium > 0
            ? mealNutrients.magnesium
            : fallback.magnesium,
        phosphorus: mealNutrients.phosphorus > 0
            ? mealNutrients.phosphorus
            : fallback.phosphorus,
        zinc: mealNutrients.zinc > 0 ? mealNutrients.zinc : fallback.zinc,
        vitaminA: mealNutrients.vitaminA > 0
            ? mealNutrients.vitaminA
            : fallback.vitaminA,
        vitaminC: mealNutrients.vitaminC > 0
            ? mealNutrients.vitaminC
            : fallback.vitaminC,
        vitaminD: mealNutrients.vitaminD > 0
            ? mealNutrients.vitaminD
            : fallback.vitaminD,
        vitaminE: mealNutrients.vitaminE > 0
            ? mealNutrients.vitaminE
            : fallback.vitaminE,
        vitaminK: mealNutrients.vitaminK > 0
            ? mealNutrients.vitaminK
            : fallback.vitaminK,
        vitaminB6: mealNutrients.vitaminB6 > 0
            ? mealNutrients.vitaminB6
            : fallback.vitaminB6,
        vitaminB12: mealNutrients.vitaminB12 > 0
            ? mealNutrients.vitaminB12
            : fallback.vitaminB12,
        folateDfe: mealNutrients.folateDfe > 0
            ? mealNutrients.folateDfe
            : fallback.folateDfe,
      );
    }

    final mealTotals = weeklyData.dailyData.fold<NutrientsData>(
      const NutrientsData(),
      (sum, day) => _addNutrients(sum, _mealNutrientsTotal(day)),
    );
    final fallback = weeklyData.nutrients;

    return _DisplayedNutrients(
      protein: weeklyData.dailyData.fold<double>(
        0,
        (sum, day) => sum + day.protein,
      ),
      carbohydrates: weeklyData.dailyData.fold<double>(
        0,
        (sum, day) => sum + day.carbs,
      ),
      fiber: mealTotals.fiber > 0
          ? mealTotals.fiber
          : fallback.fiber * _periodDayCount(),
      sugar: mealTotals.sugar > 0
          ? mealTotals.sugar
          : fallback.sugar * _periodDayCount(),
      fat: weeklyData.dailyData.fold<double>(0, (sum, day) => sum + day.fat),
      saturatedFat: mealTotals.saturatedFat > 0
          ? mealTotals.saturatedFat
          : fallback.saturatedFat * _periodDayCount(),
      cholesterol: mealTotals.cholesterol > 0
          ? mealTotals.cholesterol
          : fallback.cholesterol * _periodDayCount(),
      sodium: mealTotals.sodium > 0
          ? mealTotals.sodium
          : fallback.sodium * _periodDayCount(),
      potassium: mealTotals.potassium > 0
          ? mealTotals.potassium
          : fallback.potassium * _periodDayCount(),
      calcium: mealTotals.calcium > 0
          ? mealTotals.calcium
          : fallback.calcium * _periodDayCount(),
      iron: mealTotals.iron > 0
          ? mealTotals.iron
          : fallback.iron * _periodDayCount(),
      magnesium: mealTotals.magnesium > 0
          ? mealTotals.magnesium
          : fallback.magnesium * _periodDayCount(),
      phosphorus: mealTotals.phosphorus > 0
          ? mealTotals.phosphorus
          : fallback.phosphorus * _periodDayCount(),
      zinc: mealTotals.zinc > 0
          ? mealTotals.zinc
          : fallback.zinc * _periodDayCount(),
      vitaminA: mealTotals.vitaminA > 0
          ? mealTotals.vitaminA
          : fallback.vitaminA * _periodDayCount(),
      vitaminC: mealTotals.vitaminC > 0
          ? mealTotals.vitaminC
          : fallback.vitaminC * _periodDayCount(),
      vitaminD: mealTotals.vitaminD > 0
          ? mealTotals.vitaminD
          : fallback.vitaminD * _periodDayCount(),
      vitaminE: mealTotals.vitaminE > 0
          ? mealTotals.vitaminE
          : fallback.vitaminE * _periodDayCount(),
      vitaminK: mealTotals.vitaminK > 0
          ? mealTotals.vitaminK
          : fallback.vitaminK * _periodDayCount(),
      vitaminB6: mealTotals.vitaminB6 > 0
          ? mealTotals.vitaminB6
          : fallback.vitaminB6 * _periodDayCount(),
      vitaminB12: mealTotals.vitaminB12 > 0
          ? mealTotals.vitaminB12
          : fallback.vitaminB12 * _periodDayCount(),
      folateDfe: mealTotals.folateDfe > 0
          ? mealTotals.folateDfe
          : fallback.folateDfe * _periodDayCount(),
    );
  }

  int _periodDayCount() {
    final dailyData = state.weeklyData?.dailyData;
    if (dailyData == null || dailyData.isEmpty) return 1;
    return state.selectedPeriod == 'Day View' ? 1 : dailyData.length;
  }

  DailyCalorieData _selectedDayData(List<DailyCalorieData> dailyData) {
    final selectedDate = DateTime(
      state.currentDate.year,
      state.currentDate.month,
      state.currentDate.day,
    );

    return dailyData.firstWhere(
      (day) =>
          day.date.year == selectedDate.year &&
          day.date.month == selectedDate.month &&
          day.date.day == selectedDate.day,
      orElse: () => dailyData.first,
    );
  }

  NutrientsData _mealNutrientsTotal(DailyCalorieData day) {
    return [
      day.breakfastNutrients,
      day.lunchNutrients,
      day.dinnerNutrients,
      day.snacksNutrients,
    ].fold<NutrientsData>(const NutrientsData(), _addNutrients);
  }

  NutrientsData _addNutrients(NutrientsData a, NutrientsData b) {
    return NutrientsData(
      protein: a.protein + b.protein,
      carbohydrates: a.carbohydrates + b.carbohydrates,
      fiber: a.fiber + b.fiber,
      sugar: a.sugar + b.sugar,
      fat: a.fat + b.fat,
      saturatedFat: a.saturatedFat + b.saturatedFat,
      polyunsaturatedFat: a.polyunsaturatedFat + b.polyunsaturatedFat,
      monounsaturatedFat: a.monounsaturatedFat + b.monounsaturatedFat,
      transFat: a.transFat + b.transFat,
      cholesterol: a.cholesterol + b.cholesterol,
      sodium: a.sodium + b.sodium,
      potassium: a.potassium + b.potassium,
      calcium: a.calcium + b.calcium,
      iron: a.iron + b.iron,
      magnesium: a.magnesium + b.magnesium,
      phosphorus: a.phosphorus + b.phosphorus,
      zinc: a.zinc + b.zinc,
      vitaminA: a.vitaminA + b.vitaminA,
      vitaminC: a.vitaminC + b.vitaminC,
      vitaminD: a.vitaminD + b.vitaminD,
      vitaminE: a.vitaminE + b.vitaminE,
      vitaminK: a.vitaminK + b.vitaminK,
      vitaminB6: a.vitaminB6 + b.vitaminB6,
      vitaminB12: a.vitaminB12 + b.vitaminB12,
      folateDfe: a.folateDfe + b.folateDfe,
    );
  }

  Widget _buildNutrientRow(
    BuildContext context,
    String name,
    String avg,
    String goal,
    String left,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NutrientDetailPage(
              nutrientName: name,
              initialDate: state.currentDate,
              initialPeriod: state.selectedPeriod,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.chevron_right,
                    size: 18.sp,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                avg,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Text(
                goal,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Text(
                left,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DisplayedNutrients {
  final double protein;
  final double carbohydrates;
  final double fiber;
  final double sugar;
  final double fat;
  final double saturatedFat;
  final double cholesterol;
  final double sodium;
  final double potassium;
  final double calcium;
  final double iron;
  final double magnesium;
  final double phosphorus;
  final double zinc;
  final double vitaminA;
  final double vitaminC;
  final double vitaminD;
  final double vitaminE;
  final double vitaminK;
  final double vitaminB6;
  final double vitaminB12;
  final double folateDfe;

  const _DisplayedNutrients({
    this.protein = 0,
    this.carbohydrates = 0,
    this.fiber = 0,
    this.sugar = 0,
    this.fat = 0,
    this.saturatedFat = 0,
    this.cholesterol = 0,
    this.sodium = 0,
    this.potassium = 0,
    this.calcium = 0,
    this.iron = 0,
    this.magnesium = 0,
    this.phosphorus = 0,
    this.zinc = 0,
    this.vitaminA = 0,
    this.vitaminC = 0,
    this.vitaminD = 0,
    this.vitaminE = 0,
    this.vitaminK = 0,
    this.vitaminB6 = 0,
    this.vitaminB12 = 0,
    this.folateDfe = 0,
  });
}
