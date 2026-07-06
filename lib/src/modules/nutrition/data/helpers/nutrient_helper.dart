import 'package:flutter/material.dart';
import '../../domain/entities/nutrition_data_entity.dart';

class NutrientHelper {
  static Map<String, Map<String, dynamic>> calculateMealBreakdown(
    List<DailyCalorieData> dailyData,
    String nutrientName,
  ) {
    double totalBreakfast = 0;
    double totalLunch = 0;
    double totalDinner = 0;
    double totalSnacks = 0;
    double total = 0;
    for (final day in dailyData) {
      totalBreakfast += day.getNutrientByMeal('breakfast', nutrientName);
      totalLunch += day.getNutrientByMeal('lunch', nutrientName);
      totalDinner += day.getNutrientByMeal('dinner', nutrientName);
      totalSnacks += day.getNutrientByMeal('snacks', nutrientName);
    }
    total = totalBreakfast + totalLunch + totalDinner + totalSnacks;
    return {
      'breakfast': {
        'name': 'Breakfast',
        'color': Colors.blue[600]!,
        'amount': totalBreakfast,
        'percentage': total > 0 ? (totalBreakfast / total * 100) : 0.0,
      },
      'lunch': {
        'name': 'Lunch',
        'color': Colors.blue[800]!,
        'amount': totalLunch,
        'percentage': total > 0 ? (totalLunch / total * 100) : 0.0,
      },
      'dinner': {
        'name': 'Dinner',
        'color': Colors.blue[400]!,
        'percentage': total > 0 ? (totalDinner / total * 100) : 0.0,
        'amount': totalDinner,
      },
      'snacks': {
        'name': 'Snacks',
        'color': Colors.lightBlue[300]!,
        'amount': totalSnacks,
        'percentage': total > 0 ? (totalSnacks / total * 100) : 0.0,
      },
    };
  }

  static Map<String, Map<String, dynamic>> calculateMealBreakdownForDay(
    DailyCalorieData dayData,
    String nutrientName,
  ) {
    final breakfast = dayData.getNutrientByMeal('breakfast', nutrientName);
    final lunch = dayData.getNutrientByMeal('lunch', nutrientName);
    final dinner = dayData.getNutrientByMeal('dinner', nutrientName);
    final snacks = dayData.getNutrientByMeal('snacks', nutrientName);
    final total = breakfast + lunch + dinner + snacks;

    return {
      'breakfast': {
        'name': 'Breakfast',
        'color': Colors.blue[600]!,
        'amount': breakfast,
        'percentage': total > 0 ? (breakfast / total * 100) : 0.0,
      },
      'lunch': {
        'name': 'Lunch',
        'color': Colors.blue[800]!,
        'amount': lunch,
        'percentage': total > 0 ? (lunch / total * 100) : 0.0,
      },
      'dinner': {
        'name': 'Dinner',
        'color': Colors.blue[400]!,
        'amount': dinner,
        'percentage': total > 0 ? (dinner / total * 100) : 0.0,
      },
      'snacks': {
        'name': 'Snacks',
        'color': Colors.lightBlue[300]!,
        'amount': snacks,
        'percentage': total > 0 ? (snacks / total * 100) : 0.0,
      },
    };
  }

  static List<Map<String, dynamic>> calculateChartData(
    List<DailyCalorieData> dailyData,
    String nutrientName,
  ) {
    List<Map<String, dynamic>> chartData = [];
    for (final day in dailyData) {
      final total =
          day.getNutrientByMeal('breakfast', nutrientName) +
          day.getNutrientByMeal('lunch', nutrientName) +
          day.getNutrientByMeal('dinner', nutrientName) +
          day.getNutrientByMeal('snacks', nutrientName);
      chartData.add({
        'breakfast': day.getNutrientByMeal('breakfast', nutrientName),
        'lunch': day.getNutrientByMeal('lunch', nutrientName),
        'dinner': day.getNutrientByMeal('dinner', nutrientName),
        'snacks': day.getNutrientByMeal('snacks', nutrientName),
        'total': total,
        'dayLabel': day.dayLabel,
      });
    }
    return chartData;
  }

  static double calculateDailyAverage(List<Map<String, dynamic>> chartData) {
    return chartData.isNotEmpty
        ? chartData.map((d) => d['total']).reduce((a, b) => a + b) /
              chartData.length
        : 0.0;
  }

  static NutrientsData addNutrients(NutrientsData a, NutrientsData b) {
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

  static String getUnitForNutrient(String nutrientName) {
    final lowerName = nutrientName.toLowerCase();
    if (lowerName.contains('sodium') ||
        lowerName.contains('cholesterol') ||
        lowerName.contains('potassium') ||
        lowerName.contains('calcium') ||
        lowerName.contains('iron') ||
        lowerName.contains('magnesium') ||
        lowerName.contains('phosphorus') ||
        lowerName.contains('zinc')) {
      return 'mg';
    }
    if (lowerName.contains('vitamin a') ||
        lowerName.contains('vitamin d') ||
        lowerName.contains('vitamin k') ||
        lowerName.contains('vitamin b12') ||
        lowerName.contains('folate')) {
      return 'mcg';
    }
    if (lowerName.contains('vitamin')) {
      return 'mg';
    }
    return 'g'; // Default cho protein, carbs, fat, etc.
  }
}
