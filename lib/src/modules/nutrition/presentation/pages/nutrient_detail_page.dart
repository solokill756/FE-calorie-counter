import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/error_widget_custom.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../application/nutrient_detail_cubit/nutrient_detail_cubit.dart';
import '../widgets/time_period_selector.dart';
import '../widgets/nutrient_chart_section_widget.dart';
import '../widgets/nutrient_foods_section_widget.dart';
import '../../data/helpers/nutrient_helper.dart';

class NutrientDetailPage extends StatefulWidget {
  final String nutrientName;
  final DateTime? initialDate;
  final String? initialPeriod;

  const NutrientDetailPage({
    super.key,
    required this.nutrientName,
    this.initialDate,
    this.initialPeriod,
  });

  @override
  State<NutrientDetailPage> createState() => _NutrientDetailPageState();
}

class _NutrientDetailPageState extends State<NutrientDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<NutrientDetailCubit>();

      // Nếu có initialDate và initialPeriod, set chúng trước
      if (widget.initialDate != null) {
        cubit.setInitialDate(widget.initialDate!);
      }
      if (widget.initialPeriod != null) {
        cubit.setInitialPeriod(widget.initialPeriod!);
      }

      // Sau đó set nutrient type và load data
      cubit.setNutrientType(widget.nutrientName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutrientDetailCubit, NutrientDetailState>(
      builder: (context, state) {
        final weeklyData = state.weeklyData;
        final selectedPeriod = state.selectedPeriod;
        final isLoading = state.isLoading;
        final foods = state.foodsHighestInNutrient;
        final errorMessage = state.errorMessage;

        // Lấy nutrientName từ state hoặc fallback về widget.nutrientName
        final displayName = state.nutrientName ?? widget.nutrientName;

        if (isLoading || weeklyData == null) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                displayName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            body: const Center(
              child: LoadingWidget.large(message: 'Loading nutrient data...'),
            ),
          );
        }

        if (errorMessage != null) {
          return ErrorWidgetCustom(
            message: 'Could not load nutrient data',
            onRetry: () =>
                context.read<NutrientDetailCubit>().loadNutrientData(),
          );
        }

        // Calculate chart data for nutrient
        final chartData = NutrientHelper.calculateChartData(
          weeklyData.dailyData,
          displayName,
        );

        // Calculate daily average
        final dailyAverage = NutrientHelper.calculateDailyAverage(chartData);

        // Calculate meal breakdown - khác nhau cho Day View và Week View
        final mealBreakdown =
            selectedPeriod == 'Day View' && weeklyData.dailyData.isNotEmpty
            ? NutrientHelper.calculateMealBreakdownForDay(
                weeklyData.dailyData[0],
                displayName,
              )
            : NutrientHelper.calculateMealBreakdown(
                weeklyData.dailyData,
                displayName,
              );

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              displayName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Time Period Selector
              Container(
                color: Colors.white,
                child: TimePeriodSelector(
                  selectedPeriod: selectedPeriod,
                  currentDate: state.currentDate,
                  onPeriodChanged: (period, {selectedDate}) {
                    context.read<NutrientDetailCubit>().changePeriod(
                          period,
                          selectedDate: selectedDate,
                        );
                  },
                  onPreviousPeriod: () {
                    context.read<NutrientDetailCubit>().navigatePrevious();
                  },
                  onNextPeriod: () {
                    context.read<NutrientDetailCubit>().navigateNext();
                  },
                ),
              ),

              SizedBox(height: 20.h),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Chart and Stats Section
                      NutrientChartSectionWidget(
                        chartData: chartData,
                        mealBreakdown: mealBreakdown,
                        dailyAverage: dailyAverage,
                        unit: NutrientHelper.getUnitForNutrient(displayName),
                        selectedPeriod: selectedPeriod,
                      ),

                      SizedBox(height: 20.h),

                      // Foods Highest Section
                      NutrientFoodsSectionWidget(
                        nutrientName: displayName,
                        foods: foods,
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
