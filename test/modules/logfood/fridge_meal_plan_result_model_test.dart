import 'package:caloriecounter/src/modules/logfood/data/models/fridge_meal_plan_result_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FridgeMealPlanResult parses slot summary', () {
    final result = FridgeMealPlanResult.fromJson({
      'dateKey': '2026-06-17',
      'sourceType': 'fridge_ai_daily_plan',
      'slots': [
        {'mealSlot': 'breakfast', 'status': 'created'},
        {'mealSlot': 'lunch', 'status': 'existing', 'reason': 'existing'},
        {'mealSlot': 'snack', 'status': 'skipped', 'reason': 'logged'},
      ],
    });

    expect(result.createdCount, 1);
    expect(result.existingCount, 1);
    expect(result.skippedCount, 1);
    expect(result.summaryMessage, contains('1 new recipe'));
    expect(result.summaryMessage, contains('1 existing'));
    expect(result.summaryMessage, contains('1 skipped'));
  });

  test('FridgeMealPlanResult parses recommendation and warnings per slot', () {
    final result = FridgeMealPlanResult.fromJson({
      'dateKey': '2026-06-17',
      'sourceType': 'fridge_ai_daily_plan',
      'slots': [
        {
          'mealSlot': 'lunch',
          'status': 'created',
          'recommendation': 'Balanced lunch from pantry staples.',
          'safetyWarnings': ['Caution: sodium high'],
          'generationWarnings': ['Portions adjusted'],
        },
      ],
    });

    expect(result.slots.single.recommendation, 'Balanced lunch from pantry staples.');
    expect(result.slots.single.safetyWarnings, ['Caution: sodium high']);
    expect(result.slots.single.generationWarnings, ['Portions adjusted']);
    expect(result.allSafetyWarnings, ['Caution: sodium high']);
    expect(result.allGenerationWarnings, ['Portions adjusted']);
  });
}
