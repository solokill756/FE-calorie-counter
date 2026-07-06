import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../widgets/time_period_selector.dart';
import '../application/nutrient_detail_cubit/nutrient_detail_cubit.dart';

class FoodsHighestDetailPage extends StatefulWidget {
  final String title;
  final String nutrientName;
  final List<String> initialFoods;
  final DateTime initialDate;
  final String initialPeriod;

  const FoodsHighestDetailPage({
    super.key,
    required this.title,
    required this.nutrientName,
    required this.initialFoods,
    required this.initialDate,
    required this.initialPeriod,
  });

  @override
  State<FoodsHighestDetailPage> createState() => _FoodsHighestDetailPageState();
}

class _FoodsHighestDetailPageState extends State<FoodsHighestDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<NutrientDetailCubit>();

      // Set initial values
      cubit.setInitialDate(widget.initialDate);
      cubit.setInitialPeriod(widget.initialPeriod);

      // Set nutrient type and load data
      cubit.setNutrientType(widget.nutrientName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutrientDetailCubit, NutrientDetailState>(
      builder: (context, state) {
        final foods = state.foodsHighestInNutrient;
        final selectedPeriod = state.selectedPeriod;
        final isLoading = state.isLoading;

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
              'Foods Highest In ${widget.nutrientName}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
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
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: isLoading
                      ? const Center(
                          child: LoadingWidget.large(
                            message: 'Loading foods...',
                          ),
                        )
                      : Column(
                          children: [
                            // Header Row
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Food',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Total',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            // Food List
                            Expanded(
                              child: foods.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No foods logged for this period',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    )
                                  : ListView.separated(
                                      itemCount: foods.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 12.h),
                                      itemBuilder: (context, index) {
                                        final food = foods[index];
                                        // Parse food string: "Food Name - 40.0 g"
                                        final parts = food.split(' - ');
                                        final foodName = parts.isNotEmpty
                                            ? parts[0]
                                            : food;
                                        final foodValue = parts.length > 1
                                            ? parts[1]
                                            : '';

                                        return Row(
                                          children: [
                                            // Rank number
                                            Container(
                                              width: 24.w,
                                              height: 24.h,
                                              decoration: BoxDecoration(
                                                color: _getRankColor(index),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            // Food name
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                foodName,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            // Food value
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                foodValue,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  Color _getRankColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber[700]!; // Gold for #1
      case 1:
        return Colors.grey[600]!; // Silver for #2
      case 2:
        return Colors.brown[400]!; // Bronze for #3
      default:
        return Colors.blue[400]!;
    }
  }
}
