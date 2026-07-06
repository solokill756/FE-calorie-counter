import 'package:caloriecounter/src/modules/nutrition/data/services/daily_nutrition_calculation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/presentation/application/cubit/user_profile_access.dart';
import '../../../logfood/data/models/log_food_model.dart';
import '../../domain/entities/nutrition_data_entity.dart';
import '../../domain/repository/nutrition_repository.dart';
import '../helpers/date_helper.dart';
import '../helpers/nutrition_date_range.dart';
import '../services/api/nutrition_api_service.dart';
import '../services/nutrient_aggregation_service.dart';

@LazySingleton(as: NutritionRepository)
class NutritionRepositoryImpl implements NutritionRepository {
  final NutritionApiService _apiService;
  final NutrientAggregationService _nutrientAggregationService;
  final DailyNutritionCalculationService _dailyCalculationService;

  NutritionRepositoryImpl(
    this._apiService,
    this._nutrientAggregationService,
    this._dailyCalculationService,
  );

  @override
  Future<WeeklyNutritionData> getDailyData(DateTime date) async {
    return _getDataForRange(
      NutritionDateRangeHelper.forPeriod(
        date,
        NutritionDateRangeHelper.dayView,
      ),
    );
  }

  @override
  Future<WeeklyNutritionData> getWeeklyData(DateTime endDate) async {
    return _getDataForRange(
      NutritionDateRangeHelper.forPeriod(
        endDate,
        NutritionDateRangeHelper.weekView,
      ),
    );
  }

  @override
  Future<WeeklyNutritionData> getMonthlyData(DateTime endDate) async {
    return _getDataForRange(
      NutritionDateRangeHelper.forPeriod(
        endDate,
        NutritionDateRangeHelper.monthView,
      ),
    );
  }

