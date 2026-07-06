import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../modules/progress/presentation/application/progress_cubit/progress_cubit.dart';
import '../../modules/progress/domain/entities/progress_entity.dart';

class WeightChartsWidget extends StatefulWidget {
  const WeightChartsWidget({super.key, this.onAddTap, this.onViewDetailsTap});

  final VoidCallback? onAddTap;
  final VoidCallback? onViewDetailsTap;

  @override
  State<WeightChartsWidget> createState() => _WeightChartsWidgetState();
}

class _WeightChartsWidgetState extends State<WeightChartsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          BlocBuilder<ProgressCubit, ProgressState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => SizedBox(
                  height: 250.h,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (message) => SizedBox(
                  height: 250.h,
                  child: Center(child: Text('Error: $message')),
                ),
                loaded: (stats) => _buildChartCard('Weight', stats),
                orElse: () => SizedBox(
                  height: 250.h,
                  child: Center(child: Text('No data')),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(String chartType, ProgressStats stats) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  chartType,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Last 30 days',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
            ),
            SizedBox(height: 12.h),
            SizedBox(height: 140.h, child: _buildChart(stats, chartType)),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {
                widget.onViewDetailsTap?.call();
              },
              child: Center(
                child: Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(ProgressStats stats, String chartType) {
    if (stats.entries.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        ),
      );
    }

    final chartData = stats.chartData;
    final spots = chartData.spots;
    final minY = chartData.minY;
    final maxY = chartData.maxY;

    // Determine color based on chart type
    Color chartColor = Colors.blue;
    if (chartType == 'Weight') {
      chartColor = Colors.green;
    }

    // Build unique dates map
    final uniqueDates = <int, String>{};
    for (var i = 0; i < stats.entries.length; i++) {
      if (!uniqueDates.containsValue(
        DateFormat('dd/MM').format(stats.entries[i].date),
      )) {
        uniqueDates[i] = DateFormat('dd/MM').format(stats.entries[i].date);
      }
    }

    return LineChart(
      LineChartData(
        maxY: maxY,
        minY: minY,
        maxX: spots.length - 1.0,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey[300]!, strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40.w,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(0),
                  style: TextStyle(fontSize: 9.sp, color: Colors.grey[600]),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (uniqueDates.containsKey(index)) {
                  return Text(
                    uniqueDates[index]!,
                    style: TextStyle(fontSize: 8.sp, color: Colors.grey[600]),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: chartColor,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final index = spot.x.toInt();
                final date = index < stats.entries.length
                    ? DateFormat('dd/MM').format(stats.entries[index].date)
                    : '';
                return LineTooltipItem(
                  '${spot.y.toStringAsFixed(1)}\n$date',
                  TextStyle(
                    color: chartColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
