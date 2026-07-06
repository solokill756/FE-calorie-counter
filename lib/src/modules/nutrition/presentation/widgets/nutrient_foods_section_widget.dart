import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/foods_highest_detail_page.dart';
import '../application/nutrient_detail_cubit/nutrient_detail_cubit.dart';

class NutrientFoodsSectionWidget extends StatelessWidget {
  final String nutrientName;
  final List<String> foods;
  const NutrientFoodsSectionWidget({
    super.key,
    required this.nutrientName,
    required this.foods,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foods Highest In $nutrientName',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 16.h),

          // Divider
          Container(height: 1, color: Colors.grey[300]),

          SizedBox(height: 16.h),

          // Food List
          if (foods.isNotEmpty) ...[
            ...foods.take(3).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final food = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    // Rank number
                    Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: _getRankColor(index),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Food name
                    Expanded(
                      child: Text(
                        food,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ] else ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'No data available',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],

          if (foods.isNotEmpty) SizedBox(height: 8.h),

          // View More button
          GestureDetector(
            onTap: () {
              // Get current state from NutrientDetailCubit if available
              final cubit = context.read<NutrientDetailCubit>();
              final state = cubit.state;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodsHighestDetailPage(
                    title: 'Foods Highest In $nutrientName',
                    nutrientName: nutrientName,
                    initialFoods: foods,
                    initialDate: state.currentDate,
                    initialPeriod: state.selectedPeriod,
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'View More',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber[700]!; // Gold for #1
      case 1:
        return Colors.grey[600]!; // Silver for #2
      case 2:
        return Colors.brown[400]!; // Bronze for #3
      default:
        return Colors.blue[400]!;
    }
  }
}
