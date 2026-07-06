import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import '../../domain/entities/nutrition_data_entity.dart';
import '../application/nutrition_cubit/nutrition_cubit.dart';

class MacrosLegendWidget extends StatelessWidget {
  final NutritionState state;

  const MacrosLegendWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final macros = state.weeklyData?.macros ?? MacrosData();
    final isDayView = state.selectedPeriod == 'Day View';

    String formatValue(double value) {
      if (value == 0) return '0g';
      if (value < 1) return '${value.toStringAsFixed(1)}g';
      return '${value.round()}g';
    }

    double carbsAvgPercent;
    double fatAvgPercent;
    double proteinAvgPercent;

    if (isDayView) {
      // For Day View: Calculate percentages based on total grams
      final dailyData = state.weeklyData?.dailyData ?? [];
      final currentDate = state.currentDate;

      // Find today's data
      DailyCalorieData? todayData;
      for (final day in dailyData) {
        if (day.date.year == currentDate.year &&
            day.date.month == currentDate.month &&
            day.date.day == currentDate.day) {
          todayData = day;
          break;
        }
      }

      if (todayData != null) {
        final carbsCalories = todayData.carbs * 4;
        final fatCalories = todayData.fat * 9;
        final proteinCalories = todayData.protein * 4;
        final totalMacroCalories =
            carbsCalories + fatCalories + proteinCalories;

        if (totalMacroCalories > 0) {
          carbsAvgPercent = (carbsCalories / totalMacroCalories * 100);
          fatAvgPercent = (fatCalories / totalMacroCalories * 100);
          proteinAvgPercent = (proteinCalories / totalMacroCalories * 100);
        } else {
          carbsAvgPercent = 0.0;
          fatAvgPercent = 0.0;
          proteinAvgPercent = 0.0;
        }
      } else {
        carbsAvgPercent = 0.0;
        fatAvgPercent = 0.0;
        proteinAvgPercent = 0.0;
      }
    } else {
      final carbsCalories = macros.carbs * 4;
      final fatCalories = macros.fat * 9;
      final proteinCalories = macros.protein * 4;
      final totalMacroCalories = carbsCalories + fatCalories + proteinCalories;

      if (totalMacroCalories > 0) {
        carbsAvgPercent = (carbsCalories / totalMacroCalories * 100);
        fatAvgPercent = (fatCalories / totalMacroCalories * 100);
        proteinAvgPercent = (proteinCalories / totalMacroCalories * 100);
      } else {
        carbsAvgPercent = 0.0;
        fatAvgPercent = 0.0;
        proteinAvgPercent = 0.0;
      }
    }

    final goalPercents = _normalizedGoalPercents(macros);
    final carbsGoalPercent = goalPercents.$1;
    final fatGoalPercent = goalPercents.$2;
    final proteinGoalPercent = goalPercents.$3;
    final avgPercentLabels = _roundedPercentLabels(
      carbsAvgPercent,
      fatAvgPercent,
      proteinAvgPercent,
    );
    final goalPercentLabels = _roundedPercentLabels(
      carbsGoalPercent,
      fatGoalPercent,
      proteinGoalPercent,
    );

    // Get values for display
    double carbsValue;
    double fatValue;
    double proteinValue;

    if (isDayView) {
      // For Day View: Use today's data
      final dailyData = state.weeklyData?.dailyData ?? [];
      final currentDate = state.currentDate;

      DailyCalorieData? todayData;
      for (final day in dailyData) {
        if (day.date.year == currentDate.year &&
            day.date.month == currentDate.month &&
            day.date.day == currentDate.day) {
          todayData = day;
          break;
        }
      }

      carbsValue = todayData?.carbs ?? 0.0;
      fatValue = todayData?.fat ?? 0.0;
      proteinValue = todayData?.protein ?? 0.0;
    } else {
      // For Week/Month View: Use average macros
      carbsValue = macros.carbs;
      fatValue = macros.fat;
      proteinValue = macros.protein;
    }

    return Column(
      children: [
        _buildMacroLegend(
          'Carbohydrates',
          formatValue(carbsValue),
          avgPercentLabels[0],
          goalPercentLabels[0],
          AppShellUi.macroCarbs(context),
        ),
        SizedBox(height: 12.h),
        _buildMacroLegend(
          'Fat',
          formatValue(fatValue),
          avgPercentLabels[1],
          goalPercentLabels[1],
          AppShellUi.macroFat(context),
        ),
        SizedBox(height: 12.h),
        _buildMacroLegend(
          'Protein',
          formatValue(proteinValue),
          avgPercentLabels[2],
          goalPercentLabels[2],
          AppShellUi.macroProtein(context),
        ),
      ],
    );
  }

  Widget _buildMacroLegend(
    String name,
    String amount,
    String avgPercent,
    String goalPercent,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            '$name ($amount)',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ),
        Text(
          avgPercent,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 40.w),
        Text(
          goalPercent,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  (double carbs, double fat, double protein) _normalizedGoalPercents(
    MacrosData macros,
  ) {
    final profilePercentTotal =
        macros.carbsGoalPercent +
        macros.fatGoalPercent +
        macros.proteinGoalPercent;

    if (profilePercentTotal > 0) {
      return (
        macros.carbsGoalPercent / profilePercentTotal * 100,
        macros.fatGoalPercent / profilePercentTotal * 100,
        macros.proteinGoalPercent / profilePercentTotal * 100,
      );
    }

    final carbsGoalCalories = macros.carbsGoal * 4;
    final fatGoalCalories = macros.fatGoal * 9;
    final proteinGoalCalories = macros.proteinGoal * 4;
    final totalGoalCalories =
        carbsGoalCalories + fatGoalCalories + proteinGoalCalories;

    if (totalGoalCalories > 0) {
      return (
        carbsGoalCalories / totalGoalCalories * 100,
        fatGoalCalories / totalGoalCalories * 100,
        proteinGoalCalories / totalGoalCalories * 100,
      );
    }

    return (50.0, 30.0, 20.0);
  }

  List<String> _roundedPercentLabels(double carbs, double fat, double protein) {
    final values = [carbs, fat, protein];
    final total = values.fold<double>(0, (sum, value) => sum + value);
    if (total <= 0) return const ['0%', '0%', '0%'];

    final normalized = values.map((value) => value / total * 100).toList();
    final rounded = normalized.map((value) => value.floor()).toList();
    var remaining = 100 - rounded.fold<int>(0, (sum, value) => sum + value);

    final remainderOrder = [0, 1, 2]
      ..sort(
        (a, b) =>
            (normalized[b] - rounded[b]).compareTo(normalized[a] - rounded[a]),
      );

    for (final index in remainderOrder) {
      if (remaining <= 0) break;
      rounded[index] += 1;
      remaining -= 1;
    }

    return rounded.map((value) => '$value%').toList(growable: false);
  }
}
