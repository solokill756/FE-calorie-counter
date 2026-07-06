import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_access.dart';

import '../../domain/entities/nutrition_data_entity.dart';

class MacroCalculator {
  static MacrosData calculateMacros({
    required double totalCarbs,
    required double totalFat,
    required double totalProtein,
    required int days,
  }) {
    final profile = readServerProfile();
    final carbsGoal = profile?.carbsGoalG ?? 0.0;
    final fatGoal = profile?.fatGoalG ?? 0.0;
    final proteinGoal = profile?.proteinGoalG ?? 0.0;

    return MacrosData(
      carbs: totalCarbs / days,
      fat: totalFat / days,
      protein: totalProtein / days,
      carbsGoal: carbsGoal,
      fatGoal: fatGoal,
      proteinGoal: proteinGoal,
    );
  }
}
