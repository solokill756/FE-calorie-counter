import 'package:flutter/material.dart';

enum MealOptions {
  breakfast,
  lunch,
  dinner,
  snacks;

  String get value {
    switch (this) {
      case MealOptions.breakfast:
        return 'breakfast';
      case MealOptions.lunch:
        return 'lunch';
      case MealOptions.dinner:
        return 'dinner';
      case MealOptions.snacks:
        return 'snacks';
    }
  }

  String get displayName {
    switch (this) {
      case MealOptions.breakfast:
        return 'Breakfast';
      case MealOptions.lunch:
        return 'Lunch';
      case MealOptions.dinner:
        return 'Dinner';
      case MealOptions.snacks:
        return 'Snacks';
    }
  }

  /// Trả về IconData thay vì String
  IconData get icon {
    switch (this) {
      case MealOptions.breakfast:
        return Icons.free_breakfast; // ly cafe
      case MealOptions.lunch:
        return Icons.lunch_dining; // cơm trưa
      case MealOptions.dinner:
        return Icons.dinner_dining; // bữa tối
      case MealOptions.snacks:
        return Icons.fastfood; // snack
    }
  }

  // Static helpers
  static MealOptions fromValue(String value) {
    return MealOptions.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MealOptions.breakfast,
    );
  }
}
