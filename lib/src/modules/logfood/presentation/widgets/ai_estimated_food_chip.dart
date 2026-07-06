import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Tag for foods from meal-plan AI persistence (`Category = AI Estimated` → API `brandName`).
class AiEstimatedFoodChip extends StatelessWidget {
  const AiEstimatedFoodChip({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message:
          'Thực phẩm do AI ước lượng dinh dưỡng; chưa xác thực với cơ sở dữ liệu chuẩn.',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6.w : 8.w,
          vertical: compact ? 2.h : 4.h,
        ),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: Colors.deepPurple.shade200),
        ),
        child: Text(
          compact ? 'AI' : 'AI ước lượng',
          style: TextStyle(
            fontSize: (compact ? 10 : 11).sp,
            fontWeight: FontWeight.w700,
            color: Colors.deepPurple.shade800,
          ),
        ),
      ),
    );
  }
}
