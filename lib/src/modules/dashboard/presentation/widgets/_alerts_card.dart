import 'package:caloriecounter/src/modules/dashboard/data/models/dashboard_today_response.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/dash_card_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({super.key, required this.alerts});

  final List<DashboardAlertItem> alerts;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DashCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashCardTitleRow(
            context,
            icon: Icons.health_and_safety_outlined,
            title: 'Health alerts',
          ),
          Gap(12.h),
          if (alerts.isEmpty)
            Text(
              'No health alerts today',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            )
          else
            ...alerts
                .take(3)
                .map(
                  (a) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: a.isCritical
                            ? Colors.red.shade50
                            : Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: (a.isCritical ? Colors.red : Colors.orange)
                              .withValues(alpha: 0.25),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              a.isCritical
                                  ? Icons.error_outline
                                  : Icons.warning_amber_rounded,
                              color: a.isCritical
                                  ? Colors.red.shade700
                                  : Colors.orange.shade800,
                              size: 22.sp,
                            ),
                            Gap(10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    a.displayTitle,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                      height: 1.3,
                                      color: scheme.onSurface,
                                    ),
                                  ),
                                  Gap(4.h),
                                  Text(
                                    a.message,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      height: 1.4,
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                  if (a.hasAmountLine) ...[
                                    Gap(6.h),
                                    Text(
                                      a.amountLine,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: a.isCritical
                                            ? Colors.red.shade700
                                            : Colors.orange.shade800,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

extension DashboardAlertItemView on DashboardAlertItem {
  bool get isCritical => severity == 'critical' || type == 'red';

  String get displayTitle {
    if (title.trim().isNotEmpty) return title.trim();
    return isCritical ? 'High $_displayNutrient' : 'Notice';
  }

  bool get hasAmountLine => current != null && limit != null;

  String get amountLine {
    if (!hasAmountLine) return '';
    final suffix = unit.trim().isEmpty ? '' : ' ${unit.trim()}';
    final pct = percent == null ? '' : ' (${percent!.round()}%)';
    return '${_formatAmount(current!)} / ${_formatAmount(limit!)}$suffix$pct';
  }

  String get _displayNutrient {
    switch (nutrientType) {
      case 'saturatedFat':
        return 'saturated fat';
      case 'sodium':
        return 'sodium';
      case 'cholesterol':
        return 'cholesterol';
      case 'calories':
        return 'calories';
      case 'protein':
        return 'protein';
      case 'fiber':
        return 'fiber';
      case 'potassium':
        return 'potassium';
      default:
        return nutrientType.isEmpty ? 'alert' : nutrientType;
    }
  }

  String _formatAmount(double value) {
    if (value == value.roundToDouble()) return value.round().toString();
    return value.toStringAsFixed(1);
  }
}
