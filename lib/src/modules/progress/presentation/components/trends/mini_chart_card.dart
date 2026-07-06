import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiniChartCard extends StatelessWidget {
  const MiniChartCard({
    super.key,
    required this.title,
    required this.scheme,
    required this.child,
  });

  final String title;
  final ColorScheme scheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: scheme.surfaceContainerLowest,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: scheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(height: 200.h, child: child),
          ],
        ),
      ),
    );
  }
}
