import 'package:caloriecounter/src/core/data/remote/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/data/remote/base/api_error.dart';
import '../../../../core/data/remote/base/api_response.dart';
import '../../domain/entities/diary_entity.dart';
import '../../domain/repository/diary_repository.dart';
import '../../../../core/data/local/storage.dart';
import '../../../auth/presentation/application/cubit/user_profile_access.dart';

double _diaryParseDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  if (v is String) {
    final t = v.trim();
    if (t.isEmpty) return 0.0;
    return double.tryParse(t) ?? 0.0;
  }
  return 0.0;
}

@LazySingleton(as: DiaryRepository)
class DiaryRepositoryImpl implements DiaryRepository {
  final Dio _dio;

  DiaryRepositoryImpl(this._dio);

  @override
  Future<DiaryEntity> getDiaryForDate(DateTime date) async {
    final formattedDate = _formatDateForApi(date.toLocal());

    try {
      final response = await _dio.get(
        'api/Diary/$formattedDate',
        options: Options(headers: {'accept': 'text/plain'}),
      );
      final data = response.data as Map<String, dynamic>;

      final userProfile = readServerProfile();
      final apiTarget = (data['targetCalories'] as num?)?.toInt();
      final calorieGoal = (apiTarget != null && apiTarget > 0)
          ? apiTarget
          : (userProfile?.resolvedDailyCalorieGoal() ?? 2300);

      final diaryDate =
          DateTime.tryParse(data['date']?.toString() ?? '') ?? date.toLocal();
      final totalCalories = (data['totalCalories'] as num?)?.toInt() ?? 0;
      final totalProtein = (data['totalProtein'] as num?)?.toDouble() ?? 0.0;
      final totalCarbs = (data['totalCarbs'] as num?)?.toDouble() ?? 0.0;
      final totalFat = (data['totalFat'] as num?)?.toDouble() ?? 0.0;
      final totalSodiumMg = _diaryParseDouble(data['totalSodiumMg']);
      final totalDietaryFibersG = _diaryParseDouble(
        data['totalDietaryFibersG'],
      );
      final totalSugarsG = _diaryParseDouble(data['totalSugarsG']);
      final totalSaturatedFatG = _diaryParseDouble(data['totalSaturatedFatG']);
      final totalCholesterolMg = _diaryParseDouble(data['totalCholesterolMg']);
      final totalPotassiumMg = _diaryParseDouble(data['totalPotassiumMg']);

      // ── 13 micronutrient totals ──
      final totalCalciumMg = _diaryParseDouble(data['totalCalciumMg']);
      final totalIronMg = _diaryParseDouble(data['totalIronMg']);
      final totalMagnesiumMg = _diaryParseDouble(data['totalMagnesiumMg']);
      final totalPhosphorusMg = _diaryParseDouble(data['totalPhosphorusMg']);
      final totalZincMg = _diaryParseDouble(data['totalZincMg']);
      final totalVitaminAUg = _diaryParseDouble(data['totalVitaminAUg']);
      final totalVitaminCMg = _diaryParseDouble(data['totalVitaminCMg']);
      final totalVitaminDUg = _diaryParseDouble(data['totalVitaminDUg']);
      final totalVitaminEMg = _diaryParseDouble(data['totalVitaminEMg']);
      final totalVitaminKUg = _diaryParseDouble(data['totalVitaminKUg']);
      final totalVitaminB6Mg = _diaryParseDouble(data['totalVitaminB6Mg']);
      final totalVitaminB12Ug = _diaryParseDouble(data['totalVitaminB12Ug']);
      final totalFolateDfeUg = _diaryParseDouble(data['totalFolateDfeUg']);

      final isCompleted = data['isCompleted'] as bool? ?? false;

      final exerciseBurned =
          (data['exerciseCaloriesBurned'] as num?)?.toInt() ?? 0;
      final exercisesRaw = data['exercises'] as List<dynamic>? ?? [];
      final exercises = exercisesRaw
          .map((e) => ExerciseEntry.fromJson(e as Map<String, dynamic>))
          .toList();

      final List<FoodEntry> breakfast = [];
      final List<FoodEntry> lunch = [];
      final List<FoodEntry> dinner = [];
      final List<FoodEntry> snacks = [];

      final mealGroups = (data['mealGroups'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();

      for (final mealGroup in mealGroups) {
        final mealType =
            (mealGroup['mealType'] as String?)?.toLowerCase() ?? 'breakfast';
        final logs = (mealGroup['logs'] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>();
        final entries = logs.map(_mapLogToFoodEntry).toList();

        switch (mealType) {
          case 'breakfast':
            breakfast.addAll(entries);
            break;
          case 'lunch':
            lunch.addAll(entries);
            break;
          case 'dinner':
            dinner.addAll(entries);
            break;
          case 'snack':
          case 'snacks':
            snacks.addAll(entries);
            break;
          default:
            breakfast.addAll(entries);
        }
      }

      final waterLog = data['waterLog'] as Map<String, dynamic>?;
      final amountMl = (waterLog?['amountMl'] as num?)?.toInt() ?? 0;
      final targetMl = (waterLog?['targetMl'] as num?)?.toInt() ?? 2500;
      final waterGlasses = (amountMl / 250).round();

      return DiaryEntity(
        date: diaryDate,
        caloriesGoal: calorieGoal,
        caloriesConsumed: totalCalories,
        caloriesBurned: exerciseBurned,
        carbsConsumed: totalCarbs,
        proteinConsumed: totalProtein,
        fatConsumed: totalFat,
        sodiumConsumedMg: totalSodiumMg,
        fiberConsumedG: totalDietaryFibersG,
        sugarConsumedG: totalSugarsG,
        saturatedFatConsumedG: totalSaturatedFatG,
        cholesterolConsumedMg: totalCholesterolMg,
        potassiumConsumedMg: totalPotassiumMg,
        totalCalciumMg: totalCalciumMg,
        totalIronMg: totalIronMg,
        totalMagnesiumMg: totalMagnesiumMg,
        totalPhosphorusMg: totalPhosphorusMg,
        totalZincMg: totalZincMg,
        totalVitaminAUg: totalVitaminAUg,
        totalVitaminCMg: totalVitaminCMg,
        totalVitaminDUg: totalVitaminDUg,
        totalVitaminEMg: totalVitaminEMg,
        totalVitaminKUg: totalVitaminKUg,
        totalVitaminB6Mg: totalVitaminB6Mg,
        totalVitaminB12Ug: totalVitaminB12Ug,
        totalFolateDfeUg: totalFolateDfeUg,
        breakfast: breakfast,
        lunch: lunch,
        dinner: dinner,
        snacks: snacks,
        exercises: exercises,
        waterGlasses: waterGlasses,
        waterAmountMl: amountMl,
        waterTargetMl: targetMl,
        isFasting: false,
        isCompleted: isCompleted,
        note: (data['note'] as String?)?.trim(),
      );
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;

      String detail = e.message ?? 'Unexpected error';
      if (responseData is Map<String, dynamic>) {
        detail =
            (responseData['detail'] as String?) ??
            (responseData['title'] as String?) ??
            (responseData['message'] as String?) ??
            detail;
      }

      throw Exception('Diary API error (${statusCode ?? 'unknown'}): $detail');
    }
  }

  FoodEntry _mapLogToFoodEntry(Map<String, dynamic> log) {
    final id = (log['id'] as num?)?.toInt().toString() ?? '';

    final food = log['food'] as Map<String, dynamic>?;
    final loggedMeal = log['loggedMeal'] as Map<String, dynamic>?;
    final loggedRecipe = log['loggedRecipe'] as Map<String, dynamic>?;

    final fromDesc = (food?['description'] as String?)?.trim();
    final fromLogName = (log['foodName'] as String?)?.trim();
    final foodName = (fromDesc != null && fromDesc.isNotEmpty)
        ? fromDesc
        : (fromLogName != null && fromLogName.isNotEmpty)
        ? fromLogName
        : (food?['brandName'] as String?) ??
              (loggedMeal?['name'] as String?) ??
              (loggedRecipe?['title'] as String?) ??
              'Food';

    final servings = _diaryParseDouble(
      log['numberOfServings'] ?? log['NumberOfServings'],
    );
    final servingSize = _diaryParseDouble(
      log['servingSize'] ?? log['ServingSize'],
    );
    final quantity = servings > 0 ? servings : servingSize;
    final unit =
        (log['unit'] as String?) ??
        (food?['servingUnit'] as String?) ??
        'serving';

    return FoodEntry(
      id: id,
      name: foodName,
      calories: _diaryParseDouble(log['calories']).round(),
      quantity: quantity <= 0 ? 1.0 : quantity,
      unit: unit,
      carbs: _diaryParseDouble(log['totalCarbohydratesG']),
      protein: _diaryParseDouble(log['proteinG']),
      fat: _diaryParseDouble(log['totalFatG']),
      sodiumMg: _diaryParseDouble(log['sodiumMg'] ?? log['SodiumMg']),
      fiberG: _diaryParseDouble(log['dietaryFibersG'] ?? log['DietaryFibersG']),
      sugarG: _diaryParseDouble(log['sugarsG']),
      saturatedFatG: _diaryParseDouble(log['saturatedFatG']),
      cholesterolMg: _diaryParseDouble(log['cholesterolMg']),
      potassiumMg: _diaryParseDouble(log['potassiumMg']),
      calciumMg: _diaryParseDouble(log['calciumMg']),
      ironMg: _diaryParseDouble(log['ironMg']),
      magnesiumMg: _diaryParseDouble(log['magnesiumMg']),
      phosphorusMg: _diaryParseDouble(log['phosphorusMg']),
      zincMg: _diaryParseDouble(log['zincMg']),
      vitaminAUg: _diaryParseDouble(log['vitaminAUg']),
      vitaminCMg: _diaryParseDouble(log['vitaminCMg']),
      vitaminDUg: _diaryParseDouble(log['vitaminDUg']),
      vitaminEMg: _diaryParseDouble(log['vitaminEMg']),
      vitaminKUg: _diaryParseDouble(log['vitaminKUg']),
      vitaminB6Mg: _diaryParseDouble(log['vitaminB6Mg']),
      vitaminB12Ug: _diaryParseDouble(log['vitaminB12Ug']),
      folateDfeUg: _diaryParseDouble(log['folateDfeUg']),
    );
  }

  @override
  Future<void> addFoodEntry(
    DateTime date,
    String mealType,
    FoodEntry food,
  ) async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> removeFoodEntry(
    DateTime date,
    String mealType,
    String foodId,
  ) async {
    return _dio.delete('api/LogFood/$foodId').tryGet((response) {
      return StatusApiResponse(
        message: 'Food entry deleted successfully',
        statusCode: response.statusCode ?? 200,
      );
    });
  }

  @override
  Future<void> addExerciseEntry(DateTime date, ExerciseEntry exercise) async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> removeExerciseEntry(DateTime date, String exerciseId) async {
    await _dio.delete('api/exercise-logs/$exerciseId');
  }

  @override
  Future<void> updateWaterIntake(DateTime date, int amountMl) async {
    final formattedDate = _formatDateForApi(date.toLocal());
    await _dio.put(
      'api/water-log/day/$formattedDate',
      data: {'amountMl': amountMl},
      options: Options(
        headers: {'accept': '*/*', 'Content-Type': 'application/json'},
      ),
    );
  }

  @override
  Future<void> updateDiaryNote(DateTime date, String? note) async {
    await _dio.put(
      'api/Diary/note',
      data: {'date': date.toUtc().toIso8601String(), 'note': note},
      options: Options(
        headers: {'accept': '*/*', 'Content-Type': 'application/json'},
      ),
    );
  }

  @override
  Future<void> updateFastingStatus(
    DateTime date,
    bool isFasting,
    DateTime? startTime,
    DateTime? endTime,
  ) async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> updateDiaryStatus({
    required DateTime date,
    required bool isCompleted,
  }) async {
    await _dio.post(
      'api/Diary/status',
      data: {
        'date': date.toUtc().toIso8601String(),
        'isCompleted': isCompleted,
      },
      options: Options(
        headers: {'accept': '*/*', 'Content-Type': 'application/json'},
      ),
    );
  }

  // Helper method to format date as yyyy-mm-dd for API
  String _formatDateForApi(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
