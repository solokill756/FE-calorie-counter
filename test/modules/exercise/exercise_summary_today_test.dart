import 'package:caloriecounter/src/modules/exercise/domain/models/exercise_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ExerciseSummaryToday.fromJson parses items', () {
    final summary = ExerciseSummaryToday.fromJson({
      'date': '2026-06-17',
      'totalCaloriesBurned': 900,
      'totalMinutes': 90,
      'totalLogs': 3,
      'items': [
        {
          'id': 1,
          'exerciseId': 10,
          'exerciseName': 'Running',
          'exerciseType': 'cardio',
          'startedAt': '2026-06-17T08:30:00.000Z',
          'minutesPerformed': 30,
          'caloriesBurned': 300,
          'source': 'manual',
        },
      ],
    });

    expect(summary.totalLogs, 3);
    expect(summary.items, hasLength(1));
    expect(summary.items.first.exerciseName, 'Running');
    expect(summary.items.first.caloriesBurned, 300);
  });

  test('ExerciseSummaryToday.fromJson defaults items to empty list', () {
    final summary = ExerciseSummaryToday.fromJson({
      'date': '2026-06-17',
      'totalCaloriesBurned': 0,
      'totalMinutes': 0,
      'totalLogs': 0,
    });

    expect(summary.items, isEmpty);
  });
}
