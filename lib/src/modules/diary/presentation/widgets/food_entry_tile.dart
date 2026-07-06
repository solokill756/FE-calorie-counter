import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/diary_entity.dart';

class FoodEntryTile extends StatelessWidget {
  const FoodEntryTile({
    super.key,
    required this.food,
    this.onDelete,
    this.isLocked = false,
  });

  final FoodEntry food;
  final void Function(String foodId)? onDelete;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${food.quantity} ${food.unit}',
                  style:
                      TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            '${food.calories} cal',
            style:
                TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 8.w),
          if (!isLocked)
            GestureDetector(
              onTap: () => onDelete?.call(food.id),
              child: Icon(Icons.close, size: 20.sp, color: Colors.grey[400]),
            ),
        ],
      ),
    );
  }
}
