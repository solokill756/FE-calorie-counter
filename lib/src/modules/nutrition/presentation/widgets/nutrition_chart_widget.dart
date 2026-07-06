import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../domain/entities/nutrition_data_entity.dart';

class NutritionChartWidget extends StatelessWidget {
  final List<DailyCalorieData> data;
  final bool isNetMode;

  // Constants for consistent spacing
  static const double _groupsSpace = 22.0;
  static const double _barWidth = 20.0;
  static const double _totalModeMinY = 400.0;
  static const double _netModeMinY = 500.0;

  const NutritionChartWidget({
    super.key,
    required this.data,
    required this.isNetMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,
      padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 8.h, bottom: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 0.w, right: 16.w),
        child: SizedBox(
          width: data.length * 50.w,
          height: 280.h,
          child: !isNetMode
              ? _buildTotalModeChart(context)
              : _buildNetModeChart(context),
        ),
      ),
    );
  }

  Widget _buildTotalModeChart(BuildContext context) {
    final hasData = data.isNotEmpty && data.any((day) => day.totalCalories > 0);

    final maxCalories = hasData
        ? data.map((day) => day.totalCalories).reduce((a, b) => a > b ? a : b)
        : 400.0;
    final maxY = _calculateChartMaxY(maxCalories, minY: _totalModeMinY);

    return hasData
        ? BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              maxY: maxY,
              minY: 0,
              groupsSpace: _groupsSpace,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.black87,
                  tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                  fitInsideVertically: true,
                  fitInsideHorizontally: true,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    if (groupIndex < data.length) {
                      final day = data[groupIndex];

                      final tooltipText =
                          'Breakfast: ${day.breakfastCalories.round()} cal\n'
                          'Lunch: ${day.lunchCalories.round()} cal\n'
                          'Dinner: ${day.dinnerCalories.round()} cal\n'
                          'Snacks: ${day.snacksCalories.round()} cal\n'
                          'TOTAL: ${day.totalCalories.round()} cal';

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
                      if (index >= 0 && index < data.length) {
                        final dayLabel = data[index].dayLabel;
                        final parts = dayLabel.split('\n');
                        final weekdayLetter = parts.isNotEmpty ? parts[0] : '';
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
                    reservedSize: 55.w,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: _createTotalModeBarGroups(),
              gridData: FlGridData(
                show: true,
                horizontalInterval: maxY / 4,
                getDrawingHorizontalLine: (value) {
                  return FlLine(color: Colors.grey[300]!, strokeWidth: 1);
                },
                drawVerticalLine: false,
              ),
            ),
          )
        : Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'No Data Available',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }

  List<BarChartGroupData> _createTotalModeBarGroups() {
    List<BarChartGroupData> groups = [];

    for (int i = 0; i < data.length; i++) {
      final day = data[i];
      final List<BarChartRodStackItem> stackItems = [];
      double currentY = 0.0;
      double totalHeight = day.totalCalories;

      // 1. Breakfast (bottom) - Dark blue
      if (day.breakfastCalories > 0) {
        stackItems.add(
          BarChartRodStackItem(
            currentY,
            currentY + day.breakfastCalories,
            Colors.blue[600]!,
          ),
        );
        currentY += day.breakfastCalories;
      }

      // 2. Lunch - Darker blue
      if (day.lunchCalories > 0) {
        stackItems.add(
          BarChartRodStackItem(
            currentY,
            currentY + day.lunchCalories,
            Colors.blue[800]!,
          ),
        );
        currentY += day.lunchCalories;
      }

      // 3. Dinner - Medium blue
      if (day.dinnerCalories > 0) {
        stackItems.add(
          BarChartRodStackItem(
            currentY,
            currentY + day.dinnerCalories,
            Colors.blue[400]!,
          ),
        );
        currentY += day.dinnerCalories;
      }

      // 4. Snacks (top) - Light blue
      if (day.snacksCalories > 0) {
        stackItems.add(
          BarChartRodStackItem(
            currentY,
            currentY + day.snacksCalories,
            Colors.blue[300]!,
          ),
        );
      }

      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: totalHeight,
              rodStackItems: stackItems,
              width: _barWidth.w,
              borderRadius: BorderRadius.zero,
            ),
          ],
        ),
      );
    }

    return groups;
  }

  Widget _buildNetModeChart(BuildContext context) {
    final hasData = data.isNotEmpty && data.any((day) => day.netCalories != 0);

    final maxCalories = hasData
        ? data
              .map((day) => day.netCalories.abs())
              .reduce((a, b) => a > b ? a : b)
        : 500.0;
    final maxY = _calculateChartMaxY(maxCalories, minY: _netModeMinY);

    return hasData
        ? BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              maxY: maxY,
              minY: -maxY,
              groupsSpace: _groupsSpace,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.black87,
                  tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                  fitInsideVertically: true,
                  fitInsideHorizontally: true,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '${rod.toY.round()} cal',
                      TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    );
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
                      if (index >= 0 && index < data.length) {
                        final dayLabel = data[index].dayLabel;
                        final parts = dayLabel.split('\n');
                        final weekdayLetter = parts.isNotEmpty ? parts[0] : '';
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
                    reservedSize: 55.w,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: _createBarGroups(),
              gridData: FlGridData(
                show: true,
                horizontalInterval: maxY / 4,
                getDrawingHorizontalLine: (value) {
                  return FlLine(color: Colors.grey[300]!, strokeWidth: 1);
                },
                drawVerticalLine: false,
              ),
            ),
          )
        : Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'No Data Available',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }

  List<BarChartGroupData> _createBarGroups() {
    List<BarChartGroupData> groups = [];

    // Thêm các cột dữ liệu thường
    for (int i = 0; i < data.length; i++) {
      final calories = isNetMode ? data[i].netCalories : data[i].totalCalories;

      // For net mode, use different colors for positive/negative values
      Color barColor;
      if (isNetMode) {
        barColor = calories >= 0 ? Colors.green[600]! : Colors.red[600]!;
      } else {
        barColor = Colors.black87;
      }

      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              fromY: isNetMode && calories < 0 ? calories : 0,
              toY: isNetMode && calories >= 0
                  ? calories
                  : (calories < 0 ? 0 : calories),
              color: barColor,
              width: _barWidth.w,
              borderRadius: BorderRadius.zero,
            ),
          ],
        ),
      );
    }

    return groups;
  }

  double _calculateChartMaxY(double maxCalories, {required double minY}) {
    if (maxCalories <= minY) {
      return minY;
    }

    final paddedMax = maxCalories * 1.08;
    final interval = paddedMax <= 1000
        ? 100.0
        : paddedMax <= 3000
            ? 250.0
            : 500.0;

    return (paddedMax / interval).ceil() * interval;
  }
}
