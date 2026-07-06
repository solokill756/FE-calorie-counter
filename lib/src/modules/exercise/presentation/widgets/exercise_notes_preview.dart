import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Read-only preview of catalog exercise [notes] (description / MET hint from server).
class ExerciseNotesPreview extends StatelessWidget {
  const ExerciseNotesPreview({
    super.key,
    required this.notes,
    this.maxLines = 2,
    this.compact = false,
  });

  final String? notes;
  final int maxLines;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final text = notes?.trim();
    if (text == null || text.isEmpty) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final style = TextStyle(
      fontSize: compact ? 12.sp : 13.sp,
      color: compact ? Colors.grey[600] : Colors.grey[700],
      height: 1.35,
    );

    if (compact) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: style,
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.notes_outlined, size: 18.sp, color: scheme.primary),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(text, style: style),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
