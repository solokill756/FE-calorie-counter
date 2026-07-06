import 'package:caloriecounter/src/common/widgets/data_fetch_loading_widget.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:caloriecounter/src/core/utils/error_translator.dart';
import 'package:caloriecounter/src/common/widgets/unified_error_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:caloriecounter/src/modules/progress/domain/models/progress_trends_models.dart';
import '../application/progress_trends_cubit/progress_trends_cubit.dart';
import '../components/trends/summary_card.dart';
import '../components/trends/insight_card.dart';
import '../components/trends/mini_chart_card.dart';
import '../components/trends/net_calories_chart.dart';
import '../components/trends/water_chart.dart';
import '../components/trends/weight_chart.dart';
import '../components/trends/rule_based_insight.dart';

class ProgressTrendsTab extends StatelessWidget {
  const ProgressTrendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BlocBuilder<ProgressTrendsCubit, ProgressTrendsState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => DataFetchLoadingWidget(
            state: 'loading',
            loadingMessage: 'Loading health trends...',
            loadingType: LoadingType.circular,
            primaryColor: scheme.primary,
          ),
          error: (message) => UnifiedErrorDisplay(
            message: ErrorTranslator.getMessage(message),
            subtitle: 'Please retry to load your health trends.',
            onRetry: () => context.read<ProgressTrendsCubit>().loadTrailingDays(),
            primaryColor: scheme.primary,
          ),
          loaded: (data) => _TrendsScrollContent(data: data),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _TrendsScrollContent extends StatelessWidget {
  const _TrendsScrollContent({required this.data});

  final ProgressTrendsResponse data;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final insight = ruleBasedProgressInsight(data);
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 90.h),
        children: [
          SummaryCard(data: data, scheme: scheme),
          SizedBox(height: 12.h),
          InsightCard(text: insight, scheme: scheme),
          SizedBox(height: 16.h),
          MiniChartCard(
            title: 'Net calories (in − burned)',
            scheme: scheme,
            child: NetCaloriesChart(days: data.days, scheme: scheme),
          ),
          SizedBox(height: 12.h),
          MiniChartCard(
            title: 'Water (ml)',
            scheme: scheme,
            child: WaterChart(days: data.days, scheme: scheme),
          ),
          SizedBox(height: 12.h),
          MiniChartCard(
            title: 'Weight (kg)',
            scheme: scheme,
            child: WeightChart(days: data.days, scheme: scheme),
          ),
        ],
      ),
    );
  }
}
