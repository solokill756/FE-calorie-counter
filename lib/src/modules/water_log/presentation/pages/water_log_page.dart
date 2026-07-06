import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import 'package:caloriecounter/src/modules/water_log/data/models/water_log_models.dart';
import 'package:caloriecounter/src/modules/water_log/presentation/application/water_log_cubit.dart';
import 'package:caloriecounter/src/modules/water_log/presentation/utils/water_error_handler.dart';
import 'package:caloriecounter/src/modules/water_log/presentation/widgets/add_water_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

@RoutePage()
class WaterLogPage extends StatefulWidget {
  const WaterLogPage({super.key});

  @override
  State<WaterLogPage> createState() => _WaterLogPageState();
}

class _WaterLogPageState extends State<WaterLogPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<WaterLogCubit>().loadLastDays(14);
    });
  }

  Future<void> _addMl(int ml) async {
    try {
      await context.read<WaterLogCubit>().addMl(ml);
      if (!mounted) return;
      AppDialogs.showSuccessSnackBar(message: 'Added $ml ml');
    } catch (e) {
      if (mounted) {
        AppDialogs.showErrorSnackBar(
          message: mapWaterError(e),
        );
      }
    }
  }

  void _showAddWaterSheet() {
    final cubit = context.read<WaterLogCubit>();
    final state = cubit.state;
    showAddWaterSheet(
      context,
      onAdd: _addMl,
      isBusy: state is WaterLogViewLoading ||
          state is WaterLogViewInitial ||
          state is WaterLogViewAdding,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppShellUi.appBar(context, 'Water history'),
      backgroundColor: scheme.surfaceContainerLow,
      floatingActionButton: BlocBuilder<WaterLogCubit, WaterLogViewState>(
        builder: (context, state) {
          final disabled = state is WaterLogViewLoading ||
              state is WaterLogViewInitial ||
              state is WaterLogViewAdding;
          return FloatingActionButton.extended(
            onPressed: disabled ? null : _showAddWaterSheet,
            icon: Icon(Icons.water_drop_rounded, size: 22.sp),
            label: Text(
              'Log water',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            backgroundColor: scheme.tertiary,
            foregroundColor: scheme.onTertiary,
          );
        },
      ),
      body: BlocBuilder<WaterLogCubit, WaterLogViewState>(
        builder: (context, state) {
          if (state is WaterLogViewLoading || state is WaterLogViewInitial) {
            return Center(
              child: CircularProgressIndicator(color: scheme.primary),
            );
          }
          if (state is WaterLogViewError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(mapWaterError(state.message),
                        textAlign: TextAlign.center),
                    Gap(16.h),
                    FilledButton(
                      onPressed: () =>
                          context.read<WaterLogCubit>().loadLastDays(14),
                      style: AppShellUi.primaryCtaStyle(context),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is WaterLogViewAdding) {
            return Column(
              children: [
                LinearProgressIndicator(
                    color: scheme.tertiary, minHeight: 2),
                Expanded(
                  child: _buildHistoryList(context, state.rows, scheme),
                ),
              ],
            );
          }
          if (state is WaterLogViewLoaded) {
            return _buildHistoryList(context, state.rows, scheme);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHistoryList(
      BuildContext context, List<WaterHistoryRowDto> rows, ColorScheme scheme) {
    if (rows.isEmpty) {
      return RefreshIndicator(
        color: scheme.tertiary,
        onRefresh: () => context.read<WaterLogCubit>().loadLastDays(14),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppShellUi.pagePadding(),
          children: [
            Gap(48.h),
            Text(
              'No water entries in this range.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey.shade600,
              ),
            ),
            Gap(12.h),
            Text(
              'Tap Log water to add your first entry.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      color: scheme.tertiary,
      onRefresh: () => context.read<WaterLogCubit>().loadLastDays(14),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: AppShellUi.pagePadding(),
        itemCount: rows.length,
        separatorBuilder: (_, __) => Gap(10.h),
        itemBuilder: (context, i) {
          final r = rows[rows.length - 1 - i];
          DateTime? d;
          try {
            d = DateTime.parse('${r.date}T12:00:00Z');
          } catch (_) {}
          final label = d != null
              ? DateFormat.yMMMd().format(d.toLocal())
              : r.date;
          return Container(
            decoration: AppShellUi.cardDecoration(context),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.water_drop_outlined,
                  color: scheme.tertiary,
                  size: 28.sp,
                ),
                Gap(14.w),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
                Text(
                  '${r.amountMl} ml',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
