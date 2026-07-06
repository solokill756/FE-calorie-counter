import '../models/exercise_models.dart';

abstract class ExerciseRepository {
  Future<ExerciseListPage> listExercises({
    String? q,
    String? type,
    bool mineOnly,
    int page,
    int limit,
  });

  Future<ExerciseItem> getExercise(int id);

  Future<ExerciseLogListPage> listLogs({
    String? from,
    String? to,
    int page,
    int limit,
  });

  Future<ExerciseSummaryToday> getTodaySummary({String? date});

  Future<Map<String, dynamic>> getSummaryRange(String from, String to);

  Future<ExerciseLogCreated> createLog({
    required int exerciseId,
    DateTime? startedAt,
    required double minutesPerformed,
    String source = 'manual',
  });

  Future<void> deleteLog(int id);

  Future<ExerciseItem> createExercise({
    required String name,
    required String type,
    double? met,
    double? defaultCalPerMin,
    String? notes,
  });

  Future<ExerciseItem> updateExercise(
    int id, {
    String? name,
    String? type,
    double? met,
    double? defaultCalPerMin,
    String? notes,
  });

  Future<void> deleteExercise(int id);
}
