import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeightFormHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSave;
  final bool isEditMode;

  const WeightFormHeader({
    super.key,
    required this.onBack,
    required this.onSave,
    this.isEditMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(color: scheme.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              padding: EdgeInsets.all(8.w),
              child: Icon(
                Icons.arrow_back,
                size: 24.sp,
                color: scheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Text(
              isEditMode ? 'Edit Weight' : 'Add Weight',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: onSave,
            child: Container(
              padding: EdgeInsets.all(8.w),
              child: Icon(Icons.check, size: 24.sp, color: scheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
