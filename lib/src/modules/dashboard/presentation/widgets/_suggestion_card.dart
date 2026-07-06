import 'package:caloriecounter/src/modules/dashboard/data/models/dashboard_today_response.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/dash_card_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({super.key, required this.suggestion, required this.isLoading});

  final DashboardAiSuggestion suggestion;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DashCard(
      decoration: dashAiCardDecoration(scheme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashCardTitleRow(
            context,
            icon: Icons.tips_and_updates_outlined,
            title: 'Daily suggestion',
          ),
          Gap(10.h),
          if (isLoading) ...[
            Row(
              children: [
                SizedBox(
                  width: 18.r,
                  height: 18.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: scheme.primary,
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    'Generating your suggestion...',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: scheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            Gap(10.h),
          ],
          Text(
            suggestion.title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          Gap(6.h),
          Text(
            suggestion.message,
            style: TextStyle(
              fontSize: 14.sp,
              color: scheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
