import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/application/dashboard_cubit.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/view/dashboard_home_view.dart';
import 'package:caloriecounter/src/modules/notifications/presentation/application/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    this.onNavigateToDiary,
    this.onNavigateToProgress,
  });

  final VoidCallback? onNavigateToDiary;
  final VoidCallback? onNavigateToProgress;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin<DashboardPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<DashboardCubit>().loadTodayDashboard();
      context.read<NotificationsCubit>().refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DashboardHomeView(
      onNavigateToDiary: widget.onNavigateToDiary,
      onNavigateToProgress: widget.onNavigateToProgress,
    );
  }
}
