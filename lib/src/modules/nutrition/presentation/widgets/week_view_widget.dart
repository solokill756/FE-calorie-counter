import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../application/nutrition_cubit/nutrition_cubit.dart';
import '../widgets/nutrition_chart_widget.dart';
import '../pages/calorie_goals_page.dart';
import '../widgets/food_section_widget.dart';

class WeekViewWidget extends StatelessWidget {
  final NutritionState state;

  const WeekViewWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(height: 8.h, color: Colors.grey[200]),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: _buildToggleButtons(context),
                ),
                NutritionChartWidget(
                  data: state.weeklyData!.dailyData,
                  isNetMode: state.isNetMode,
                ),
                if (!state.isNetMode) _buildMealLegend(context),
                Container(
                  height: 1,
                  color: Colors.grey[300],
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    children: [
                      _buildStatRowWithDivider(
                        context,
                        'Net Calories Under Weekly Goal',
                        state.weeklyData!.netCaloriesUnderGoal.toStringAsFixed(
                          0,
                        ),
                      ),
                      _buildStatRowWithDivider(
                        context,
                        'Net Average',
                        state.weeklyData!.netAverage.toStringAsFixed(0),
                      ),
                      _buildStatRow(
                        context,
                        'Goal',
                        state.weeklyData!.weeklyGoal.toStringAsFixed(0),
                        isGoal: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(height: 8.h, color: Colors.grey[200]),
          FoodSectionWidget(
            title: 'Foods Highest In Calories',
            type: 'calories',
            foods: state.foodsHighestInCalories,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildToggleButtons(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: BlocConsumer<NutritionCubit, NutritionState>(
              listener: (context, state) {
                // Optional: Add any side effects here
              },
              builder: (context, state) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildToggleButton(
                      context,
                      'Total',
                      !state.isNetMode,
                      false,
                    ),
                    _buildToggleButton(context, 'Net', state.isNetMode, true),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(
    BuildContext context,
    String text,
    bool isSelected,
    bool targetNetMode,
  ) {
    return GestureDetector(
      onTap: () {
        final cubit = BlocProvider.of<NutritionCubit>(context);
        cubit.setCalorieMode(targetNetMode);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black87 : Colors.grey[600],
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildMealLegend(BuildContext context) {
    if (state.weeklyData == null) {
      return SizedBox.shrink();
    }

    // Tính tổng calories cho từng meal từ tất cả các ngày trong tuần
    double totalBreakfast = 0;
    double totalLunch = 0;
    double totalDinner = 0;
    double totalSnacks = 0;

    for (var dailyData in state.weeklyData!.dailyData) {
      totalBreakfast += dailyData.breakfastCalories;
      totalLunch += dailyData.lunchCalories;
      totalDinner += dailyData.dinnerCalories;
      totalSnacks += dailyData.snacksCalories;
    }

    // Tính tổng calories của tất cả meals
    double totalMealCalories =
        totalBreakfast + totalLunch + totalDinner + totalSnacks;

    // Tính phần trăm cho mỗi meal
    double breakfastPercent = totalMealCalories > 0
        ? (totalBreakfast / totalMealCalories * 100)
        : 0;
    double lunchPercent = totalMealCalories > 0
        ? (totalLunch / totalMealCalories * 100)
        : 0;
    double dinnerPercent = totalMealCalories > 0
        ? (totalDinner / totalMealCalories * 100)
        : 0;
    double snacksPercent = totalMealCalories > 0
        ? (totalSnacks / totalMealCalories * 100)
        : 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          Row(
            children: [
              _buildLegendItem(
                color: Colors.blue[600]!,
                label: 'Breakfast',
                percentage:
                    '${breakfastPercent.toStringAsFixed(0)}% (${totalBreakfast.toStringAsFixed(0)} cal)',
              ),
              SizedBox(width: 40.w),
              _buildLegendItem(
                color: Colors.blue[800]!,
                label: 'Lunch',
                percentage:
                    '${lunchPercent.toStringAsFixed(0)}% (${totalLunch.toStringAsFixed(0)} cal)',
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildLegendItem(
                color: Colors.blue[400]!,
                label: 'Dinner',
                percentage:
                    '${dinnerPercent.toStringAsFixed(0)}% (${totalDinner.toStringAsFixed(0)} cal)',
              ),
              SizedBox(width: 40.w),
              _buildLegendItem(
                color: Colors.blue[300]!,
                label: 'Snacks',
                percentage:
                    '${snacksPercent.toStringAsFixed(0)}% (${totalSnacks.toStringAsFixed(0)} cal)',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
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

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value, {
    bool isGoal = false,
  }) {
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
    BuildContext context,
    String label,
    String value, {
    bool isGoal = false,
  }) {
    return Column(
      children: [
        _buildStatRow(context, label, value, isGoal: isGoal),
        SizedBox(height: 12.h),
        Container(height: 1, color: Colors.grey[300]),
        SizedBox(height: 12.h),
      ],
    );
  }
}
