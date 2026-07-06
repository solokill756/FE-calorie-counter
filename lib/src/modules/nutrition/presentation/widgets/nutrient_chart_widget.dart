import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

class NutrientChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> chartData;
  final String unit; // 'g', 'mg', '%', etc.

  // Constants for consistent spacing
  static const double _groupsSpace = 22;
  static const double _barWidth = 20.0;

  const NutrientChartWidget({
    super.key,
    required this.chartData,
    this.unit = 'g',
  });

  @override
  Widget build(BuildContext context) {
    final int dataCount = chartData.length;
    final double totalBarWidth = dataCount * _barWidth;
    final double totalSpaceWidth =
        (dataCount > 0 ? dataCount - 1 : 0) * _groupsSpace;

    final double requiredWidth = (totalBarWidth + totalSpaceWidth).w + 10.w;

    final chartWidth = chartData.isEmpty ? 300.w : requiredWidth;

    return Container(
      height: 280.h,
      padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 8.h, bottom: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 0.w, right: 16.w),
        child: SizedBox(
          width: chartWidth,
          height: 280.h,
          child: _buildChart(context),
        ),
      ),
    );
  }

  Widget _buildChart(BuildContext context) {
    final hasData =
        chartData.isNotEmpty &&
        chartData.any((day) => (day['total'] as num) > 0);

    final maxValue = hasData
        ? chartData
              .map((day) => (day['total'] as num).toDouble())
              .reduce((a, b) => a > b ? a : b)
        : 100.0;
    final maxY = ((maxValue / 10).ceil() * 10.0).clamp(100.0, 1000.0);

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
                  // SỬA LỖI ENUM: FLHorizontalAlignment.center -> BarTooltipAlignment.center
                  tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                  fitInsideVertically: true,
                  fitInsideHorizontally: true,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    if (groupIndex < chartData.length) {
                      final day = chartData[groupIndex];
                      final breakfast = (day['breakfast'] as num).toDouble();
                      final lunch = (day['lunch'] as num).toDouble();
                      final dinner = (day['dinner'] as num).toDouble();
                      final snacks = (day['snacks'] as num).toDouble();
                      final total = (day['total'] as num).toDouble();

                      final tooltipText =
                          'Breakfast: ${breakfast.toStringAsFixed(1)}$unit\n'
                          'Lunch: ${lunch.toStringAsFixed(1)}$unit\n'
                          'Dinner: ${dinner.toStringAsFixed(1)}$unit\n'
                          'Snacks: ${snacks.toStringAsFixed(1)}$unit\n'
                          'TOTAL: ${total.toStringAsFixed(1)}$unit';

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
                      if (index >= 0 && index < chartData.length) {
                        final dayLabel = chartData[index]['dayLabel'] as String;
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
                      return const SizedBox.shrink();
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
                        padding: EdgeInsets.only(top: 4.w),
                        child: Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
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

    for (int i = 0; i < chartData.length; i++) {
      final day = chartData[i];
      final List<BarChartRodStackItem> stackItems = [];
      double currentY = 0.0;
      final totalHeight = (day['total'] as num).toDouble();

      // 1. Breakfast (bottom) - Dark blue
      final breakfast = (day['breakfast'] as num).toDouble();
      if (breakfast > 0) {
        stackItems.add(
          BarChartRodStackItem(
            currentY,
            currentY + breakfast,
            Colors.blue[600]!,
          ),
        );
        currentY += breakfast;
      }

      // 2. Lunch - Darker blue
      final lunch = (day['lunch'] as num).toDouble();
      if (lunch > 0) {
        stackItems.add(
          BarChartRodStackItem(currentY, currentY + lunch, Colors.blue[800]!),
        );
        currentY += lunch;
      }

      // 3. Dinner - Medium blue
      final dinner = (day['dinner'] as num).toDouble();
      if (dinner > 0) {
        stackItems.add(
          BarChartRodStackItem(currentY, currentY + dinner, Colors.blue[400]!),
        );
        currentY += dinner;
      }

      // 4. Snacks (top) - Light blue
      final snacks = (day['snacks'] as num).toDouble();
      if (snacks > 0) {
        stackItems.add(
          BarChartRodStackItem(currentY, currentY + snacks, Colors.blue[300]!),
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
}
