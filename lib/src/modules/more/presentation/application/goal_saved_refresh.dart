import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../common/utils/getit_utils.dart';
import '../../../auth/presentation/application/cubit/user_profile_cubit.dart';
import '../../../calorie_counter/presentation/application/calorie_cubit/calorie_cubit.dart';
import '../../../dashboard/presentation/application/dashboard_cubit.dart';
import '../../../diary/presentation/application/diary_cubit/diary_cubit.dart';
import '../../../more/presentation/application/more_cubit/more_cubit.dart';
import '../../../nutrition/presentation/application/nutrition_cubit/nutrition_cubit.dart';

/// Refreshes screens whose calorie/macro targets depend on the active user goal.
Future<void> refreshGoalDependentData() async {
  try {
    await getIt<UserProfileCubit>().refresh();
  } catch (e, st) {
    debugPrint('GoalSavedRefresh: profile refresh skipped: $e\n$st');
  }

  await Future.wait([
    _safe(() => getIt<DashboardCubit>().refreshDashboard(), 'dashboard'),
    _safe(() => getIt<DiaryCubit>().reloadCurrentDiary(), 'diary'),
    _safe(() => getIt<NutritionCubit>().loadWeeklyData(), 'nutrition'),
    _safe(() => getIt<CalorieCubit>().loadTodayData(), 'calorie'),
    _safe(() => getIt<MoreCubit>().refreshAfterGoalChange(), 'more'),
  ]);
}

Future<void> _safe(Future<void> Function() action, String label) async {
  try {
    await action();
  } catch (e, st) {
    debugPrint('GoalSavedRefresh: $label refresh skipped: $e\n$st');
  }
}
