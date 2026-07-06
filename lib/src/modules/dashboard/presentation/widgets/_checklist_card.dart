import 'package:caloriecounter/src/modules/dashboard/data/models/dashboard_today_response.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/dash_card_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ChecklistCard extends StatelessWidget {
  const ChecklistCard({super.key, required this.checklist});

  final DashboardChecklist checklist;

  @override
  Widget build(BuildContext context) {
    return DashCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashCardTitleRow(
            context,
            icon: Icons.checklist_rtl_rounded,
            title: 'Daily checklist',
          ),
          Gap(12.h),
          _check(context, 'Logged foods / meals', checklist.foodLogged),
          _check(context, 'Logged water', checklist.waterLogged),
          _check(context, 'Logged exercise', checklist.exerciseLogged),
          _check(context, 'Added weight', checklist.weightLogged),
        ],
      ),
    );
  }

  Widget _check(BuildContext context, String label, bool done) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 26.r,
            height: 26.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? scheme.primary : Colors.transparent,
              border: Border.all(
                color: done ? scheme.primary : scheme.outline,
                width: 2,
              ),
            ),
            child: done
                ? Icon(
                    Icons.check_rounded,
                    size: 16.sp,
                    color: scheme.onPrimary,
                  )
                : null,
          ),
          Gap(12.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: done ? Colors.grey.shade800 : Colors.grey.shade700,
                fontWeight: done ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
