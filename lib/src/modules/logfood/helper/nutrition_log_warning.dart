import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../common/constants/ui_constants.dart';
import '../../../common/extensions/build_context_x.dart';
import '../../../common/theme/app_shell_ui.dart';
import '../../../common/utils/getit_utils.dart';
import '../../auth/data/models/user_nutritional_threshold_model.dart';
import '../../auth/data/models/user_profile_model.dart';
import '../../diary/domain/entities/diary_entity.dart';
import '../../diary/domain/repository/diary_repository.dart';
import '../data/models/food_model.dart';
import '../domain/entities/macros_entity.dart';
import 'log_food_helper.dart';

/// Shared nutrition-over-daily-goal check + dialog (Log detail, quick-add list, manual quick add).
class NutritionLogWarning {
  NutritionLogWarning._();

  static const Set<String> _maxAlertNutrients = {
    'calories',
    'carbs',
    'fat',
    'sugars',
    'sodium',
    'saturatedfat',
    'cholesterol',
  };

  static DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  static String formatApiDate(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  static double? _projectedTotalForNutrient(
    String nutrientKey,
    DiaryEntity diary,
    MacrosEntity add,
  ) {
    switch (_normalizeNutrientKey(nutrientKey)) {
      case 'calories':
        return diary.caloriesConsumed.toDouble() + add.calories;
      case 'carbs':
        return diary.carbsConsumed + add.carbs;
      case 'fat':
        return diary.fatConsumed + add.fat;
      case 'protein':
        return diary.proteinConsumed + add.protein;
      case 'fiber':
        return diary.fiberConsumedG + add.fiberG;
      case 'sugars':
        return diary.sugarConsumedG + add.sugarsG;
      case 'potassium':
        return diary.potassiumConsumedMg + add.potassiumMg;
      case 'sodium':
        return diary.sodiumConsumedMg + add.sodiumMg;
      case 'saturatedfat':
        return diary.saturatedFatConsumedG + add.saturatedFatG;
      case 'cholesterol':
        return diary.cholesterolConsumedMg + add.cholesterolMg;
      default:
        return null;
    }
  }

  static String _nutrientDisplayName(String nutrientKey) {
    switch (_normalizeNutrientKey(nutrientKey)) {
      case 'calories':
        return 'Calories';
      case 'carbs':
        return 'Carbs';
      case 'fat':
        return 'Fat';
      case 'protein':
        return 'Protein';
      case 'fiber':
        return 'Fiber';
      case 'sugars':
        return 'Sugars';
      case 'potassium':
        return 'Potassium';
      case 'sodium':
        return 'Sodium';
      case 'saturatedfat':
        return 'Saturated fat';
      case 'cholesterol':
        return 'Cholesterol';
      default:
        return nutrientKey;
    }
  }

  static String _formatThresholdCap(double v) {
    if (v == v.roundToDouble()) return v.round().toString();
    return v.toStringAsFixed(1);
  }

  static String _normalizeNutrientKey(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '');
  }

  static double? _thresholdMaxForNutrient(
    List<UserNutritionalThreshold> thresholds,
    String nutrientKey,
  ) {
    final target = _normalizeNutrientKey(nutrientKey);
    for (final t in thresholds) {
      if (_normalizeNutrientKey(t.nutrient) != target) continue;
      final max = t.maxAmount;
      if (max != null && max > 0) return max;
    }
    return null;
  }

  static double? _defaultMaxLimit(String nutrientKey, UserProfileModel? profile) {
    final dailyCal = (profile?.resolvedDailyCalorieGoal() ?? 2220).toDouble();
    switch (_normalizeNutrientKey(nutrientKey)) {
      case 'calories':
        return dailyCal > 0 ? dailyCal : null;
      case 'carbs':
        final v = profile?.carbsGoalG ?? 0;
        return v > 0 ? v : null;
      case 'fat':
        final v = profile?.fatGoalG ?? 0;
        return v > 0 ? v : null;
      case 'sugars':
        // WHO: <10% of total energy, ~10% of dailyCal / 4 cal per gram
        return dailyCal > 0 ? dailyCal * 0.10 / 4 : null;
      case 'sodium':
        // WHO: <2000mg/day for adults
        return 2000.0;
      case 'saturatedfat':
        // WHO: <10% of total energy, ~10% of dailyCal / 9 cal per gram
        return dailyCal > 0 ? dailyCal * 0.10 / 9 : null;
      case 'cholesterol':
        // Removed from WHO/FAO as a specific numeric limit
        return null;
      default:
        return null;
    }
  }

