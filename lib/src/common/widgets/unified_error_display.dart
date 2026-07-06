import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Unified error display widget for consistent error UI across all pages.
/// 
/// Usage:
/// ```dart
/// UnifiedErrorDisplay(
///   message: 'Unable to load data',
///   subtitle: 'Please retry to load.',
///   onRetry: () => context.read<MyCubit>().loadData(),
///   primaryColor: Theme.of(context).colorScheme.primary,
/// )
/// ```
class UnifiedErrorDisplay extends StatelessWidget {
  final String message;
  final String? subtitle;
  final VoidCallback? onRetry;
  final Color? primaryColor;

  const UnifiedErrorDisplay({
    super.key,
    required this.message,
    this.subtitle,
    this.onRetry,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = primaryColor ?? scheme.error;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error icon with background circle
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.error_outline,
                  size: 40.w,
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Error message
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),

            // Error subtitle
            if (subtitle != null)
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            SizedBox(height: 32.h),

            // Retry button
            if (onRetry != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: const Text('Retry'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
