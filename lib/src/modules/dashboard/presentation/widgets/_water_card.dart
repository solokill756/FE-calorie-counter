import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:caloriecounter/src/modules/dashboard/data/models/dashboard_today_response.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/application/dashboard_cubit.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/dash_card_helpers.dart';
import 'package:caloriecounter/src/modules/water_log/presentation/utils/water_error_handler.dart';
import 'package:caloriecounter/src/modules/water_log/presentation/widgets/add_water_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WaterCard extends StatefulWidget {
  const WaterCard({super.key, required this.water, this.onTap});

  final DashboardWaterSection water;
  final VoidCallback? onTap;

  @override
  State<WaterCard> createState() => _WaterCardState();
}

class _WaterCardState extends State<WaterCard> {
  bool _busy = false;

  Future<void> _addMl(int ml) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await context.read<DashboardCubit>().addWater(ml);
      if (mounted) {
        AppDialogs.showSuccessSnackBar(message: 'Added $ml ml');
      }
    } catch (e) {
      if (mounted) {
        AppDialogs.showErrorSnackBar(
          message: mapWaterError(e),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _onAddWaterTap(int ml) async {
    await _addMl(ml);
  }

  @override
  Widget build(BuildContext context) {
    final water = widget.water;
    final scheme = Theme.of(context).colorScheme;
    final t = water.targetMl <= 0 ? 1 : water.targetMl;
    final p = (water.currentMl / t).clamp(0.0, 1.0);
    return DashCard(
      onTap: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: widget.onTap,
            borderRadius: dashCardRadius(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dashCardTitleRow(
                  context,
                  icon: Icons.water_drop_outlined,
                  title: 'Water',
                ),
                Gap(10.h),
                Text(
                  '${water.currentMl} / ${water.targetMl} ml',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(10.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: SizedBox(
                    height: 10.h,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ColoredBox(color: scheme.outlineVariant),
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: p,
                          child: ColoredBox(color: scheme.tertiary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(12.h),
          if (_busy)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: const LinearProgressIndicator(minHeight: 2),
            ),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final ml in [250, 500, 1000])
                SizedBox(
                  width: 92.w,
                  child: OutlinedButton(
                    onPressed: _busy ? null : () => _addMl(ml),
                    style: AppShellUi.outlinedActionStyle(context),
                    child: Text(
                      '+$ml',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Gap(4.h),
          Row(
            children: [
              TextButton(
                onPressed: _busy
                    ? null
                    : () => context.router.push(const WaterLogRoute()),
                child: Text(
                  'History',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: scheme.primary,
                  ),
                ),
              ),
              TextButton(
                onPressed: _busy
                    ? null
                    : () => showAddWaterSheet(
                          context,
                          onAdd: _onAddWaterTap,
                          isBusy: _busy,
                        ),
                child: Text(
                  'Custom',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: scheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
