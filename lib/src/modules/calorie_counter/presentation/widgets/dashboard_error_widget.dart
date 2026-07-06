import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardErrorWidget extends StatelessWidget {
  final String message;

  const DashboardErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 800),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: Opacity(
              opacity: value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 48.sp, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(message, style: TextStyle(fontSize: 16.sp)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
