import 'package:result_dart/result_dart.dart';

import '../../../../core/data/remote/base/api_error.dart';
import '../../../../core/data/remote/base/api_response.dart';
import '../entities/diary_entity.dart';

abstract class DiaryRepository {
  Future<DiaryEntity> getDiaryForDate(DateTime date);
  Future<void> addFoodEntry(DateTime date, String mealType, FoodEntry food);
  Future<Result<StatusApiResponse, ApiError>> removeFoodEntry(
    DateTime date,
    String mealType,
    String foodId,
  );
  Future<void> addExerciseEntry(DateTime date, ExerciseEntry exercise);
  Future<void> removeExerciseEntry(DateTime date, String exerciseId);
  Future<void> updateWaterIntake(DateTime date, int amountMl);
  Future<void> updateDiaryNote(DateTime date, String? note);
  Future<void> updateFastingStatus(
    DateTime date,
    bool isFasting,
    DateTime? startTime,
    DateTime? endTime,
  );
  Future<void> updateDiaryStatus({
    required DateTime date,
    required bool isCompleted,
  });
}
