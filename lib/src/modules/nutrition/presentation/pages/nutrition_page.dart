import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/error_widget_custom.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../application/nutrition_cubit/nutrition_cubit.dart';
import '../widgets/time_period_selector.dart';
import '../widgets/macros_chart_widget.dart';
import '../widgets/macros_legend_widget.dart';
import '../widgets/nutrients_table_widget.dart';
import '../widgets/day_view_widget.dart';
import '../widgets/week_view_widget.dart';
import '../widgets/food_section_widget.dart';
import 'export_information_page.dart';

@RoutePage()
class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Load data when page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NutritionCubit>().loadWeeklyData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCaloriesTab(),
                _buildNutrientsTab(),
                _buildMacrosTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.black, size: 24.sp),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Nutrition',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {
            final state = context.read<NutritionCubit>().state;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExportInformationPage(
                  currentDate: state.currentDate,
                  period: state.selectedPeriod,
                ),
              ),
            );
          },
          child: Text(
            'Export',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: Colors.blue,
        indicatorWeight: 3,
        labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        tabs: [
          Tab(text: 'Calories'),
          Tab(text: 'Nutrients'),
          Tab(text: 'Macros'),
        ],
      ),
    );
  }

  Widget _buildCaloriesTab() {
    return BlocBuilder<NutritionCubit, NutritionState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: LoadingWidget.large(message: 'Loading nutrition data...'),
          );
        }

        if (state.errorMessage != null) {
          return ErrorWidgetCustom(
            message: 'Could not load nutrition data.',
            onRetry: () => context.read<NutritionCubit>().loadWeeklyData(),
          );
        }

        if (state.weeklyData == null) {
          return const EmptyStateWidget(
            title: 'No Nutrition Data',
            message: 'Log food to see your nutrition trends.',
          );
        }

        final isDayView = state.selectedPeriod == 'Day View';

        return Column(
          children: [
            _buildTimePeriodSelector(context, state),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                width: double.infinity,
                child: isDayView
                    ? DayViewWidget(state: state, context: context)
                    : WeekViewWidget(state: state),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNutrientsTab() {
    return BlocBuilder<NutritionCubit, NutritionState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: LoadingWidget.large(message: 'Loading nutrients...'),
          );
        }
        if (state.errorMessage != null) {
          return ErrorWidgetCustom(
            message: 'Could not load nutrient data.',
            onRetry: () => context.read<NutritionCubit>().loadWeeklyData(),
          );
        }
        if (state.weeklyData == null) {
          return const EmptyStateWidget(
            title: 'No Nutrient Data',
            message: 'Log food to see nutrient averages.',
          );
        }
        return Column(
          children: [
            _buildTimePeriodSelector(context, state),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(height: 8.h, color: Colors.grey[200]),
                      NutrientsTableWidget(state: state),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMacrosTab() {
    return BlocBuilder<NutritionCubit, NutritionState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: LoadingWidget.large(message: 'Loading macros...'),
          );
        }
        if (state.errorMessage != null) {
          return ErrorWidgetCustom(
            message: 'Could not load macro data.',
            onRetry: () => context.read<NutritionCubit>().loadWeeklyData(),
          );
        }
        if (state.weeklyData == null) {
          return const EmptyStateWidget(
            title: 'No Macro Data',
            message: 'Log food to see your macro breakdown.',
          );
        }
        return Column(
          children: [
            _buildTimePeriodSelector(context, state),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(height: 8.h, color: Colors.grey[200]),
                      _buildMacrosChartSection(state),
                      SizedBox(height: 8.h),
                      ..._buildFoodSections(context),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimePeriodSelector(BuildContext context, NutritionState state) {
    final cubit = context.read<NutritionCubit>();
    return TimePeriodSelector(
      selectedPeriod: state.selectedPeriod,
      currentDate: state.currentDate,
      onPeriodChanged: cubit.changePeriod,
      onPreviousPeriod: cubit.navigatePrevious,
      onNextPeriod: cubit.navigateNext,
    );
  }

  Widget _buildMacrosChartSection(NutritionState state) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          SizedBox(
            height: 250.h,
            child: MacrosChartWidget(state: state),
          ),
          SizedBox(height: 8.h),
          SizedBox(height: 20.h),
          _buildMacrosHeader(state),
          SizedBox(height: 12.h),
          MacrosLegendWidget(state: state),
        ],
      ),
    );
  }

  Widget _buildMacrosHeader(NutritionState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: [
          const Expanded(flex: 3, child: SizedBox()),
          Text(
            state.selectedPeriod == 'Day View' ? 'Total' : 'Avg',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 40.w),
          Text(
            'Goal',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFoodSections(BuildContext context) {
    final state = context.read<NutritionCubit>().state;
    return [
      FoodSectionWidget(
        title: 'Foods Highest In Carbohydrates',
        type: 'carbohydrates',
        foods: state.foodsHighestInCarbohydrates,
      ),
      SizedBox(height: 8.h),
      FoodSectionWidget(
        title: 'Foods Highest In Fat',
        type: 'fat',
        foods: state.foodsHighestInFat,
      ),
      SizedBox(height: 8.h),
      FoodSectionWidget(
        title: 'Foods Highest In Protein',
        type: 'protein',
        foods: state.foodsHighestInProtein,
      ),
    ];
  }
}
