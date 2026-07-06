import 'package:result_dart/result_dart.dart';
import '../entities/calorie_entity.dart';

abstract class CalorieRepository {
  Future<Result<CalorieEntity, Exception>> getTodayCalories();
  Future<Result<MacroEntity, Exception>> getTodayMacros();
  Future<Result<List<ActivityEntity>, Exception>> getTodayActivities();
  Future<Result<List<WeightEntity>, Exception>> getWeightHistory();
  Future<Result<void, Exception>> addCalories(int calories);
  Future<Result<void, Exception>> addActivity(ActivityEntity activity);
  Future<Result<void, Exception>> updateWeight(double weight);
} 