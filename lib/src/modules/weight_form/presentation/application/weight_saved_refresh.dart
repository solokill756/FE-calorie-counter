import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../common/utils/getit_utils.dart';
import '../../../auth/presentation/application/cubit/user_profile_cubit.dart';
import '../../../dashboard/presentation/application/dashboard_cubit.dart';
import '../../../diary/presentation/application/diary_cubit/diary_cubit.dart';
import '../../../more/presentation/application/more_cubit/more_cubit.dart';
import '../../../nutrition/presentation/application/nutrition_cubit/nutrition_cubit.dart';
import '../../../progress/presentation/application/progress_cubit/progress_cubit.dart';
import '../../../progress/presentation/application/progress_trends_cubit/progress_trends_cubit.dart';

/// Refreshes screens whose targets depend on the user's latest weight.
Future<void> refreshWeightDependentData() async {
  try {
    await getIt<UserProfileCubit>().refresh();
  } catch (e, st) {
    debugPrint('WeightSavedRefresh: profile refresh skipped: $e\n$st');
  }

  await Future.wait([
    _safe(() => getIt<DashboardCubit>().refreshDashboard(), 'dashboard'),
    _safe(() => getIt<DiaryCubit>().reloadCurrentDiary(), 'diary'),
    _safe(() => getIt<NutritionCubit>().loadWeeklyData(), 'nutrition'),
    _safe(
      () => getIt<ProgressCubit>().loadProgressData(
        page: 1,
        pageSize: 10,
        type: 'Weights',
      ),
      'progress',
    ),
    _safe(() => getIt<ProgressTrendsCubit>().loadTrailingDays(), 'trends'),
    _safe(() => getIt<MoreCubit>().refreshAfterWeightChange(), 'more'),
  ]);
}

Future<void> _safe(Future<void> Function() action, String label) async {
  try {
    await action();
  } catch (e, st) {
    debugPrint('WeightSavedRefresh: $label refresh skipped: $e\n$st');
  }
}
