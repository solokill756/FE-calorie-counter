import 'package:caloriecounter/src/modules/dashboard/data/models/dashboard_today_response.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/dash_card_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class MacrosCard extends StatelessWidget {
  const MacrosCard({super.key, required this.macros, this.onTap});

  final DashboardMacrosSection macros;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DashCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashCardTitleRow(
            context,
            icon: Icons.pie_chart_outline_rounded,
            title: 'Macros',
          ),
          Gap(14.h),
          _macroRow('Protein', macros.protein, macroProtein),
          Gap(12.h),
          _macroRow('Carbs', macros.carbs, macroCarbs),
          Gap(12.h),
          _macroRow('Fat', macros.fat, macroFat),
        ],
      ),
    );
  }

  Widget _macroRow(String label, DashboardMacroPair m, Color barColor) {
    final t = m.target <= 0 ? 1.0 : m.target;
    final p = (m.current / t).clamp(0.0, 1.0);
    final trackRadius = BorderRadius.circular(999);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            ),
            Text(
              '${m.current.toInt()}g / ${m.target.toInt()}g',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
        Gap(8.h),
        ClipRRect(
          borderRadius: trackRadius,
          child: SizedBox(
            height: 8.h,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: Colors.grey.shade200),
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: p,
                  child: ColoredBox(color: barColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
