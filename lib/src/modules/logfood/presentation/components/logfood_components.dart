import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../enums/sort_option.dart';
import '../../../app/app_router.dart';
import '../../domain/repository/food_repository.dart';
import '../../data/models/food_model.dart';
import '../widgets/ai_estimated_food_chip.dart';

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final bool isNew;
  final VoidCallback onTap;
  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
    this.isNew = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Icon(icon, size: 32.sp, color: iconColor),
                if (isNew)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange[600],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'NEW',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class HistorySection extends StatelessWidget {
  final List<FoodModel> foods;
  final SortOption selectedSort;
  final Function(SortOption) onSortChanged;
  final Function(FoodModel) onFoodSelected;
  final String? selectedMeal;
  final TabController tabController;
  final DateTime? logForDate;

  const HistorySection({
    super.key,
    required this.foods,
    required this.selectedSort,
    required this.onSortChanged,
    required this.onFoodSelected,
    this.selectedMeal,
    required this.tabController,
    this.logForDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'History',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _showSortOptions(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sort, color: Colors.blue[600], size: 16.sp),
                      SizedBox(width: 8.w),
                      Text(
                        _getSortDisplayName(selectedSort),
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.blue[600],
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (foods.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Text(
                  'No recent foods',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[500]),
                ),
              ),
            )
          else
            ...foods.map(
              (food) => FoodItem(
                food: food,
                onFoodSelected: onFoodSelected,
                selectedMeal: selectedMeal,
                foods: foods,
                tabController: tabController,
                logForDate: logForDate,
              ),
            ),
        ],
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    final options = [
      (SortOption.mostRecent, 'Most Recent'),
      (SortOption.alphabeticalAZ, 'A - Z'),
      (SortOption.alphabeticalZA, 'Z - A'),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sort Options',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              ...options.map(
                (option) => ListTile(
                  title: Text(
                    option.$2,
                    style: TextStyle(
                      color: selectedSort == option.$1
                          ? Colors.black
                          : Colors.grey[600],
                      fontWeight: selectedSort == option.$1
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    onSortChanged(option.$1);
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  String _getSortDisplayName(SortOption sort) {
    switch (sort) {
      case SortOption.mostRecent:
        return 'Most Recent';
      case SortOption.alphabeticalAZ:
        return 'A - Z';
      case SortOption.alphabeticalZA:
        return 'Z - A';
    }
  }
}

class SuggestionsSection extends StatefulWidget {
  final List<FoodModel> foods;
  final Function(FoodModel) onFoodSelected;
  final String? selectedMeal;
  final TabController tabController;
  final DateTime? logForDate;
  final Function()? onLoadMore;
  final bool isLoadingMore;

  const SuggestionsSection({
    super.key,
    required this.foods,
    required this.onFoodSelected,
    this.selectedMeal,
    required this.tabController,
    this.logForDate,
    this.onLoadMore,
    this.isLoadingMore = false,
  });

  @override
  State<SuggestionsSection> createState() => _SuggestionsSectionState();
}

class _SuggestionsSectionState extends State<SuggestionsSection> {
  late final ScrollController _scrollController;
  bool _isRequestingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SuggestionsSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isLoadingMore && !widget.isLoadingMore) {
      _isRequestingMore = false;
    }
  }

  void _onScroll() {
    if (!mounted || widget.isLoadingMore || _isRequestingMore) return;

    if (_scrollController.position.extentAfter < 300) {
      _isRequestingMore = true;
      widget.onLoadMore?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final listHeight = MediaQuery.of(context).size.height * 0.45;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suggestions',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.h),
          if (widget.foods.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Text(
                  'No suggestions available',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[500]),
                ),
              ),
            )
          else
            SizedBox(
              height: listHeight,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.foods.length + (widget.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == widget.foods.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue[600]!,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  final food = widget.foods[index];
                  return FoodItem(
                    food: food,
                    onFoodSelected: widget.onFoodSelected,
                    selectedMeal: widget.selectedMeal,
                    foods: widget.foods,
                    tabController: widget.tabController,
                    logForDate: widget.logForDate,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class SearchResultsSection extends StatelessWidget {
  final List<FoodModel> foods;
  final Function(FoodModel) onFoodSelected;
  final String? selectedMeal;
  final TabController tabController;
  final DateTime? logForDate;

  const SearchResultsSection({
    super.key,
    required this.foods,
    required this.onFoodSelected,
    this.selectedMeal,
    required this.tabController,
    this.logForDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (foods.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[500]),
                ),
              ),
            )
          else
            ...foods.map(
              (food) => FoodItem(
                food: food,
                onFoodSelected: onFoodSelected,
                selectedMeal: selectedMeal,
                foods: foods,
                tabController: tabController,
                logForDate: logForDate,
              ),
            ),
        ],
      ),
    );
  }
}

class FoodItem extends StatefulWidget {
  final FoodModel food;
  final Function(FoodModel) onFoodSelected;
  final String? selectedMeal;
  final List<FoodModel> foods;
  final TabController tabController;
  final DateTime? logForDate;
  final bool showDeleteAction;
  final bool showEditAction;
  final Future<void> Function(FoodModel food)? onEdit;
  final Future<void> Function(FoodModel food)? onDelete;
  /// When set, row tap uses this instead of opening [LogFoodDetailRoute] (e.g. My Meals → meal detail).
  final Future<void> Function()? onRowTapOverride;

  const FoodItem({
    super.key,
    required this.food,
    required this.onFoodSelected,
    this.selectedMeal,
    required this.foods,
    required this.tabController,
    this.logForDate,
    this.showDeleteAction = false,
    this.showEditAction = false,
    this.onEdit,
    this.onDelete,
    this.onRowTapOverride,
  });

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isAdded = false;
  Future<String?>? _mealImageUrlFuture;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _prepareMealImageFuture();
  }

  @override
  void didUpdateWidget(covariant FoodItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isMealRow) {
      // Always refresh thumbnail future for meal rows on parent rebuild.
      // Meal image URL comes from meal detail API and can change while ID stays same.
      _prepareMealImageFuture();
    } else if (oldWidget.food.id != widget.food.id ||
        oldWidget.onRowTapOverride != widget.onRowTapOverride) {
      _prepareMealImageFuture();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleAddFood() {
    if (widget.selectedMeal == null) {
      _showSelectMealDialog();
      return;
    }

    setState(() {
      _isAdded = true;
    });

    _animationController.forward().then((_) {
      widget.onFoodSelected(widget.food);
      // Reset after a delay
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          _animationController.reverse();
          setState(() {
            _isAdded = false;
          });
        }
      });
    });
  }

  void _showSelectMealDialog() {
    AppDialogs.showSnackBar(
      message: 'Please select a meal first.',
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 2),
    );
  }

  bool get _isMealRow =>
      (widget.onRowTapOverride != null && widget.food.id != null) ||
      widget.food.mealTemplateId != null;

  void _prepareMealImageFuture() {
    if (!_isMealRow) {
      _mealImageUrlFuture = null;
      return;
    }
    final mealId = widget.food.mealTemplateId ?? widget.food.id!;
    _mealImageUrlFuture = _loadMealImageUrl(mealId);
  }

  Future<String?> _loadMealImageUrl(int mealId) async {
    final result = await getIt<FoodRepository>().getMealDetail(mealId);
    return result.fold((detail) {
      final raw = detail.imageUrl?.trim();
      if (raw == null || raw.isEmpty) return null;
      return raw;
    }, (_) => null);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.onRowTapOverride != null) {
          await widget.onRowTapOverride!();
          return;
        }
        final mealId = widget.food.mealTemplateId;
        if (mealId != null) {
          await context.router.push(MealDetailRoute(mealId: mealId));
          return;
        }
        final fid = widget.food.id;
        if (fid == null) return;
        context.router.push(
          LogFoodDetailRoute(
            foodId: fid,
            food: widget.food,
            historyFoods: widget.foods,
            forLogDate: widget.logForDate,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
        ),
        child: Row(
          children: [
            if (_isMealRow) ...[
              _MealListImageThumb(imageUrlFuture: _mealImageUrlFuture),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.food.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      if (widget.food.isAiEstimated) ...[
                        SizedBox(width: 6.w),
                        const AiEstimatedFoodChip(compact: true),
                      ],
                      if (widget.food.isVerified) ...[
                        SizedBox(width: 4.w),
                        Container(
                          width: 16.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: Colors.green[500],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (widget.food.listBrandLabel != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      widget.food.listBrandLabel!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      if (widget.food.quantity != 1) ...[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            '${widget.food.quantity.toStringAsFixed(widget.food.quantity % 1 == 0 ? 0 : 1)}x',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                      ],
                      Flexible(
                        child: Text(
                          widget.food.units[widget.food.unitShowIndex],
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.food.hasCaloriesData
                            ? '${widget.food.calories.toStringAsFixed(0)} kcal'
                            : '—',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (widget.food.carbs != null ||
                      widget.food.protein != null ||
                      widget.food.fat != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      'C: ${widget.food.carbs?.toStringAsFixed(1) ?? '0'}g • P: ${widget.food.protein?.toStringAsFixed(1) ?? '0'}g • F: ${widget.food.fat?.toStringAsFixed(1) ?? '0'}g',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 12.w),
            if (widget.showEditAction) ...[
              GestureDetector(
                onTap: () => widget.onEdit?.call(widget.food),
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 20.sp,
                    color: Colors.blue[600],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],
            if (widget.showDeleteAction) ...[
              GestureDetector(
                onTap: () => widget.onDelete?.call(widget.food),
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    size: 20.sp,
                    color: Colors.red[600],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: GestureDetector(
                    onTap: _handleAddFood,
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: _isAdded ? Colors.green[600] : Colors.blue[600],
                        shape: BoxShape.circle,
                        boxShadow: _isAdded
                            ? [
                                BoxShadow(
                                  color: Colors.green[600]!.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          _isAdded ? Icons.check : Icons.add,
                          key: ValueKey(_isAdded),
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MealListImageThumb extends StatelessWidget {
  const _MealListImageThumb({required this.imageUrlFuture});

  final Future<String?>? imageUrlFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: imageUrlFuture,
      builder: (context, snapshot) {
        final url = snapshot.data?.trim();
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            width: 52.w,
            height: 52.w,
            color: Colors.grey[100],
            child: (url != null && url.isNotEmpty)
                ? Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.image_not_supported_outlined,
                      size: 20.sp,
                      color: Colors.grey[500],
                    ),
                  )
                : Icon(
                    Icons.restaurant_menu_outlined,
                    size: 20.sp,
                    color: Colors.grey[500],
                  ),
          ),
        );
      },
    );
  }
}
