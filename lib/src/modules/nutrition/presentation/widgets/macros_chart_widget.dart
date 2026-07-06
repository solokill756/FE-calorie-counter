import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import '../../domain/entities/nutrition_data_entity.dart';
import '../application/nutrition_cubit/nutrition_cubit.dart';

class MacrosChartWidget extends StatelessWidget {
  final NutritionState state;

  const MacrosChartWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final dailyData = state.weeklyData?.dailyData ?? [];
    final isDayView = state.selectedPeriod == 'Day View';

    if (dailyData.isEmpty) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            'No Data Available',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
        ),
      );
    }

    // If Day View, show pie chart for today
    if (isDayView) {
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

      if (todayData == null) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'No Data Available',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
            ),
          ),
        );
      }

      return _buildMacrosPieChart(context, todayData);
    }

    // Calculate max value for Y axis (total of all macros for stacked bars)
    double maxValue = 0.0;
    for (final day in dailyData) {
      final totalMacros = day.carbs + day.fat + day.protein;
      maxValue = maxValue > totalMacros ? maxValue : totalMacros;
    }
    final maxY = ((maxValue / 10).ceil() * 10.0).clamp(50.0, 500.0).toDouble();

    return LayoutBuilder(
      builder: (context, constraints) {
        final chartWidth = (dailyData.length * 50.w)
            .clamp(constraints.maxWidth, double.infinity)
            .toDouble();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 16.w),
          child: SizedBox(
            width: chartWidth,
            height: constraints.maxHeight,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                maxY: maxY,
                minY: 0,
                groupsSpace: 25,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                    fitInsideVertically: true,
                    fitInsideHorizontally: true,
                    tooltipBgColor: Colors.black87,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      if (groupIndex < dailyData.length) {
                        final day = dailyData[groupIndex];

                        final tooltipText =
                            'Carbs: ${day.carbs.toStringAsFixed(1)}g\n'
                            'Fat: ${day.fat.toStringAsFixed(1)}g\n'
                            'Protein: ${day.protein.toStringAsFixed(1)}g';

                        return BarTooltipItem(
                          tooltipText,
                          TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < dailyData.length) {
                          final dayLabel = dailyData[index].dayLabel;
                          final parts = dayLabel.split('\n');
                          final weekdayLetter = parts.isNotEmpty
                              ? parts[0]
                              : '';
                          final dayNumber = parts.length > 1 ? parts[1] : '';

                          return Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 4.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    weekdayLetter,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    dayNumber,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Text('');
                      },
                      reservedSize: 50.h,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: maxY / 4,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w, top: 4.w),
                          child: Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        );
                      },
                      reservedSize: 40.w,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: _createMacrosBarGroupsByDay(context, dailyData),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: maxY / 4,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.grey[300]!, strokeWidth: 1);
                  },
                  drawVerticalLine: false,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<BarChartGroupData> _createMacrosBarGroupsByDay(
    BuildContext context,
    List<DailyCalorieData> dailyData,
  ) {
    List<BarChartGroupData> groups = [];
    final carbsColor = AppShellUi.macroCarbs(context);
    final fatColor = AppShellUi.macroFat(context);
    final proteinColor = AppShellUi.macroProtein(context);

    for (int i = 0; i < dailyData.length; i++) {
      final day = dailyData[i];
      final List<BarChartRodStackItem> stackItems = [];
      double currentY = 0.0;
      double totalHeight = day.carbs + day.fat + day.protein;

      if (day.carbs > 0) {
        stackItems.add(
          BarChartRodStackItem(currentY, currentY + day.carbs, carbsColor),
        );
        currentY += day.carbs;
      }

      if (day.fat > 0) {
        stackItems.add(
          BarChartRodStackItem(currentY, currentY + day.fat, fatColor),
        );
        currentY += day.fat;
      }

      if (day.protein > 0) {
        stackItems.add(
          BarChartRodStackItem(currentY, currentY + day.protein, proteinColor),
        );
      }

      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: totalHeight,
              rodStackItems: stackItems,
              width: 20.w,
              borderRadius: BorderRadius.zero,
            ),
          ],
        ),
      );
    }

    return groups;
  }

  Widget _buildMacrosPieChart(BuildContext context, DailyCalorieData dayData) {
    final totalMacros = dayData.carbs + dayData.fat + dayData.protein;

    if (totalMacros == 0) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            'No Data Available',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
        ),
      );
    }

    final carbsCalories = dayData.carbs * 4;
    final fatCalories = dayData.fat * 9;
    final proteinCalories = dayData.protein * 4;
    final totalMacroCalories = carbsCalories + fatCalories + proteinCalories;
    final carbsPercent = carbsCalories / totalMacroCalories;
    final fatPercent = fatCalories / totalMacroCalories;
    final proteinPercent = proteinCalories / totalMacroCalories;

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 60.r,
        sections: [
          PieChartSectionData(
            value: dayData.carbs,
            title: '${(carbsPercent * 100).toStringAsFixed(0)}%',
            color: AppShellUi.macroCarbs(context),
            radius: 80.r,
            titleStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: dayData.fat,
            title: '${(fatPercent * 100).toStringAsFixed(0)}%',
            color: AppShellUi.macroFat(context),
            radius: 80.r,
            titleStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: dayData.protein,
            title: '${(proteinPercent * 100).toStringAsFixed(0)}%',
            color: AppShellUi.macroProtein(context),
            radius: 80.r,
            titleStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