  Future<WeeklyNutritionData> _getDataForRange(NutritionDateRange range) async {
    try {
      final userProfile = readServerProfile();
      final dailyCalorieGoal = userProfile?.resolvedDailyCalorieGoal() ?? 2220;
      final goalForRange = dailyCalorieGoal * range.dayCount;

      final diaryRows = await _apiService.fetchDiaryRange(
        startDate: range.startApi,
        endDate: range.endApi,
      );
      final logItems = await _apiService.fetchLogFoodsFromApi(
        startDate: range.startApi,
        endDate: range.endApi,
        page: 1,
        pageSize: 1000,
        includeQuickAdd: true,
      );

      final diaryByDate = <String, Map<String, dynamic>>{};
      for (final row in diaryRows) {
        final dateKey = _dateKeyFromDiaryRow(row);
        if (dateKey == null) continue;
        diaryByDate[dateKey] = row;
      }

      final foodsByDate = <String, List<Map<String, dynamic>>>{};
      for (final item in logItems) {
        final dateKey = _dateKeyFromLogItem(item);
        if (dateKey == null) continue;
        foodsByDate.putIfAbsent(dateKey, () => []).add(item);
      }

      final dailyData = <DailyCalorieData>[];
      var totalNetCalories = 0.0;
      var totalCarbs = 0.0;
      var totalFat = 0.0;
      var totalProtein = 0.0;
      var totalSodium = 0.0;
      var totalFiber = 0.0;
      var totalSugar = 0.0;
      var totalSaturatedFat = 0.0;
      var totalCholesterol = 0.0;
      var totalPotassium = 0.0;

      for (int i = 0; i < range.dayCount; i++) {
        final currentDate = range.start.add(Duration(days: i));
        final dateKey = DateHelper.formatDateKey(currentDate);
        final diary = diaryByDate[dateKey];
        final dayFoods = foodsByDate[dateKey] ?? const <Map<String, dynamic>>[];
        final logBreakdown = _dailyCalculationService.calculateDailyData(
          date: currentDate,
          dayFoods: dayFoods,
          dailyGoal: dailyCalorieGoal.toDouble(),
        );
        final dayCalories = _number(diary, ['totalCalories']);
        final exerciseBurned = _number(diary, ['exerciseCaloriesBurned']);
        final dayCarbs = _number(diary, ['totalCarbs']);
        final dayFat = _number(diary, ['totalFat']);
        final dayProtein = _number(diary, ['totalProtein']);
        final daySodium = _number(diary, ['totalSodiumMg']);
        final dayFiber = _number(diary, ['totalDietaryFibersG']);
        final daySugar = _number(diary, ['totalSugarsG']);
        final daySaturatedFat = _number(diary, ['totalSaturatedFatG']);
        final dayCholesterol = _number(diary, ['totalCholesterolMg']);
        final dayPotassium = _number(diary, ['totalPotassiumMg']);
        final netCalories = dayCalories - exerciseBurned;

        final dailyCalorieData = DailyCalorieData(
          date: currentDate,
          totalCalories: dayCalories,
          netCalories: netCalories,
          goal: dailyCalorieGoal.toDouble(),
          dayLabel: DateHelper.getDayLabel(currentDate),
          breakfastCalories: logBreakdown.breakfastCalories,
          lunchCalories: logBreakdown.lunchCalories,
          dinnerCalories: logBreakdown.dinnerCalories,
          snacksCalories: logBreakdown.snacksCalories,
          carbs: dayCarbs,
          fat: dayFat,
          protein: dayProtein,
          breakfastNutrients: logBreakdown.breakfastNutrients,
          lunchNutrients: logBreakdown.lunchNutrients,
          dinnerNutrients: logBreakdown.dinnerNutrients,
          snacksNutrients: logBreakdown.snacksNutrients,
        );

        totalNetCalories += netCalories;
        totalCarbs += dayCarbs;
        totalFat += dayFat;
        totalProtein += dayProtein;
        totalSodium += daySodium;
        totalFiber += dayFiber;
        totalSugar += daySugar;
        totalSaturatedFat += daySaturatedFat;
        totalCholesterol += dayCholesterol;
        totalPotassium += dayPotassium;
        dailyData.add(dailyCalorieData);
      }

      final totalNutrients = _dailyCalculationService.calculateTotalNutrients(
        logItems,
      );
      final days = range.dayCount == 0 ? 1 : range.dayCount;
      final nutrients = NutrientsData(
        protein: totalProtein / days,
        carbohydrates: totalCarbs / days,
        fiber: totalFiber / days,
        sugar:
            (totalSugar > 0 ? totalSugar : totalNutrients['sugar'] ?? 0.0) /
            days,
        fat: totalFat / days,
        saturatedFat:
            (totalSaturatedFat > 0
                ? totalSaturatedFat
                : totalNutrients['saturatedFat'] ?? 0.0) /
            days,
        polyunsaturatedFat:
            (totalNutrients['polyunsaturatedFat'] ?? 0.0) / days,
        monounsaturatedFat:
            (totalNutrients['monounsaturatedFat'] ?? 0.0) / days,
        transFat: (totalNutrients['transFat'] ?? 0.0) / days,
        cholesterol:
            (totalCholesterol > 0
                ? totalCholesterol
                : totalNutrients['cholesterol'] ?? 0.0) /
            days,
        sodium: totalSodium / days,
        potassium:
            (totalPotassium > 0
                ? totalPotassium
                : totalNutrients['potassium'] ?? 0.0) /
            days,
        vitaminA: (totalNutrients['vitaminA'] ?? 0.0) / days,
        calcium: (totalNutrients['calcium'] ?? 0.0) / days,
        iron: (totalNutrients['iron'] ?? 0.0) / days,
        magnesium: (totalNutrients['magnesium'] ?? 0.0) / days,
        phosphorus: (totalNutrients['phosphorus'] ?? 0.0) / days,
        zinc: (totalNutrients['zinc'] ?? 0.0) / days,
        vitaminC: (totalNutrients['vitaminC'] ?? 0.0) / days,
        vitaminD: (totalNutrients['vitaminD'] ?? 0.0) / days,
        vitaminE: (totalNutrients['vitaminE'] ?? 0.0) / days,
        vitaminK: (totalNutrients['vitaminK'] ?? 0.0) / days,
        vitaminB6: (totalNutrients['vitaminB6'] ?? 0.0) / days,
        vitaminB12: (totalNutrients['vitaminB12'] ?? 0.0) / days,
        folateDfe: (totalNutrients['folateDfe'] ?? 0.0) / days,
      );

      return WeeklyNutritionData(
        dailyData: dailyData,
        weeklyGoal: goalForRange.toDouble(),
        netAverage: totalNetCalories / days,
        netCaloriesUnderGoal: goalForRange.toDouble() - totalNetCalories,
        nutrients: nutrients,
        macros: MacrosData(
          carbs: totalCarbs / days,
          fat: totalFat / days,
          protein: totalProtein / days,
          carbsGoal: userProfile?.carbsGoalG ?? 0.0,
          fatGoal: userProfile?.fatGoalG ?? 0.0,
          proteinGoal: userProfile?.proteinGoalG ?? 0.0,
          carbsGoalPercent: userProfile?.macroCarbsPercent ?? 0.0,
          fatGoalPercent: userProfile?.macroFatPercent ?? 0.0,
          proteinGoalPercent: userProfile?.macroProteinPercent ?? 0.0,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('NutritionRepository: Error fetching nutrition data: $e');
      }
      rethrow;
    }
  }

  String? _dateKeyFromLogItem(Map<String, dynamic> item) {
    final value =
        item['loggedAt'] ??
        item['LoggedAt'] ??
        item['loggedOn'] ??
        item['logged_on'] ??
        item['date'];
    if (value is String && value.length >= 10) {
      return value.substring(0, 10);
    }
    return null;
  }

  String? _dateKeyFromDiaryRow(Map<String, dynamic> item) {
    final value = item['date'] ?? item['Date'];
    if (value is String && value.length >= 10) {
      return value.substring(0, 10);
    }
    return null;
  }

  double _number(Map<String, dynamic>? item, List<String> keys) {
    if (item == null) return 0.0;
    for (final key in keys) {
      final value = item[key];
      if (value is num) return value.toDouble();
      if (value is String) {
        final parsed = double.tryParse(value.trim());
        if (parsed != null) return parsed;
      }
    }
    return 0.0;
  }

  @override
  Future<List<String>> getFoodsHighestInCalories(
    List<LogFoodModel> logFoods,
  ) async {
    return _nutrientAggregationService.getTopFoodsByCalories(logFoods);
  }

  @override
  Future<List<String>> getFoodsHighestInCarbohydrates(
    List<LogFoodModel> logFoods,
  ) async {
    return _nutrientAggregationService.getTopFoodsByCarbohydrates(logFoods);
  }

  @override
  Future<List<String>> getFoodsHighestInFat(List<LogFoodModel> logFoods) async {
    return _nutrientAggregationService.getTopFoodsByFat(logFoods);
  }

  @override
  Future<List<String>> getFoodsHighestInProtein(
    List<LogFoodModel> logFoods,
  ) async {
    return _nutrientAggregationService.getTopFoodsByProtein(logFoods);
  }

  @override
  Future<List<String>> getFoodsHighestInNutrient(
    List<LogFoodModel> logFoods,
    String nutrientKey,
    String unit,
    int? limit,
  ) async {
    return _nutrientAggregationService.getTopFoodsByNutrient(
      logFoods,
      nutrientKey,
      unit,
      limit: limit,
    );
  }
}
