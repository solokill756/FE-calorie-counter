import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/nutrition_data_entity.dart';
import '../application/nutrition_cubit/nutrition_cubit.dart';
import '../pages/calorie_goals_page.dart';
import '../pages/food_detail_page.dart';

class DayViewWidget extends StatelessWidget {
  final NutritionState state;
  final BuildContext context;

  const DayViewWidget({super.key, required this.state, required this.context});

  @override
  Widget build(BuildContext context) {
    final selectedDate = state.currentDate;
    final todayData = state.weeklyData!.dailyData.firstWhere(
      (day) =>
          day.date.year == selectedDate.year &&
          day.date.month == selectedDate.month &&
          day.date.day == selectedDate.day,
      orElse: () => state.weeklyData!.dailyData.first,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(height: 8.h, color: Colors.grey[200]),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                // Circular Chart
                _buildDayCircularChart(todayData),
                SizedBox(height: 20.h),
                // Meal Legend
                _buildDayMealLegend(todayData),
                SizedBox(height: 20.h),
                // Divider
                Container(
                  height: 1,
                  color: Colors.grey[300],
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                ),
                SizedBox(height: 20.h),
                // Stats
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      _buildStatRowWithDivider(
                        'Total Calories',
                        todayData.totalCalories.toStringAsFixed(0),
                      ),
                      _buildStatRowWithDivider(
                        'Net Calories',
                        todayData.netCalories.toStringAsFixed(0),
                      ),
                      _buildStatRow(
                        'Goal',
                        todayData.goal.toStringAsFixed(0),
                        isGoal: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          Container(height: 8.h, color: Colors.grey[200]),
          _buildFoodsSection(state.foodsHighestInCalories),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildDayCircularChart(DailyCalorieData dayData) {
    final totalCalories = dayData.totalCalories;

    return SizedBox(
      width: 250.w,
      height: 250.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          Container(
            width: 250.w,
            height: 250.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[50],
            ),
          ),
          // Pie chart sections
          if (totalCalories > 0) _buildDayPieChart(dayData),
          // Center text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                totalCalories.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text(
                'cal',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayPieChart(DailyCalorieData dayData) {
    final total = dayData.totalCalories;
    if (total == 0) return SizedBox.shrink();

    final breakfastPercent = (dayData.breakfastCalories / total);
    final lunchPercent = (dayData.lunchCalories / total);
    final dinnerPercent = (dayData.dinnerCalories / total);
    final snacksPercent = (dayData.snacksCalories / total);

    return SizedBox(
      width: 250.w,
      height: 250.h,
      child: CustomPaint(
        painter: _DayPieChartPainter(
          breakfastPercent: breakfastPercent,
          lunchPercent: lunchPercent,
          dinnerPercent: dinnerPercent,
          snacksPercent: snacksPercent,
        ),
      ),
    );
  }

  Widget _buildDayMealLegend(DailyCalorieData dayData) {
    final total = dayData.totalCalories;
    if (total == 0) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Row(
              children: [
                _buildDayLegendItem(
                  color: Colors.blue[600]!,
                  label: 'Breakfast',
                  percentage: '0% (0 cal)',
                ),
                SizedBox(width: 40.w),
                _buildDayLegendItem(
                  color: Colors.blue[800]!,
                  label: 'Lunch',
                  percentage: '0% (0 cal)',
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                _buildDayLegendItem(
                  color: Colors.blue[400]!,
                  label: 'Dinner',
                  percentage: '0% (0 cal)',
                ),
                SizedBox(width: 40.w),
                _buildDayLegendItem(
                  color: Colors.blue[300]!,
                  label: 'Snacks',
                  percentage: '0% (0 cal)',
                ),
              ],
            ),
          ],
        ),
      );
    }

    final breakfastPercent = (dayData.breakfastCalories / total * 100);
    final lunchPercent = (dayData.lunchCalories / total * 100);
    final dinnerPercent = (dayData.dinnerCalories / total * 100);
    final snacksPercent = (dayData.snacksCalories / total * 100);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              _buildDayLegendItem(
                color: Colors.blue[600]!,
                label: 'Breakfast',
                percentage:
                    '${breakfastPercent.toStringAsFixed(0)}% (${dayData.breakfastCalories.toStringAsFixed(0)} cal)',
              ),
              SizedBox(width: 40.w),
              _buildDayLegendItem(
                color: Colors.blue[800]!,
                label: 'Lunch',
                percentage:
                    '${lunchPercent.toStringAsFixed(0)}% (${dayData.lunchCalories.toStringAsFixed(0)} cal)',
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildDayLegendItem(
                color: Colors.blue[400]!,
                label: 'Dinner',
                percentage:
                    '${dinnerPercent.toStringAsFixed(0)}% (${dayData.dinnerCalories.toStringAsFixed(0)} cal)',
              ),
              SizedBox(width: 40.w),
              _buildDayLegendItem(
                color: Colors.blue[300]!,
                label: 'Snacks',
                percentage:
                    '${snacksPercent.toStringAsFixed(0)}% (${dayData.snacksCalories.toStringAsFixed(0)} cal)',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayLegendItem({
    required Color color,
    required String label,
    required String percentage,
  }) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  percentage,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, {bool isGoal = false}) {
    return GestureDetector(
      onTap: isGoal
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalorieGoalsPage(),
                ),
              );
            }
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: isGoal ? Colors.blue : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRowWithDivider(
    String label,
    String value, {
    bool isGoal = false,
  }) {
    return Column(
      children: [
        _buildStatRow(label, value, isGoal: isGoal),
        SizedBox(height: 12.h),
        Container(height: 1, color: Colors.grey[300]),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildFoodsSection(List<String> foods) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foods Highest In Calories',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16.h),
          if (foods.isNotEmpty)
            ...foods.map(
              (food) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  food,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ),
            ),
          SizedBox(height: 16.h),

          // Divider between foods list and "View More"
          Container(height: 1, color: Colors.grey[300]),

          SizedBox(height: 16.h),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailPage(
                    title: 'Foods Highest In Calories',
                    type: 'calories',
                  ),
                ),
              );
            },
            child: Text(
              'View More',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Day View Pie Chart
class _DayPieChartPainter extends CustomPainter {
  final double breakfastPercent;
  final double lunchPercent;
  final double dinnerPercent;
  final double snacksPercent;

  _DayPieChartPainter({
    required this.breakfastPercent,
    required this.lunchPercent,
    required this.dinnerPercent,
    required this.snacksPercent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    double startAngle = -90 * (3.14159 / 180); // Start from top

    // Breakfast
    if (breakfastPercent > 0) {
      final sweepAngle = breakfastPercent * 2 * 3.14159;
      final paint = Paint()
        ..color = Colors.blue[600]!
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Lunch
    if (lunchPercent > 0) {
      final sweepAngle = lunchPercent * 2 * 3.14159;
      final paint = Paint()
        ..color = Colors.blue[800]!
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Dinner
    if (dinnerPercent > 0) {
      final sweepAngle = dinnerPercent * 2 * 3.14159;
      final paint = Paint()
        ..color = Colors.blue[400]!
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Snacks
    if (snacksPercent > 0) {
      final sweepAngle = snacksPercent * 2 * 3.14159;
      final paint = Paint()
        ..color = Colors.blue[300]!
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
