import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/error_widget_custom.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../domain/entities/food_item_entity.dart';
import '../application/food_detail_cubit/food_detail_cubit.dart';
import '../widgets/time_period_selector.dart';

class FoodDetailPage extends StatefulWidget {
  final String title;
  final String type;

  const FoodDetailPage({super.key, required this.title, required this.type});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  void initState() {
    super.initState();
    // Set type và load data khi page được mở
    context.read<FoodDetailCubit>().setType(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(context),
      body: BlocBuilder<FoodDetailCubit, FoodDetailState>(
        builder: (context, state) {
          return Column(
            children: [
              // Time Period Selector
              Container(
                color: Colors.white,
                child: TimePeriodSelector(
                  selectedPeriod: state.selectedPeriod,
                  currentDate: state.currentDate,
                  onPeriodChanged: (period, {selectedDate}) {
                    context.read<FoodDetailCubit>().changePeriod(
                      period,
                      selectedDate: selectedDate,
                    );
                  },
                  onPreviousPeriod: () {
                    context.read<FoodDetailCubit>().navigatePrevious();
                  },
                  onNextPeriod: () {
                    context.read<FoodDetailCubit>().navigateNext();
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(child: _buildBody(state)),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        _getDisplayTitle(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(FoodDetailState state) {
    if (state.isLoading) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const Center(
          child: LoadingWidget.large(message: 'Loading foods...'),
        ),
      );
    }

    if (state.errorMessage != null) {
      return ErrorWidgetCustom(
        message: 'Could not load foods for this period.',
        onRetry: () => context.read<FoodDetailCubit>().loadFoods(),
      );
    }

    final foods = state.foods;
    if (foods.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const EmptyStateWidget(
          title: 'No Foods Logged',
          message: 'There are no foods for this period.',
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            children: [
              SizedBox(width: 24.w + 12.w), // Space for rank number
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
            child: ListView.separated(
              itemCount: foods.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) =>
                  _buildFoodItem(foods[index], index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItem(FoodItemEntity food, int index) {
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
            food.name,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        // Food value
        Expanded(
          flex: 1,
          child: Text(
            _ValueFormatter.format(food.total, widget.type),
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

  String _getDisplayTitle() {
    return _TitleHelper.getTitle(widget.type, widget.title);
  }
}

class _ValueFormatter {
  static String format(double value, String type) {
    final unit = _getUnit(type);
    if (value == 0) return '0$unit';
    if (value < 1) return '${value.toStringAsFixed(1)}$unit';
    return '${value.round()}$unit';
  }

  static String _getUnit(String type) {
    switch (type) {
      case 'calories':
        return 'cal';
      case 'carbohydrates':
      case 'fat':
      case 'protein':
      case 'fiber':
      case 'sugar':
      case 'sugars':
      case 'saturatedFat':
        return 'g';
      case 'cholesterol':
      case 'sodium':
      case 'potassium':
      case 'calcium':
      case 'iron':
      case 'magnesium':
      case 'phosphorus':
      case 'zinc':
      case 'vitaminC':
      case 'vitaminE':
      case 'vitaminB6':
        return 'mg';
      case 'vitaminA':
      case 'vitaminD':
      case 'vitaminK':
      case 'vitaminB12':
      case 'folateDfe':
        return 'mcg';
      default:
        return '';
    }
  }
}

class _TitleHelper {
  static String getTitle(String type, String fallback) {
    switch (type) {
      case 'calories':
        return 'Foods Highest In Calories';
      case 'carbohydrates':
        return 'Foods Highest In Carbohydrates (g)';
      case 'fat':
        return 'Foods Highest In Fat (g)';
      case 'protein':
        return 'Foods Highest In Protein (g)';
      case 'fiber':
        return 'Foods Highest In Fiber (g)';
      case 'sugar':
      case 'sugars':
        return 'Foods Highest In Sugars (g)';
      case 'saturatedFat':
        return 'Foods Highest In Saturated Fat (g)';
      case 'cholesterol':
        return 'Foods Highest In Cholesterol (mg)';
      case 'sodium':
        return 'Foods Highest In Sodium (mg)';
      case 'potassium':
        return 'Foods Highest In Potassium (mg)';
      case 'calcium':
        return 'Foods Highest In Calcium (mg)';
      case 'iron':
        return 'Foods Highest In Iron (mg)';
      case 'magnesium':
        return 'Foods Highest In Magnesium (mg)';
      case 'phosphorus':
        return 'Foods Highest In Phosphorus (mg)';
      case 'zinc':
        return 'Foods Highest In Zinc (mg)';
      case 'vitaminA':
        return 'Foods Highest In Vitamin A (mcg)';
      case 'vitaminC':
        return 'Foods Highest In Vitamin C (mg)';
      case 'vitaminD':
        return 'Foods Highest In Vitamin D (mcg)';
      case 'vitaminE':
        return 'Foods Highest In Vitamin E (mg)';
      case 'vitaminK':
        return 'Foods Highest In Vitamin K (mcg)';
      case 'vitaminB6':
        return 'Foods Highest In Vitamin B6 (mg)';
      case 'vitaminB12':
        return 'Foods Highest In Vitamin B12 (mcg)';
      case 'folateDfe':
        return 'Foods Highest In Folate DFE (mcg)';
      default:
        return fallback;
    }
  }
}
