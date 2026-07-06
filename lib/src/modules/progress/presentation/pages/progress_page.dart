import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/widgets/data_fetch_loading_widget.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:caloriecounter/src/core/utils/error_translator.dart';
import 'package:caloriecounter/src/common/widgets/unified_error_display.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/progress_entity.dart';
import '../../data/service/csv_export_service.dart';
import '../application/progress_cubit/progress_cubit.dart';
import '../application/progress_trends_cubit/progress_trends_cubit.dart';
import 'progress_trends_tab.dart';

@RoutePage()
class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  String selectedMeasurement = 'Weights';
  DateTime? startDate;
  DateTime? endDate;
  ProgressStats? _progressStats;
  int _page = 1; // Current page (sent to server)
  final int _entriesPerPage = 10; // Items per page (sent to server)

  late TabController _tabController;
  int _previousTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _previousTabIndex = _tabController.index;
    _tabController.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProgressTrendsCubit>().loadTrailingDays();
    });
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging && mounted) {
      final i = _tabController.index;
      if (i == 0 && _previousTabIndex != 0) {
        context.read<ProgressTrendsCubit>().loadTrailingDays();
      }
      if (i == 1 && _previousTabIndex != 1) {
        context.read<ProgressCubit>().loadProgressData(
          page: _page,
          pageSize: _entriesPerPage,
          type: selectedMeasurement,
          startDate: startDate,
          endDate: endDate,
        );
      }
      _previousTabIndex = i;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: scheme.surfaceContainerLowest,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Progress',
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: scheme.primary,
          unselectedLabelColor: scheme.onSurfaceVariant,
          tabs: const [
            Tab(text: 'Trends'),
            Tab(text: 'Body'),
          ],
        ),
        actions: [
          if (_tabController.index == 1) ...[
            IconButton(
              icon: Icon(Icons.add, color: scheme.onSurface),
              onPressed: () {
                if (selectedMeasurement == 'Weights') {
                  context.router.push(WeightFormRoute());
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.ios_share, color: scheme.onSurface),
              onPressed: () => _exportProgressToCsv(),
            ),
          ] else
            IconButton(
              icon: Icon(Icons.refresh, color: scheme.onSurface),
              onPressed: () =>
                  context.read<ProgressTrendsCubit>().loadTrailingDays(),
            ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const ProgressTrendsTab(),
          Column(
            children: [
              // Selector - Outside BlocBuilder, always visible and independent
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    // Measurement Selector
                    Expanded(
                      child: _buildSelector(
                        icon: _getMeasurementIcon(selectedMeasurement),
                        text: selectedMeasurement,
                        onTap: _showMeasurementSelector,
                        isSelected: true,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // Date Range Selector
                    Expanded(
                      child: _buildSelector(
                        icon: Icons.calendar_month,
                        text: _getDateRangeText(),
                        onTap: _showDateRangeSelector,
                        isSelected: false,
                      ),
                    ),
                  ],
                ),
              ),

              // BlocBuilder for rest of content
              Expanded(
                child: BlocListener<ProgressCubit, ProgressState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      adding: () {
                        context.showLoadingDialog(
                          message: 'Adding progress entry...',
                        );
                      },
                      addedSuccess: (message) {
                        context.hideLoadingDialog();
                        AppDialogs.showSuccessSnackBar(message: message);
                      },
                      updatedSuccess: (message) {
                        context.hideLoadingDialog();
                        AppDialogs.showSuccessSnackBar(message: message);
                      },
                      addedFailure: (message) {
                        context.hideLoadingDialog();
                        AppDialogs.showErrorSnackBar(message: message);
                      },
                      updatedFailure: (message) {
                        context.hideLoadingDialog();
                        AppDialogs.showErrorSnackBar(message: message);
                      },
                      orElse: () {},
                    );
                  },
                  child: BlocBuilder<ProgressCubit, ProgressState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () => DataFetchLoadingWidget(
                          state: 'loading',
                          loadingMessage: 'Loading progress data...',
                          loadingType: LoadingType.circular,
                          primaryColor: Colors.blue,
                        ),
                        error: (message) => UnifiedErrorDisplay(
                          message: ErrorTranslator.getMessage(message),
                          subtitle: 'Please retry to load your progress.',
                          onRetry: () =>
                              context.read<ProgressCubit>().loadProgressData(
                                page: _page,
                                pageSize: _entriesPerPage,
                                type: selectedMeasurement,
                                startDate: startDate,
                                endDate: endDate,
                              ),
                          primaryColor: Theme.of(context).colorScheme.primary,
                        ),
                        loaded: (stats) {
                          _progressStats = stats;
                          return SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 16.h),

                                  // Stats Section
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    padding: EdgeInsets.all(20.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: _buildStatItem(
                                                '${_progressStats?.startValue.toStringAsFixed(1) ?? 'N/A'} ${_getMeasurementUnit(selectedMeasurement)}',
                                                'START',
                                              ),
                                            ),
                                            Expanded(
                                              child: _buildStatItem(
                                                '${_progressStats?.currentValue.toStringAsFixed(1) ?? 'N/A'} ${_getMeasurementUnit(selectedMeasurement)}',
                                                'CURRENT',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16.h),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Total Change',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 8.h),
                                              Text(
                                                _progressStats!.changeValue > 0
                                                    ? '+ ${_progressStats?.changeValue.toStringAsFixed(1) ?? 'N/A'} ${_getMeasurementUnit(selectedMeasurement)}'
                                                    : '${_progressStats?.changeValue.toStringAsFixed(1) ?? 'N/A'} ${_getMeasurementUnit(selectedMeasurement)}',
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: _getChangeColor(
                                                    _progressStats
                                                            ?.changeValue ??
                                                        0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                '${_progressStats?.changePercentage.toStringAsFixed(1) ?? 'N/A'}%',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 20.h),

                                  // Chart Section
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    height: 300.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 8.h,
                                            ),
                                            child: Text(
                                              '$selectedMeasurement Progress',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(child: _buildWeightChart()),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Entries Section
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    constraints: BoxConstraints(
                                      minHeight: 200.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(16.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Entries',
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (_progressStats != null &&
                                            _progressStats!.entries.isNotEmpty)
                                          ..._buildPaginatedEntries(),
                                        if (_progressStats == null)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 32.h,
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.hourglass_empty,
                                                    size: 48.sp,
                                                    color: Colors.grey[300],
                                                  ),
                                                  SizedBox(height: 12.h),
                                                  Text(
                                                    'Loading entries...',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if (_progressStats != null &&
                                            _progressStats!.entries.isEmpty)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 32.h,
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.inbox,
                                                    size: 48.sp,
                                                    color: Colors.grey[300],
                                                  ),
                                                  SizedBox(height: 12.h),
                                                  Text(
                                                    'No entries yet',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4.h),
                                                  Text(
                                                    'Start tracking your progress!',
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 90.h),
                                ],
                              ),
                            ),
                          );
                        },
                        orElse: () => SafeArea(
                          child: Center(child: Text('Unknown state')),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelector({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2196F3) : Colors.blue[50],
          borderRadius: BorderRadius.circular(8.r),
          border: isSelected ? null : Border.all(color: Colors.blue[200]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.blue,
              size: 16.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.blue,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down,
              color: isSelected ? Colors.white : Colors.blue,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildWeightChart() {
    final currentChartData = _progressStats?.chartData;

    final spots = currentChartData?.spots ?? [];
    final minY = currentChartData?.minY ?? 0;
    final maxY = currentChartData?.maxY ?? 0;
    final color = currentChartData?.color ?? Colors.transparent;
    final dates = _progressStats?.listDate.split(', ') ?? [];

    if (spots.isEmpty) {
      return Center(
        child: Text('No data available', style: TextStyle(color: Colors.grey)),
      );
    }

    final interval = (maxY - minY) / 4;
    final safeInterval = interval == 0 ? 1.0 : interval;

    // Dynamic maxX based on number of entries
    final maxX = spots.isNotEmpty ? spots.length - 1.0 : 4.0;

    // Build list of unique dates (only show first occurrence of each date)
    final uniqueDates = <int, String>{};
    final seenDates = <String>{};
    for (int i = 0; i < dates.length; i++) {
      if (!seenDates.contains(dates[i])) {
        uniqueDates[i] = dates[i];
        seenDates.add(dates[i]);
      }
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: safeInterval,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey[300]!, strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
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
              reservedSize: 50,
              interval: 1.0,
              getTitlesWidget: (double value, TitleMeta meta) {
                final index = value.toInt();
                // Show date only if it's in the uniqueDates map (first occurrence)
                if (uniqueDates.containsKey(index)) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      uniqueDates[index]!,
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        // Add tooltip on hover/tap
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final index = barSpot.x.toInt();
                final value = barSpot.y.toStringAsFixed(1);
                final date = index >= 0 && index < dates.length
                    ? dates[index]
                    : 'N/A';
                return LineTooltipItem(
                  '$value ${_getMeasurementUnit(selectedMeasurement)}\n$date',
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                  textAlign: TextAlign.center,
                );
              }).toList();
            },
            tooltipBgColor: Colors.black87,
            tooltipRoundedRadius: 8.r,
            tooltipPadding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 6.h,
            ),
            showOnTopOfTheChartBoxArea: false,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: color,
            barWidth: 2.5,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 3,
                  color: color,
                  strokeWidth: 1.5,
                  strokeColor: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getMeasurementIcon(String measurement) {
    switch (measurement) {
      case 'Steps':
        return Icons.directions_walk;
      case 'Weights':
        return Icons.monitor_weight;
      case 'Necks':
        return Icons.person;
      case 'Waists':
        return Icons.accessibility;
      case 'Hips':
        return Icons.accessibility_new;
      default:
        return Icons.monitor_weight;
    }
  }

  String _getMeasurementUnit(String measurement) {
    switch (measurement) {
      case 'Steps':
        return 'steps';
      case 'Weights':
        return 'kg';
      case 'Necks':
        return 'cm';
      case 'Waists':
        return 'cm';
      case 'Hips':
        return 'cm';
      default:
        return '';
    }
  }

  /// Get color for change value based on measurement type
  Color _getChangeColor(double changeValue) {
    if (selectedMeasurement == 'Steps') {
      // For steps, more is better
      return changeValue > 0 ? Colors.green : Colors.red;
    } else {
      // For weight and measurements, less is better
      return changeValue < 0 ? Colors.green : Colors.red;
    }
  }

  /// Build paginated entries with next/previous buttons
  /// Server handles pagination, we just request different pages
  List<Widget> _buildPaginatedEntries() {
    if (_progressStats == null || _progressStats!.entries.isEmpty) {
      return [];
    }

    final allEntries = _progressStats!.entries;
    final hasMore = allEntries.length >= _entriesPerPage;

    return [
      // Display entries for current page (server already filtered by page)
      ...allEntries.map(
        (entry) => _buildEntry(
          entry.type,
          entry.value,
          entry.date,
          DateFormat('dd/MM/yyyy').format(entry.date),
          entry.photoUrl,
          entry.id,
        ),
      ),

      // Pagination controls (for server-side pagination)
      if (hasMore || _page > 1)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              ElevatedButton.icon(
                onPressed: _page > 1
                    ? () {
                        setState(() {
                          _page--;
                        });
                        // Reload data from server with new page
                        context.read<ProgressCubit>().loadProgressData(
                          page: _page,
                          pageSize: _entriesPerPage,
                          type: selectedMeasurement,
                          startDate: startDate,
                          endDate: endDate,
                        );
                      }
                    : null,
                icon: Icon(Icons.arrow_back, size: 16.sp, color: Colors.white),
                label: Text('Previous', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  disabledBackgroundColor: Colors.grey[300],
                ),
              ),

              // Page indicator
              Text(
                'Page $_page',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),

              // Next button (enabled if we have a full page of entries)
              ElevatedButton.icon(
                onPressed: hasMore
                    ? () {
                        setState(() {
                          _page++;
                        });
                        // Reload data from server with new page
                        context.read<ProgressCubit>().loadProgressData(
                          page: _page,
                          pageSize: _entriesPerPage,
                          type: selectedMeasurement,
                          startDate: startDate,
                          endDate: endDate,
                        );
                      }
                    : null,
                icon: Icon(Icons.arrow_forward, size: 16.sp),
                label: Text('Next', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  disabledBackgroundColor: Colors.grey[300],
                  iconColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
    ];
  }

  Widget _buildEntry(
    String entryType,
    double value,
    DateTime dateTime,
    String date,
    String? photoUrl,
    String? entryId,
  ) {
    return GestureDetector(
      onTap: entryType.toLowerCase() == 'weights'
          ? () {
              if (entryId != null) {
                context.router.push(WeightFormRoute(entryId: entryId));
              } else {
                context.router.push(WeightFormRoute());
              }
            }
          : null, // No tap action for other measurement types
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${value.toStringAsFixed(1)} ${_getMeasurementUnit(selectedMeasurement)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    date,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            if (photoUrl != null) ...[
              SizedBox(width: 16.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: SizedBox(
                  width: 56.w,
                  height: 56.w,
                  child: photoUrl.startsWith('http')
                      ? Image.network(
                          photoUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.grey[100],
                                child: Icon(
                                  Icons.broken_image,
                                  size: 20.sp,
                                  color: Colors.grey[400],
                                ),
                              ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey[100],
                          child: Icon(
                            Icons.photo,
                            size: 20.sp,
                            color: Colors.grey[400],
                          ),
                        ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showMeasurementSelector() {
    final measurements = ['Weights'];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Measurement',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            ...measurements.map(
              (measurement) => ListTile(
                title: Text(
                  measurement,
                  style: TextStyle(
                    color: measurement == selectedMeasurement
                        ? Colors.black
                        : Colors.grey[600],
                    fontWeight: measurement == selectedMeasurement
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedMeasurement = measurement;
                    _page = 1;
                  });
                  // Load data with selected measurement and current date range
                  context.read<ProgressCubit>().loadProgressData(
                    page: 1,
                    pageSize: _entriesPerPage,
                    type: measurement,
                    startDate: startDate,
                    endDate: endDate,
                  );
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  String _getDateRangeText() {
    if (startDate == null && endDate == null) {
      return 'All';
    }
    if (startDate != null && endDate == null) {
      return 'From ${DateFormat('MMM d').format(startDate!)}';
    }
    if (startDate == null && endDate != null) {
      return 'Until ${DateFormat('MMM d').format(endDate!)}';
    }
    return '${DateFormat('MMM d').format(startDate!)} - ${DateFormat('MMM d').format(endDate!)}';
  }

  Future<void> _showDateRangeSelector() async {
    showDialog(
      context: context,
      builder: (context) {
        // Use local variables for the dialog state
        DateTime? dialogStartDate = startDate;
        DateTime? dialogEndDate = endDate;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select Date Range',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Divider(height: 1),
                    // Start Date
                    ListTile(
                      title: Text('Start Date'),
                      subtitle: Text(
                        dialogStartDate != null
                            ? DateFormat(
                                'EEEE, d MMM yyyy',
                              ).format(dialogStartDate!)
                            : 'No date',
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: dialogStartDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            dialogStartDate = picked;
                          });
                        }
                      },
                      trailing: Icon(
                        Icons.edit,
                        size: 18.sp,
                        color: Colors.blue,
                      ),
                    ),
                    Divider(height: 1),
                    // End Date
                    ListTile(
                      title: Text('End Date'),
                      subtitle: Text(
                        dialogEndDate != null
                            ? DateFormat(
                                'EEEE, d MMM yyyy',
                              ).format(dialogEndDate!)
                            : 'No date',
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: dialogEndDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            dialogEndDate = picked;
                          });
                        }
                      },
                      trailing: Icon(
                        Icons.edit,
                        size: 18.sp,
                        color: Colors.blue,
                      ),
                    ),
                    Divider(height: 1),
                    SizedBox(height: 16.h),
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 8.w,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              startDate = null;
                              endDate = null;
                            });
                            context.read<ProgressCubit>().loadProgressData(
                              page: 1,
                              pageSize: _entriesPerPage,
                              type: selectedMeasurement,
                              startDate: null,
                              endDate: null,
                            );
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Clear',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              startDate = dialogStartDate;
                              endDate = dialogEndDate;
                            });
                            _page = 1;
                            context.read<ProgressCubit>().loadProgressData(
                              page: 1,
                              pageSize: _entriesPerPage,
                              type: selectedMeasurement,
                              startDate: dialogStartDate,
                              endDate: dialogEndDate,
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            'Apply',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _exportProgressToCsv() async {
    try {
      // Show loading dialog
      context.showLoadingDialog(message: 'Exporting progress data...');

      // Load all data (not just current page) for export
      // We need to fetch with a large pageSize to get all entries
      await context.read<ProgressCubit>().loadProgressData(
        page: 1,
        pageSize: 10000, // Large number to get all entries
        type: selectedMeasurement,
        startDate: startDate,
        endDate: endDate,
      );

      // Wait a bit for data to load
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;

      // Get current state
      final state = context.read<ProgressCubit>().state;

      context.hideLoadingDialog();

      state.maybeWhen(
        loaded: (stats) async {
          if (!mounted) return;
          if (stats.entries.isEmpty) {
            AppDialogs.showSnackBar(
              message: 'No data to export',
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.orange,
            );
            return;
          }

          try {
            // Export to CSV
            final filePath = await CsvExportService.exportProgressToCsv(
              entries: stats.entries,
              measurementType: selectedMeasurement,
            );

            if (filePath != null) {
              // Get filename from path
              final filename = filePath.split('/').last;

              // Share the file
              await CsvExportService.shareCsvFile(filePath, filename);
              if (!mounted) return;

              AppDialogs.showSnackBar(
                message: 'Progress data exported successfully',
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.green,
              );
            } else {
              AppDialogs.showSnackBar(
                message: 'Failed to export data',
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.red,
              );
            }
          } catch (e) {
            AppDialogs.showSnackBar(
              message: 'Error exporting data: ${e.toString()}',
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
            );
          }
        },
        orElse: () {
          AppDialogs.showSnackBar(
            message: 'Please wait for data to load',
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.orange,
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
      context.hideLoadingDialog();
      AppDialogs.showSnackBar(
        message: 'Error: ${e.toString()}',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
    }
  }
}
