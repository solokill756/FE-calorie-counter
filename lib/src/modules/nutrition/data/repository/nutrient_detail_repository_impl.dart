import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';
import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/modules/logfood/domain/repository/logfood_repo.dart';
import '../../../logfood/data/models/food_model.dart';
import '../../domain/entities/nutrition_data_entity.dart';
import '../../domain/repository/nutrient_detail_repository.dart';
import '../../domain/repository/nutrition_repository.dart';

@LazySingleton(as: NutrientDetailRepository)
class NutrientDetailRepositoryImpl implements NutrientDetailRepository {
  final LogFoodRepository _logFoodRepository;
  final NutritionRepository _nutritionRepository;

  NutrientDetailRepositoryImpl(
    this._logFoodRepository,
    this._nutritionRepository,
  );

  @override
  Future<Result<WeeklyNutritionData, ApiError>> getNutrientData({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final daysDiff = endDate.difference(startDate).inDays;

      WeeklyNutritionData weeklyData;
      if (daysDiff <= 1) {
        // Day View - get data for single day
        weeklyData = await _nutritionRepository.getWeeklyData(startDate);
        // Filter to only the specific day
        final dayData = weeklyData.dailyData.firstWhere(
          (day) =>
              day.date.year == startDate.year &&
              day.date.month == startDate.month &&
              day.date.day == startDate.day,
          orElse: () => weeklyData.dailyData.first,
        );
        weeklyData = weeklyData.copyWith(dailyData: [dayData]);
      } else if (daysDiff <= 7) {
        // Week View
        weeklyData = await _nutritionRepository.getWeeklyData(endDate);
      } else {
        // Month View
        weeklyData = await _nutritionRepository.getMonthlyData(startDate);
      }

      return Success(weeklyData);
    } catch (e) {
      return Failure(ApiError(500, e.toString()));
    }
  }

  @override
  Future<Result<List<String>, ApiError>> getFoodsHighestInNutrient({
    required DateTime startDate,
    required DateTime endDate,
    required String nutrientType,
  }) async {
    final logFoodsResult = await _logFoodRepository.getLogFoodsByDate(
      startDate,
      endDate,
      includeQuickAdd: true,
    );

    return logFoodsResult.fold((logFoods) async {
      // Map nutrientType to NutrientKeys and unit
      final nutrientMapping = _getNutrientMapping(nutrientType);

      if (nutrientMapping == null) {
        return Success(<String>[]);
      }

      final foods = await _nutritionRepository.getFoodsHighestInNutrient(
        logFoods,
        nutrientMapping['key'] as String,
        nutrientMapping['unit'] as String,
        null, // No limit for detail page - show all foods
      );

      return Success(foods);
    }, (error) => Failure(error));
  }

  Map<String, String>? _getNutrientMapping(String nutrientType) {
    final lowerType = nutrientType.toLowerCase();

    switch (lowerType) {
      case 'protein':
        return {'key': NutrientKeys.proteinG, 'unit': 'g'};
      case 'carbohydrates':
      case 'carbs':
      case 'total carbohydrates':
        return {'key': NutrientKeys.carbsTotalG, 'unit': 'g'};
      case 'fat':
      case 'total fat':
        return {'key': NutrientKeys.fatTotalG, 'unit': 'g'};
      case 'calories':
        return {'key': NutrientKeys.caloriesKcal, 'unit': 'cal'};
      case 'fiber':
      case 'dietary fiber':
        return {'key': NutrientKeys.fiberG, 'unit': 'g'};
      case 'sugar':
      case 'sugars':
        return {'key': NutrientKeys.sugarsG, 'unit': 'g'};
      case 'saturated fat':
        return {'key': NutrientKeys.fatSaturatedG, 'unit': 'g'};
      case 'polyunsaturated fat':
        return {'key': NutrientKeys.fatPolyunsatG, 'unit': 'g'};
      case 'monounsaturated fat':
        return {'key': NutrientKeys.fatMonounsatG, 'unit': 'g'};
      case 'trans fat':
        return {'key': NutrientKeys.fatTransG, 'unit': 'g'};
      case 'cholesterol':
        return {'key': NutrientKeys.cholesterolMg, 'unit': 'mg'};
      case 'sodium':
        return {'key': NutrientKeys.sodiumMg, 'unit': 'mg'};
      case 'potassium':
        return {'key': NutrientKeys.potassiumMg, 'unit': 'mg'};
      case 'calcium':
        return {'key': NutrientKeys.calciumMg, 'unit': 'mg'};
      case 'iron':
        return {'key': NutrientKeys.ironMg, 'unit': 'mg'};
      case 'magnesium':
        return {'key': NutrientKeys.magnesiumMg, 'unit': 'mg'};
      case 'phosphorus':
        return {'key': NutrientKeys.phosphorusMg, 'unit': 'mg'};
      case 'zinc':
        return {'key': NutrientKeys.zincMg, 'unit': 'mg'};
      case 'vitamin a':
        return {'key': NutrientKeys.vitaminAUg, 'unit': 'mcg'};
      case 'vitamin c':
        return {'key': NutrientKeys.vitaminCMg, 'unit': 'mg'};
      case 'vitamin d':
        return {'key': NutrientKeys.vitaminDUg, 'unit': 'mcg'};
      case 'vitamin e':
        return {'key': NutrientKeys.vitaminEMg, 'unit': 'mg'};
      case 'vitamin k':
        return {'key': NutrientKeys.vitaminKUg, 'unit': 'mcg'};
      case 'vitamin b6':
        return {'key': NutrientKeys.vitaminB6Mg, 'unit': 'mg'};
      case 'vitamin b12':
        return {'key': NutrientKeys.vitaminB12Ug, 'unit': 'mcg'};
      case 'folate':
      case 'folate dfe':
        return {'key': NutrientKeys.folateDfeUg, 'unit': 'mcg'};
      default:
        return null;
    }
  }
}
