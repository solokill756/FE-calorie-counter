import 'package:caloriecounter/src/modules/progress/domain/models/progress_trends_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.data, required this.scheme});

  final ProgressTrendsResponse data;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final s = data.summary;
    return Card(
      color: scheme.surfaceContainerLowest,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: _KpiTile(
                label: 'Adherence',
                value: '${s.adherenceScore}%',
                scheme: scheme,
              ),
            ),
            Expanded(
              child: _KpiTile(
                label: 'Diary streak',
                value: '${s.currentStreak} d',
                scheme: scheme,
              ),
            ),
            Expanded(
              child: _KpiTile(
                label: 'Best streak',
                value: '${s.bestStreak} d',
                scheme: scheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KpiTile extends StatelessWidget {
  const _KpiTile({
    required this.label,
    required this.value,
    required this.scheme,
  });

  final String label;
  final String value;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
      ],
    );
  }
}
