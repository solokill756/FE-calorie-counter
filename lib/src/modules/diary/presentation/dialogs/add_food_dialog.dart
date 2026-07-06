import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFoodDialog extends StatelessWidget {
  const AddFoodDialog({
    super.key,
    required this.onLogFood,
    required this.onQuickAdd,
  });

  final VoidCallback onLogFood;
  final VoidCallback onQuickAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Text('Add Food',
              style:
                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 24.h),
          _option(
            context,
            Icons.restaurant,
            'Log Food',
            'Search and log from food database',
            () {
              Navigator.pop(context);
              onLogFood();
            },
          ),
          SizedBox(height: 12.h),
          _option(
            context,
            Icons.flash_on,
            'Quick Add',
            'Quickly add calories and macros',
            () {
              Navigator.pop(context);
              onQuickAdd();
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _option(BuildContext ctx, IconData icon, String title,
      String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: Colors.blue[600], size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4.h),
                  Text(subtitle,
                      style:
                          TextStyle(fontSize: 14.sp, color: Colors.grey[600])),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
