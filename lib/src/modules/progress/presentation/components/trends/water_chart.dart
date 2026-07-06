import 'dart:math' as math;

import 'package:caloriecounter/src/modules/progress/domain/models/progress_trends_models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'empty_chart_widget.dart';

class WaterChart extends StatelessWidget {
  const WaterChart({super.key, required this.days, required this.scheme});

  final List<ProgressTrendDay> days;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) {
      return EmptyChartWidget(scheme: scheme);
    }
    final spots = <FlSpot>[];
    for (var i = 0; i < days.length; i++) {
      spots.add(FlSpot(i.toDouble(), days[i].waterMl.toDouble()));
    }
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    final hi = maxY <= 0 ? 2000.0 : maxY * 1.15;
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              interval: math.max(1, (days.length / 5).ceil()).toDouble(),
              getTitlesWidget: (v, meta) {
                final i = v.toInt();
                if (i < 0 || i >= days.length) return const SizedBox.shrink();
                final d = days[i].date;
                final short = d.length >= 10 ? d.substring(5) : d;
                return Text(short, style: TextStyle(fontSize: 8.sp, color: scheme.onSurfaceVariant));
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (v, m) => Text(
                v.toInt().toString(),
                style: TextStyle(fontSize: 8.sp, color: scheme.onSurfaceVariant),
              ),
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (days.length - 1).toDouble().clamp(0, double.infinity),
        minY: 0,
        maxY: hi,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: scheme.tertiary,
            barWidth: 2,
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