  static double? _resolvedMaxLimit(
    String nutrientKey,
    List<UserNutritionalThreshold> thresholds,
    UserProfileModel? profile,
  ) {
    return _thresholdMaxForNutrient(thresholds, nutrientKey) ??
        _defaultMaxLimit(nutrientKey, profile);
  }

  static String? _exceedLabelIfAny({
    required String nutrientKey,
    required double projected,
    required double maxLimit,
    required bool fromThreshold,
    String unit = '',
  }) {
    if (maxLimit <= 0 || projected <= maxLimit) return null;
    final pct = (projected / maxLimit * 100).round();
    final capStr = _formatThresholdCap(maxLimit);
    final unitSuffix = unit.trim().isEmpty ? '' : ' ${unit.trim()}';
    final name = _nutrientDisplayName(nutrientKey);
    if (fromThreshold) {
      return '$name $pct% of max threshold ($capStr$unitSuffix)';
    }
    return '$name $pct% of daily goal';
  }

  @visibleForTesting
  static List<String> overflowLabelsForDay(
    DiaryEntity diary,
    MacrosEntity add,
    UserProfileModel? profile,
  ) {
    final thresholds = profile?.nutritionalThresholds ?? const [];
    final labels = <String>[];
    final checked = <String>{};

    void checkNutrient(String rawKey, {String unit = ''}) {
      final key = _normalizeNutrientKey(rawKey);
      if (checked.contains(key)) return;
      checked.add(key);

      final max = _resolvedMaxLimit(key, thresholds, profile);
      if (max == null || max <= 0) return;

      final projected = _projectedTotalForNutrient(key, diary, add);
      if (projected == null) return;

      final fromThreshold = _thresholdMaxForNutrient(thresholds, key) != null;
      final label = _exceedLabelIfAny(
        nutrientKey: key,
        projected: projected,
        maxLimit: max,
        fromThreshold: fromThreshold,
        unit: unit,
      );
      if (label != null) labels.add(label);
    }

    for (final key in _maxAlertNutrients) {
      checkNutrient(key);
    }

    for (final t in thresholds) {
      final key = _normalizeNutrientKey(t.nutrient);
      if (t.maxAmount == null || t.maxAmount! <= 0) continue;
      if (_maxAlertNutrients.contains(key)) continue;
      checkNutrient(key, unit: t.unit);
    }

    return labels;
  }

  /// One section per calendar day that would exceed goals after adding [combined].
  static Future<List<String>> loadWarningSections({
    required Iterable<DateTime> calendarDays,
    required MacrosEntity combined,
    UserProfileModel? profile,
  }) async {
    final sections = <String>[];
    for (final d in calendarDays) {
      final day = dateOnly(d);
      try {
        final diary = await getIt<DiaryRepository>().getDiaryForDate(day);
        final labels = overflowLabelsForDay(diary, combined, profile);
        if (labels.isNotEmpty) {
          sections.add('${formatApiDate(day)}:\n${labels.join('\n')}');
        }
      } catch (_) {
        // Skip this day if diary cannot be loaded.
      }
    }
    return sections;
  }

