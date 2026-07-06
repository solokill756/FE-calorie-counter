import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/food_detail_page.dart';

class FoodSectionWidget extends StatelessWidget {
  final String title;
  final String type;
  final List<String> foods;

  const FoodSectionWidget({
    super.key,
    required this.title,
    required this.type,
    required this.foods,
  });

  @override
  Widget build(BuildContext context) {
    // Limit to top 3 foods for preview
    final displayFoods = foods.take(3).toList();

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16.h),
          Container(height: 1, color: Colors.grey[300]),
          SizedBox(height: 16.h),

          // Food List
          if (displayFoods.isNotEmpty) ...[
            ...displayFoods.asMap().entries.map((entry) {
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

          if (displayFoods.isNotEmpty) SizedBox(height: 8.h),

          // View More button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FoodDetailPage(title: title, type: type),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'View More',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.sp,
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
