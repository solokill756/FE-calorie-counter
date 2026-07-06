import 'package:caloriecounter/src/modules/auth/data/models/user_nutritional_threshold_model.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:caloriecounter/src/modules/diary/domain/entities/diary_entity.dart';
import 'package:caloriecounter/src/modules/logfood/domain/entities/macros_entity.dart';
import 'package:caloriecounter/src/modules/logfood/helper/nutrition_log_warning.dart';
import 'package:flutter_test/flutter_test.dart';

DiaryEntity _emptyDiary() => DiaryEntity(
      date: DateTime(2026, 6, 17),
      caloriesGoal: 2000,
      caloriesConsumed: 0,
      caloriesBurned: 0,
      carbsConsumed: 0,
      proteinConsumed: 0,
      fatConsumed: 0,
      breakfast: const [],
      lunch: const [],
      dinner: const [],
      snacks: const [],
      exercises: const [],
      waterGlasses: 0,
      isFasting: false,
    );

UserProfileModel _profile({List<UserNutritionalThreshold> thresholds = const []}) =>
    UserProfileModel(
      dailyCalorieTarget: 2000,
      macroCarbsG: 250,
      macroFatG: 70,
      nutritionalThresholds: thresholds,
    );

void main() {
  group('NutritionLogWarning.overflowLabelsForDay', () {
    test('exceeds default calories max for user without thresholds', () {
      final diary = _emptyDiary().copyWith(caloriesConsumed: 1900);
      const add = MacrosEntity(carbs: 0, fat: 0, protein: 0, calories: 200);
      final labels = NutritionLogWarning.overflowLabelsForDay(
        diary,
        add,
        _profile(),
      );
      expect(labels.any((l) => l.contains('Calories')), isTrue);
    });

    test('exceeds default sodium when no threshold', () {
      final diary = _emptyDiary().copyWith(sodiumConsumedMg: 2200);
      const add = MacrosEntity(
        carbs: 0,
        fat: 0,
        protein: 0,
        calories: 0,
        sodiumMg: 200,
      );
      final labels = NutritionLogWarning.overflowLabelsForDay(
        diary,
        add,
        _profile(),
      );
      expect(labels.any((l) => l.contains('Sodium')), isTrue);
    });

    test('does not warn when only below protein min threshold', () {
      final diary = _emptyDiary().copyWith(proteinConsumed: 10);
      const add = MacrosEntity(carbs: 0, fat: 0, protein: 5, calories: 50);
      final labels = NutritionLogWarning.overflowLabelsForDay(
        diary,
        add,
        _profile(
          thresholds: const [
            UserNutritionalThreshold(nutrient: 'protein', minAmount: 80),
          ],
        ),
      );
      expect(labels, isEmpty);
    });

    test('threshold max overrides default for same nutrient', () {
      final diary = _emptyDiary().copyWith(sodiumConsumedMg: 1400);
      const add = MacrosEntity(
        carbs: 0,
        fat: 0,
        protein: 0,
        calories: 0,
        sodiumMg: 200,
      );
      final labels = NutritionLogWarning.overflowLabelsForDay(
        diary,
        add,
        _profile(
          thresholds: const [
            UserNutritionalThreshold(nutrient: 'sodium', maxAmount: 1500, unit: 'mg'),
          ],
        ),
      );
      expect(labels.any((l) => l.contains('max threshold')), isTrue);
    });

    test('one health threshold still checks other default max nutrients', () {
      final diary = _emptyDiary().copyWith(sodiumConsumedMg: 2250);
      const add = MacrosEntity(
        carbs: 0,
        fat: 0,
        protein: 0,
        calories: 0,
        sodiumMg: 100,
      );
      final labels = NutritionLogWarning.overflowLabelsForDay(
        diary,
        add,
        _profile(
          thresholds: const [
            UserNutritionalThreshold(nutrient: 'calories', maxAmount: 1800),
          ],
        ),
      );
      expect(labels.any((l) => l.contains('Sodium')), isTrue);
    });

    test('sugars projection includes food portion', () {
      final diary = _emptyDiary().copyWith(sugarConsumedG: 40);
      const add = MacrosEntity(
        carbs: 0,
        fat: 0,
        protein: 0,
        calories: 0,
        sugarsG: 20,
      );
      final labels = NutritionLogWarning.overflowLabelsForDay(
        diary,
        add,
        _profile(),
      );
      expect(labels.any((l) => l.contains('Sugars')), isTrue);
    });
  });
}
