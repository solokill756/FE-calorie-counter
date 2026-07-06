import 'dart:math' as math;

import 'package:caloriecounter/src/modules/progress/domain/models/progress_trends_models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({super.key, required this.days, required this.scheme});

  final List<ProgressTrendDay> days;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final pts = <FlSpot>[];
    for (var i = 0; i < days.length; i++) {
      final w = days[i].weightKg;
      if (w != null) {
        pts.add(FlSpot(i.toDouble(), w));
      }
    }
    if (pts.isEmpty) {
      return Center(
        child: Text(
          'No weight entries in this range',
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13.sp),
        ),
      );
    }
    final ys = pts.map((p) => p.y).toList();
    var minY = ys.reduce((a, b) => a < b ? a : b);
    var maxY = ys.reduce((a, b) => a > b ? a : b);
    final pad = (maxY - minY).abs() < 0.01 ? 1.0 : (maxY - minY) * 0.15;
    minY -= pad;
    maxY += pad;
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
              reservedSize: 40,
              getTitlesWidget: (v, m) => Text(
                v.toStringAsFixed(1),
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
        minY: minY,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: pts,
            isCurved: true,
            color: scheme.secondary,
            barWidth: 2,
            dotData: FlDotData(
              show: true,
              getDotPainter: (s, p, b, i) => FlDotCirclePainter(
                radius: 3,
                color: scheme.secondary,
                strokeWidth: 1,
                strokeColor: scheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
