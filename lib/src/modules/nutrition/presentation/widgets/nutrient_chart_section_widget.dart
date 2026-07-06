import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'nutrient_chart_widget.dart';
import 'nutrient_meal_legend_widget.dart';

class NutrientChartSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> chartData;
  final Map<String, Map<String, dynamic>> mealBreakdown;
  final double dailyAverage;
  final String unit;
  final String selectedPeriod;
  const NutrientChartSectionWidget({
    super.key,
    required this.chartData,
    required this.mealBreakdown,
    required this.dailyAverage,
    required this.unit,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          // Chart
          SizedBox(
            height: 200.h,
            child: chartData.isEmpty || chartData.every((d) => d['total'] == 0)
                ? Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'No Data Available',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : selectedPeriod == 'Day View'
                ? _buildPieChart()
                : NutrientChartWidget(chartData: chartData, unit: unit),
          ),

          // Meal Legend
          SizedBox(height: 16.h),
          NutrientMealLegendWidget(
            mealBreakdown: mealBreakdown,
            selectedPeriod: selectedPeriod,
            unit: unit,
          ),

          SizedBox(height: 16.h),

          // Divider
          Container(height: 1, color: Colors.grey[300]),

          SizedBox(height: 16.h),

          // Daily Average or Total (for Day View)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedPeriod == 'Day View'
                    ? 'Total ($unit)'
                    : 'Daily Average ($unit)',
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              ),
              Text(
                selectedPeriod == 'Day View' && chartData.isNotEmpty
                    ? (chartData[0]['total'] as num).toStringAsFixed(1)
                    : dailyAverage.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    if (chartData.isEmpty) {
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

    final dayData = chartData[0];
    final breakfast = (dayData['breakfast'] as num).toDouble();
    final lunch = (dayData['lunch'] as num).toDouble();
    final dinner = (dayData['dinner'] as num).toDouble();
    final snacks = (dayData['snacks'] as num).toDouble();
    final total = (dayData['total'] as num).toDouble();

    if (total == 0) {
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

    final breakfastPercent = breakfast / total;
    final lunchPercent = lunch / total;
    final dinnerPercent = dinner / total;
    final snacksPercent = snacks / total;

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 50.r,
        sections: [
          if (breakfast > 0)
            PieChartSectionData(
              value: breakfast,
              title: '${(breakfastPercent * 100).toStringAsFixed(0)}%',
              color: Colors.blue[600]!,
              radius: 70.r,
              titleStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          if (lunch > 0)
            PieChartSectionData(
              value: lunch,
              title: '${(lunchPercent * 100).toStringAsFixed(0)}%',
              color: Colors.blue[800]!,
              radius: 70.r,
              titleStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          if (dinner > 0)
            PieChartSectionData(
              value: dinner,
              title: '${(dinnerPercent * 100).toStringAsFixed(0)}%',
              color: Colors.blue[400]!,
              radius: 70.r,
              titleStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          if (snacks > 0)
            PieChartSectionData(
              value: snacks,
              title: '${(snacksPercent * 100).toStringAsFixed(0)}%',
              color: Colors.lightBlue[300]!,
              radius: 70.r,
              titleStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
