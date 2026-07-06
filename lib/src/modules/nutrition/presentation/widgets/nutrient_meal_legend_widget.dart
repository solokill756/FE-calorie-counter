import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NutrientMealLegendWidget extends StatelessWidget {
  final Map<String, Map<String, dynamic>> mealBreakdown;
  final String selectedPeriod;
  final String unit;

  const NutrientMealLegendWidget({
    super.key,
    required this.mealBreakdown,
    required this.selectedPeriod,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final meals = [
      mealBreakdown['breakfast']!,
      mealBreakdown['lunch']!,
      mealBreakdown['dinner']!,
      mealBreakdown['snacks']!,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // First column: Breakfast và Dinner
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NutrientMealItemWidget(
              meal: meals[0],
              selectedPeriod: selectedPeriod,
              unit: unit,
            ), // Breakfast
            SizedBox(height: 6.h),
            _NutrientMealItemWidget(
              meal: meals[2],
              selectedPeriod: selectedPeriod,
              unit: unit,
            ), // Dinner
          ],
        ),
        SizedBox(width: 40.w), // Space giữa 2 cột
        // Second column: Lunch và Snacks
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NutrientMealItemWidget(
              meal: meals[1],
              selectedPeriod: selectedPeriod,
              unit: unit,
            ), // Lunch
            SizedBox(height: 6.h),
            _NutrientMealItemWidget(
              meal: meals[3],
              selectedPeriod: selectedPeriod,
              unit: unit,
            ), // Snacks
          ],
        ),
      ],
    );
  }
}

class _NutrientMealItemWidget extends StatelessWidget {
  final Map<String, dynamic> meal;
  final String selectedPeriod;
  final String unit;

  const _NutrientMealItemWidget({
    required this.meal,
    required this.selectedPeriod,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: meal['color'] as Color,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              '${meal['name']}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.w), // Align với text ở trên
          child: Text(
            selectedPeriod == 'Day View'
                ? '${(meal['amount'] as double).toStringAsFixed(1)} $unit'
                : '${(meal['percentage'] as double).toStringAsFixed(0)}% (${(meal['amount'] as double).toStringAsFixed(1)} $unit)',
            style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}