  static Future<bool> showNutritionWarningDialog(
    BuildContext context,
    List<String> sections,
  ) async {
    if (!context.mounted) return false;
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        final mq = MediaQuery.of(ctx);
        final theme = Theme.of(ctx);
        final scheme = theme.colorScheme;
        return AlertDialog(
          backgroundColor: scheme.surfaceContainerLowest,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: ctx.isTablet ? 400 : 358.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(ctx).pop(false),
                        child: SizedBox(
                          width: 26,
                          height: 26,
                          child: Icon(
                            Icons.close,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning, color: scheme.error, size: 40),
                      Gap(16.h),
                      Text(
                        'NUTRITION WARNING',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: scheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(12.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'These days would exceed your daily goals:',
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                            fontSize: 12,
                            height: 1.35,
                          ),
                        ),
                      ),
                      Gap(12.h),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: mq.size.height * 0.42,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (final s in sections) ...[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: NutritionWarningDayCard(section: s),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const Gap(12),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer.withValues(
                            alpha: 0.35,
                          ),
                          borderRadius: BorderRadius.circular(
                            UIConstants.kRadius,
                          ),
                          border: Border.all(color: scheme.outlineVariant),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: scheme.primary,
                              ),
                              const Gap(8),
                              Expanded(
                                child: Text(
                                  'You can still log - this is only a heads-up.',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: scheme.onSurface,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(16.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Do you still want to log?',
                          style: TextStyle(
                            color: scheme.onSurface,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Gap(20.h),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              style: AppShellUi.outlinedActionStyle(ctx),
                              child: Text(
                                'Go back',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Gap(10.w),
                          Expanded(
                            child: FilledButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              style: FilledButton.styleFrom(
                                backgroundColor: scheme.error,
                                foregroundColor: scheme.onError,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                'Log anyway',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return result == true;
  }

  /// Returns `true` if the user may proceed (no overflow or chose "Log anyway").
  static Future<bool> confirmIfProceed(
    BuildContext context,
    List<String> sections,
  ) async {
    if (sections.isEmpty) return true;
    if (!context.mounted) return false;
    return showNutritionWarningDialog(context, sections);
  }

  /// Quick-add from list/search: one serving, [unitIndex], on [logCalendarDay].
  static Future<bool> confirmQuickAddFromList(
    BuildContext context, {
    required FoodModel food,
    required double qty,
    required int unitIndex,
    required DateTime logCalendarDay,
    UserProfileModel? profile,
  }) async {
    final safeUnit = food.unitSizes.isEmpty
        ? 0
        : unitIndex.clamp(0, food.unitSizes.length - 1);
    final label = food.units.isNotEmpty && safeUnit < food.units.length
        ? food.units[safeUnit]
        : null;
    final macros = LogFoodHelper.macrosForQuantity(
      food,
      qty,
      safeUnit,
      mainFoodServingSizeLabel: label,
    );
    final sections = await loadWarningSections(
      calendarDays: [dateOnly(logCalendarDay)],
      combined: macros,
      profile: profile,
    );
    if (!context.mounted) return true;
    return confirmIfProceed(context, sections);
  }

  /// Manual Quick Add screen: calories + optional macro grams on [logCalendarDay].
  static Future<bool> confirmQuickAddManual(
    BuildContext context, {
    required double calories,
    double? fat,
    double? carbs,
    double? protein,
    required DateTime logCalendarDay,
    UserProfileModel? profile,
  }) async {
    final macros = MacrosEntity(
      carbs: carbs ?? 0,
      fat: fat ?? 0,
      protein: protein ?? 0,
      calories: calories,
    );
    final sections = await loadWarningSections(
      calendarDays: [dateOnly(logCalendarDay)],
      combined: macros,
      profile: profile,
    );
    if (!context.mounted) return true;
    return confirmIfProceed(context, sections);
  }

  static Future<bool> confirmQuickAddSavedMeal(
    BuildContext context, {
    required FoodModel meal,
    required double qty,
    required DateTime logCalendarDay,
    UserProfileModel? profile,
  }) async {
    final safeUnit = meal.unitSizes.isEmpty
        ? 0
        : meal.unitShowIndex.clamp(0, meal.unitSizes.length - 1);
    final label = meal.units.isNotEmpty && safeUnit < meal.units.length
        ? meal.units[safeUnit]
        : null;
    final macros = LogFoodHelper.macrosForQuantity(
      meal,
      qty,
      safeUnit,
      mainFoodServingSizeLabel: label,
    );
    final sections = await loadWarningSections(
      calendarDays: [dateOnly(logCalendarDay)],
      combined: macros,
      profile: profile,
    );
    if (!context.mounted) return true;
    return confirmIfProceed(context, sections);
  }
}

/// One block in the nutrition warning dialog: date + list of exceeded metrics.
class NutritionWarningDayCard extends StatelessWidget {
  const NutritionWarningDayCard({super.key, required this.section});

  final String section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    const sep = ':\n';
    final i = section.indexOf(sep);
    final dateStr = i >= 0 ? section.substring(0, i) : section;
    final detail = i >= 0 ? section.substring(i + sep.length) : '';
    final lines = detail.isEmpty
        ? <String>[]
        : detail.split('\n').where((l) => l.trim().isNotEmpty).toList();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(UIConstants.kRadius),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 16,
                  color: scheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    dateStr,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (lines.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...lines.map(
                (line) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Icon(
                          Icons.trending_up_rounded,
                          size: 16,
                          color: scheme.error,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          line,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurface,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
