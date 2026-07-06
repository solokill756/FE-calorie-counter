import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/widgets/data_fetch_loading_widget.dart';
import 'package:caloriecounter/src/core/utils/error_translator.dart';
import 'package:caloriecounter/src/common/widgets/unified_error_display.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../auth/presentation/application/cubit/user_profile_access.dart';
import '../../../../enums/meal_options.dart';
import '../../../app/app_router.dart';
import '../../data/models/food_model.dart';
import '../../domain/repository/food_repository.dart';
import '../../helper/nutrition_log_warning.dart';
import '../application/cubit/logfood_cubit.dart';
import '../application/cubit/logfood_page_cubit.dart';
import '../components/logfood_components.dart';
import 'create_meal_page.dart';
import 'ingredient_photo_recipe_page.dart';
import 'recipe_editor_page.dart';
import 'suggest_recipe_from_foods_page.dart';

class _SavedMealQuantityDialog extends StatefulWidget {
  const _SavedMealQuantityDialog({required this.mealName});

  final String mealName;

  @override
  State<_SavedMealQuantityDialog> createState() =>
      _SavedMealQuantityDialogState();
}

class _SavedMealQuantityDialogState extends State<_SavedMealQuantityDialog> {
  final _controller = TextEditingController(text: '1');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _readQty() {
    final raw = _controller.text.trim().replaceAll(',', '.');
    final parsed = double.tryParse(raw);
    if (parsed == null || parsed <= 0) return 1;
    return parsed;
  }

  void _setQty(double value) {
    final next = value.clamp(0.01, 999.0);
    final text = next == next.roundToDouble()
        ? next.round().toString()
        : next.toStringAsFixed(2);
    _controller.text = text;
    _controller.selection = TextSelection.collapsed(offset: text.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final qty = _readQty();
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text(
        'Meal quantity',
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.mealName,
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _quantityButton(
                icon: Icons.remove,
                onPressed: () => _setQty(qty - 0.5),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Servings',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              _quantityButton(
                icon: Icons.add,
                onPressed: () => _setQty(qty + 0.5),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_readQty()),
          child: const Text('Log meal'),
        ),
      ],
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 40.w,
      height: 48.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Icon(icon, size: 18.sp),
      ),
    );
  }
}

@RoutePage()
class LogFoodPage extends StatelessWidget {
  const LogFoodPage({super.key, this.forDate, this.initialMeal});

  /// Calendar day the user was viewing when opening log food (local date).
  final DateTime? forDate;

  /// Same slug as [MealOptions.value] / diary `mealType`.
  final String? initialMeal;

  @override
  Widget build(BuildContext context) {
    return LogFoodView(forDate: forDate, initialMeal: initialMeal);
  }
}

class LogFoodView extends StatefulWidget {
  const LogFoodView({super.key, this.forDate, this.initialMeal});

  final DateTime? forDate;
  final String? initialMeal;

  @override
  State<LogFoodView> createState() => _LogFoodViewState();
}

class _LogFoodViewState extends State<LogFoodView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _allSearchController = TextEditingController();
  final TextEditingController _myFoodsSearchController =
      TextEditingController();
  final TextEditingController _myMealsSearchController =
      TextEditingController();
  final TextEditingController _myRecipesSearchController =
      TextEditingController();
  String? selectedMeal;
  bool _communityMealsMode = false;
  bool _communityRecipesMode = false;
  final List<MealOptions> mealOptions = MealOptions.values.toList();
  final bool _isHandlingCreateFoodSuccess = false;
  final Map<int, Future<String?>> _recipeImageUrlFutures = {};
  Timer? _allSearchDebounce;
  Timer? _myFoodsSearchDebounce;
  Timer? _myRecipesSearchDebounce;

  Future<String?> _getRecipeImageUrl(int? recipeId) {
    final id = recipeId ?? 0;
    if (id <= 0) return Future.value(null);
    return _recipeImageUrlFutures.putIfAbsent(id, () async {
      final result = await getIt<FoodRepository>().getRecipeById(id);
      return result.fold((recipe) => recipe.imageUrl?.trim(), (_) => null);
    });
  }

  void _clearRecipeImageCache([int? recipeId]) {
    if (recipeId != null && recipeId > 0) {
      _recipeImageUrlFutures.remove(recipeId);
      return;
    }
    _recipeImageUrlFutures.clear();
  }

  void _scheduleAllFoodSearch(String value) {
    _allSearchDebounce?.cancel();
    final query = value.trim();
    _allSearchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      context.read<LogFoodPageCubit>().searchFoods(query, includeAll: true);
    });
  }

  void _scheduleMyFoodsSearch(String value) {
    _myFoodsSearchDebounce?.cancel();
    final query = value.trim();
    setState(() {});
    _myFoodsSearchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      context.read<LogFoodPageCubit>().searchFoods(
        query,
        includeAll: false,
        mineOnly: true,
      );
    });
  }

  void _scheduleMyRecipesSearch(String value) {
    _myRecipesSearchDebounce?.cancel();
    final query = value.trim();
    _myRecipesSearchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      context.read<LogFoodPageCubit>().searchMyRecipes(
        query,
        includeCommunity: _communityRecipesMode,
      );
    });
  }

  void _reloadMyRecipesTab() {
    context.read<LogFoodPageCubit>().reloadTab(
      'My Recipes',
      myRecipesSearch: _myRecipesSearchParam(),
      includeCommunityRecipes: _communityRecipesMode,
    );
  }

  void _onTabChanged() {
    if (!_isHandlingCreateFoodSuccess &&
        _tabController.indexIsChanging &&
        mounted) {
      final tabs = ['All', 'My Meals', 'My Recipes', 'My Foods'];
      context.read<LogFoodPageCubit>().selectTab(tabs[_tabController.index]);
    }
  }

  void _syncTabControllerWithSelectedTab(String selectedTab) {
    final tabs = ['All', 'My Meals', 'My Recipes', 'My Foods'];
    final tabIndex = tabs.indexOf(selectedTab);
    if (tabIndex == -1) return;
    if (_tabController.index == tabIndex) return;
    if (!mounted) return;
    _tabController.animateTo(tabIndex);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(_onTabChanged);

    final slug = widget.initialMeal?.trim().toLowerCase();
    if (slug != null && slug.isNotEmpty) {
      selectedMeal = MealOptions.fromValue(
        slug == 'snack' ? 'snacks' : slug,
      ).value;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LogFoodPageCubit>().loadInitialData(selectedTab: 'All');
      }
    });
  }

  DateTime _logTimestamp() {
    final base = widget.forDate ?? DateTime.now();
    final now = DateTime.now();
    return DateTime(
      base.year,
      base.month,
      base.day,
      now.hour,
      now.minute,
      now.second,
    );
  }

  /// Quick-add (+) from list.
  Future<void> _quickAddWithNutritionGuard(
    FoodModel food, {
    String? selectedTab,
  }) async {
    if (selectedMeal == null) {
      AppDialogs.showSnackBar(
        message: 'Please select a meal first',
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    final logDay = widget.forDate ?? DateTime.now();
    final ok = await NutritionLogWarning.confirmQuickAddFromList(
      context,
      food: food,
      qty: 1.0,
      unitIndex: 0,
      logCalendarDay: logDay,
      profile: readServerProfile(),
    );
    if (!mounted || !ok) return;

    final ts = _logTimestamp();
    context.read<LogFoodCubit>().addLogFood(
      food: food,
      slot: selectedMeal!,
      qty: 1.0,
      time: ts,
      unitSelectedIndex: 0,
      selectedTab: selectedTab,
    );
  }

  /// (+) on My Meals: log the saved meal template to the diary (not open edit).
  Future<void> _quickAddSavedMeal(FoodModel meal) async {
    if (selectedMeal == null) {
      AppDialogs.showSnackBar(
        message: 'Please select a meal first',
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    final qty = await _pickSavedMealQuantity(meal);
    if (!mounted || qty == null) return;
    final mealToLog = meal.copyWith(quantity: qty);
    final logDay = widget.forDate ?? DateTime.now();
    final ok = await NutritionLogWarning.confirmQuickAddSavedMeal(
      context,
      meal: mealToLog,
      qty: qty,
      logCalendarDay: logDay,
      profile: readServerProfile(),
    );
    if (!mounted || !ok) return;
    final ts = _logTimestamp();
    context.read<LogFoodCubit>().addLogSavedMealTemplate(
      meal: mealToLog,
      slot: selectedMeal!,
      time: ts,
      selectedTab: 'My Meals',
    );
  }

  Future<double?> _pickSavedMealQuantity(FoodModel meal) async {
    return showDialog<double>(
      context: context,
      builder: (ctx) => _SavedMealQuantityDialog(mealName: meal.name),
    );
  }

  String _mealTitle() {
    if (selectedMeal == null) return 'Select a Meal';
    return MealOptions.fromValue(selectedMeal!).displayName;
  }

  /// Current My Recipes search for API `search` query (null = all).
  String? _myRecipesSearchParam() {
    final t = _myRecipesSearchController.text.trim();
    return t.isEmpty ? null : t;
  }

  @override
  void dispose() {
    _allSearchDebounce?.cancel();
    _myFoodsSearchDebounce?.cancel();
    _myRecipesSearchDebounce?.cancel();
    _tabController.dispose();
    _allSearchController.dispose();
    _myFoodsSearchController.dispose();
    _myMealsSearchController.dispose();
    _myRecipesSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Transform.translate(
              offset: Offset(-20.w, 0),
              child: GestureDetector(
                onTap: () => _showMealSelector(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _mealTitle(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[600],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 20.sp,
                      color: Colors.blue[600],
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<LogFoodCubit, LogFoodState>(
              listener: (context, state) {
                state.maybeWhen(
                  logFoodSuccess: (String message, ratingPromptLogCount) {
                    AppDialogs.showSnackBar(
                      message: message,
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    );
                    // Only reload recent foods, not all tabs
                    context.read<LogFoodPageCubit>().reloadRecentFoods();
                  },
                  quickAddSuccess: (String message, ratingPromptLogCount) {
                    context.read<LogFoodPageCubit>().reloadRecentFoods();
                  },
                  error: (String message) {
                    AppDialogs.showSnackBar(
                      message: message,
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    );
                  },
                  logFoodError: (message) {
                    AppDialogs.showSnackBar(
                      message: message,
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    );
                  },
                  logFoodDetailSuccess: (message, ratingPromptLogCount) {
                    context.read<LogFoodPageCubit>().reloadRecentFoods();
                  },
                  orElse: () {},
                );
              },
            ),

            BlocListener<LogFoodPageCubit, LogFoodPageState>(
              listener: (context, state) {
                if (state is LogFoodPageLoaded) {
                  _syncTabControllerWithSelectedTab(state.selectedTab);
                }
                state.maybeWhen(
                  createFoodSuccess: (message) async {
                    await context.read<LogFoodPageCubit>().reloadMyFoods();
                    if (context.mounted) {
                      context.read<LogFoodPageCubit>().selectTab('My Foods');
                    }
                  },
                  orElse: () {},
                );
              },
            ),
          ],
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    labelColor: Colors.blue[600],
                    unselectedLabelColor: Colors.grey[600],
                    labelStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: Colors.blue[600]!,
                        width: 2.w,
                      ),
                    ),
                    onTap: (index) {
                      final tabs = [
                        'All',
                        'My Meals',
                        'My Recipes',
                        'My Foods',
                      ];
                      context.read<LogFoodPageCubit>().selectTab(tabs[index]);
                    },
                    tabs: [
                      Tab(
                        child: Text(
                          'All',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'My Meals',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'My Recipes',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'My Foods',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                Expanded(
                  child: BlocBuilder<LogFoodPageCubit, LogFoodPageState>(
                    builder: (context, state) {
                      if (state is LogFoodPageLoading) {
                        return DataFetchLoadingWidget(
                          state: 'loading',
                          loadingMessage: 'Loading foods...',
                          loadingType: LoadingType.pulse,
                          primaryColor: Colors.blue[600],
                        );
                      }

                      if (state is LogFoodPageError) {
                        return UnifiedErrorDisplay(
                          message: ErrorTranslator.getMessage(state.message),
                          subtitle: 'Please retry to load foods.',
                          onRetry: () => context
                              .read<LogFoodPageCubit>()
                              .loadInitialData(selectedTab: 'All'),
                          primaryColor: Theme.of(context).colorScheme.primary,
                        );
                      }

                      if (state is LogFoodPageLoaded) {
                        if (state.isLoading) {
                          return Stack(
                            children: [
                              _buildContentForTab(state),
                              Container(
                                color: Colors.white.withOpacity(0.7),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue[600],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        if (state.errorMessage != null) {
                          return Column(
                            children: [
                              Expanded(child: _buildContentForTab(state)),
                              Container(
                                padding: EdgeInsets.all(16.w),
                                color: Colors.red[50],
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red[600],
                                      size: 20.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        ErrorTranslator.getMessage(
                                          state.errorMessage,
                                        ),
                                        style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => context
                                          .read<LogFoodPageCubit>()
                                          .loadInitialData(
                                            selectedTab: state.selectedTab,
                                          ),
                                      child: Text('Retry'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        return _buildContentForTab(state);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMealSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Select a Meal',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.h),
              ...mealOptions.map(
                (meal) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMeal = meal.value;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!, width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          meal.displayName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: selectedMeal == meal.value
                                ? Colors.blue[600]
                                : Colors.black,
                          ),
                        ),
                        const Spacer(),
                        if (selectedMeal == meal.value)
                          Icon(
                            Icons.check,
                            size: 20.sp,
                            color: Colors.blue[600],
                          ),
                      ],
                    ),
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

  Widget _buildMyMealsContent() {
    return BlocBuilder<LogFoodPageCubit, LogFoodPageState>(
      builder: (context, state) {
        if (state is! LogFoodPageLoaded) return const SizedBox.shrink();
        final meals = state.myMeals;
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 8.h, // Reduced top padding to move buttons up
                bottom: 20.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.restaurant,
                      title: 'Create a Meal',
                      isEnabled: true,
                      onTap: () async {
                        final availableFoods = [
                          ...state.myFoods,
                          ...state.suggestedFoods.where(
                            (f) => !state.myFoods.any((m) => m.id == f.id),
                          ),
                        ];
                        final created = await Navigator.of(context).push<bool>(
                          MaterialPageRoute(
                            builder: (_) =>
                                CreateMealPage(availableFoods: availableFoods),
                          ),
                        );
                        if (created == true && mounted) {
                          context.read<LogFoodPageCubit>().reloadTab(
                            'My Meals',
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.history,
                      title: 'Copy Previous Meal',
                      isEnabled:
                          selectedMeal !=
                          null, // Enabled only when meal is selected
                      onTap: selectedMeal != null
                          ? () async {
                              final seed = selectedMeal ?? 'Meal';
                              final ok = await context
                                  .read<LogFoodPageCubit>()
                                  .copyPreviousMeal('Copy of $seed');
                              if (!mounted) return;
                              AppDialogs.showSnackBar(
                                message: ok
                                    ? 'Copied previous meal'
                                    : 'Copy previous meal failed',
                                backgroundColor: ok ? Colors.green : Colors.red,
                              );
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _myMealsSearchController,
                      onChanged: (value) {
                        context.read<LogFoodPageCubit>().searchMyMeals(
                          query: value,
                          includeCommunity: _communityMealsMode,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: _communityMealsMode
                            ? 'Search community meals'
                            : 'Search my meals',
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.blue[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.blue[100]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.blue[400]!),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ChoiceChip(
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue[50],
                    label: Text(_communityMealsMode ? 'Community' : 'My Meals'),
                    selected: _communityMealsMode,
                    onSelected: (selected) {
                      setState(() {
                        _communityMealsMode = selected;
                      });
                      context.read<LogFoodPageCubit>().searchMyMeals(
                        query: _myMealsSearchController.text,
                        includeCommunity: selected,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: meals.isEmpty
                  ? Center(
                      child: Text(
                        _communityMealsMode
                            ? 'No community meals found'
                            : 'No meals yet',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: meals.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.h),
                      itemBuilder: (context, index) {
                        final meal = meals[index];
                        return FoodItem(
                          food: meal,
                          foods: meals,
                          selectedMeal: selectedMeal,
                          logForDate: widget.forDate,
                          onFoodSelected: (m) => _quickAddSavedMeal(m),
                          tabController: _tabController,
                          showDeleteAction: !_communityMealsMode,
                          onRowTapOverride: () async {
                            final id = meal.id;
                            if (id == null) return;
                            await context.router.push(
                              MealDetailRoute(mealId: id),
                            );
                          },
                          onDelete: _communityMealsMode
                              ? null
                              : (food) async {
                                  final ok = await context
                                      .read<LogFoodPageCubit>()
                                      .deleteMyMeal(meal);
                                  if (!mounted) return;
                                  AppDialogs.showSnackBar(
                                    message: ok
                                        ? 'Meal deleted'
                                        : 'Delete meal failed',
                                    backgroundColor: ok
                                        ? Colors.green
                                        : Colors.red,
                                  );
                                },
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDefaultContent(LogFoodPageLoaded state) {
    return Column(
      children: [
        // Quick Action Buttons - only show for default tabs
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Expanded(
                child: QuickActionButton(
                  icon: Icons.flash_on,
                  label: 'Quick add',
                  backgroundColor: Colors.blue[50]!,
                  iconColor: Colors.blue[600]!,
                  textColor: Colors.blue[600]!,
                  isNew: false,
                  onTap: () {
                    context.router.push(
                      QuickAddRoute(diaryDay: widget.forDate),
                    );
                  },
                ),
              ),
              SizedBox(width: 16.w),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextField(
            controller: _allSearchController,
            onChanged: _scheduleAllFoodSearch,
            decoration: InputDecoration(
              hintText: 'Search foods',
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.blue[200]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.blue[100]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.blue[400]!),
              ),
            ),
          ),
        ),

        SizedBox(height: 16.h),

        if (_allSearchController.text.trim().isNotEmpty)
          Expanded(
            child: state.searchResults.isEmpty
                ? Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: state.searchResults.length,
                    itemBuilder: (context, index) {
                      final food = state.searchResults[index];
                      return FoodItem(
                        tabController: _tabController,
                        food: food,
                        logForDate: widget.forDate,
                        onFoodSelected: (food) {
                          _quickAddWithNutritionGuard(food);
                        },
                        foods: state.searchResults,
                        selectedMeal: selectedMeal,
                      );
                    },
                  ),
          )
        else
          // Fixed Section Headers and Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
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
                          onTap: () => _showDateRangePicker(context, state),
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
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.blue[600],
                                  size: 16.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  _getDateRangeText(state),
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
                  ),
                  SizedBox(height: 16.h),
                  if (state.isLoadingAll)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.h),
                          child: LoadingWidget.medium(
                            message: 'Loading foods...',
                            type: LoadingType.circular,
                            color: Colors.blue[600],
                          ),
                        ),
                      ),
                    )
                  else if (state.recentFoods.isEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.h),
                          child: Text(
                            'No recent foods',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: state.recentFoods
                            .map(
                              (food) => FoodItem(
                                tabController: _tabController,
                                food: food,
                                logForDate: widget.forDate,
                                onFoodSelected: (food) {
                                  _quickAddWithNutritionGuard(food);
                                },
                                foods: state.recentFoods,
                                selectedMeal: selectedMeal,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  SizedBox(height: 24.h),
                  SuggestionsSection(
                    foods: state.suggestedFoods,
                    selectedMeal: selectedMeal,
                    tabController: _tabController,
                    logForDate: widget.forDate,
                    isLoadingMore: state.suggestedFoodsIsLoadingMore,
                    onLoadMore: () {
                      context.read<LogFoodPageCubit>().loadMoreSuggestions();
                    },
                    onFoodSelected: (food) {
                      _quickAddWithNutritionGuard(food);
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 20.h,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required bool isEnabled,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        height: 92.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.blue[50] : Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isEnabled ? Colors.blue[200]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: isEnabled ? Colors.blue[600] : Colors.grey[400],
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: isEnabled ? Colors.blue[600] : Colors.grey[400],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyRecipesContent() {
    return BlocBuilder<LogFoodPageCubit, LogFoodPageState>(
      builder: (context, state) {
        if (state is! LogFoodPageLoaded) return const SizedBox.shrink();
        final recipes = state.myRecipes;
        final hasActiveRecipeSearch = _myRecipesSearchController.text
            .trim()
            .isNotEmpty;
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 8.h,
                bottom: 20.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.restaurant_menu,
                      title: 'Create Recipe',
                      isEnabled: true,
                      onTap: () async {
                        final availableFoods = [
                          ...state.myFoods,
                          ...state.suggestedFoods.where(
                            (f) => !state.myFoods.any((m) => m.id == f.id),
                          ),
                        ];
                        final ok = await Navigator.of(context).push<bool>(
                          MaterialPageRoute(
                            builder: (_) => RecipeEditorPage(
                              availableFoods: availableFoods,
                            ),
                          ),
                        );
                        if (ok == true && mounted) {
                          _clearRecipeImageCache();
                          _reloadMyRecipesTab();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.auto_awesome,
                      title: 'Suggest recipe',
                      isEnabled: true,
                      onTap: () async {
                        final s = context.read<LogFoodPageCubit>().state;
                        if (s is! LogFoodPageLoaded) return;
                        final availableFoods = [
                          ...s.myFoods,
                          ...s.suggestedFoods.where(
                            (f) => !s.myFoods.any((m) => m.id == f.id),
                          ),
                        ];
                        await Navigator.of(context).push<void>(
                          MaterialPageRoute(
                            builder: (_) => SuggestRecipeFromFoodsPage(
                              availableFoods: availableFoods,
                            ),
                          ),
                        );
                        if (mounted) {
                          _clearRecipeImageCache();
                          _reloadMyRecipesTab();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.image_search_outlined,
                      title: 'AI photo recipe',
                      isEnabled: true,
                      onTap: () async {
                        await Navigator.of(context).push<void>(
                          MaterialPageRoute(
                            builder: (_) => const IngredientPhotoRecipePage(),
                          ),
                        );
                        if (mounted) {
                          _clearRecipeImageCache();
                          _reloadMyRecipesTab();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _myRecipesSearchController,
                      onChanged: _scheduleMyRecipesSearch,
                      decoration: InputDecoration(
                        hintText: _communityRecipesMode
                            ? 'Search community recipes'
                            : 'Search my recipes',
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.blue[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.blue[100]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.blue[400]!),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ChoiceChip(
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue[50],
                    label: Text(
                      _communityRecipesMode ? 'Community' : 'My Recipes',
                    ),
                    selected: _communityRecipesMode,
                    onSelected: (selected) {
                      setState(() {
                        _communityRecipesMode = selected;
                      });
                      context.read<LogFoodPageCubit>().searchMyRecipes(
                        _myRecipesSearchController.text,
                        includeCommunity: selected,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: recipes.isEmpty
                  ? Center(
                      child: Text(
                        hasActiveRecipeSearch
                            ? 'No recipes match your search'
                            : (_communityRecipesMode
                                  ? 'No community recipes found'
                                  : 'No recipes yet'),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 4.h,
                      ),
                      itemCount: recipes.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.h),
                      itemBuilder: (_, index) {
                        final recipe = recipes[index];
                        final canManageRecipe = !_communityRecipesMode;
                        return Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            border: Border.all(color: Colors.blue[100]!),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _recipeImageThumb(
                                    _getRecipeImageUrl(recipe.id),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final availableFoods = [
                                          ...state.myFoods,
                                          ...state.suggestedFoods.where(
                                            (f) => !state.myFoods.any(
                                              (m) => m.id == f.id,
                                            ),
                                          ),
                                        ];
                                        final ok = await Navigator.of(context)
                                            .push<bool>(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    RecipeEditorPage(
                                                      recipeId: recipe.id,
                                                      availableFoods:
                                                          availableFoods,
                                                      readOnly: true,
                                                    ),
                                              ),
                                            );
                                        if (ok == true && mounted) {
                                          _clearRecipeImageCache(recipe.id);
                                          _reloadMyRecipesTab();
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              recipe.name,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                          ),
                                          if (recipe.isVerified) ...[
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
                                    ),
                                  ),
                                ],
                              ),
                              if ((recipe.brand ?? '') == 'AI Fridge Plan') ...[
                                SizedBox(height: 6.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    border: Border.all(
                                      color: Colors.green[200]!,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    'AI Fridge Plan',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                              ],
                              if ((recipe.brand ?? '') == 'Community') ...[
                                SizedBox(height: 6.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[50],
                                    border: Border.all(
                                      color: Colors.orange[200]!,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    'Community',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange[800],
                                    ),
                                  ),
                                ),
                              ],
                              if ((recipe.brand ?? '') == 'AI Builder') ...[
                                SizedBox(height: 6.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[50],
                                    border: Border.all(
                                      color: Colors.indigo[200]!,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    'AI Builder',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.indigo[700],
                                    ),
                                  ),
                                ),
                              ],
                              if ((recipe.description ?? '')
                                  .trim()
                                  .isNotEmpty) ...[
                                SizedBox(height: 4.h),
                                Text(
                                  recipe.description!.trim(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                              SizedBox(height: 8.h),
                              Wrap(
                                spacing: 8.w,
                                runSpacing: 8.h,
                                children: [
                                  if (canManageRecipe)
                                    _recipeActionChip(
                                      label: 'Edit',
                                      icon: Icons.edit_outlined,
                                      onTap: () async {
                                        final availableFoods = [
                                          ...state.myFoods,
                                          ...state.suggestedFoods.where(
                                            (f) => !state.myFoods.any(
                                              (m) => m.id == f.id,
                                            ),
                                          ),
                                        ];
                                        final ok = await Navigator.of(context)
                                            .push<bool>(
                                              MaterialPageRoute(
                                                builder: (_) => RecipeEditorPage(
                                                  recipeId: recipe.id,
                                                  availableFoods: availableFoods,
                                                  readOnly: false,
                                                ),
                                              ),
                                            );
                                        if (ok == true && mounted) {
                                          _clearRecipeImageCache(recipe.id);
                                          _reloadMyRecipesTab();
                                        }
                                      },
                                    ),
                                  _recipeActionChip(
                                    label: 'Convert',
                                    icon: Icons.restaurant_menu_outlined,
                                    onTap: () async {
                                      final recipeId = recipe.id;
                                      if (recipeId == null) return;
                                      final ok = await context
                                          .read<LogFoodPageCubit>()
                                          .convertRecipeToMeal(recipeId);
                                      if (!mounted) return;
                                      AppDialogs.showSnackBar(
                                        message: ok
                                            ? 'Converted to meal'
                                            : 'Convert failed',
                                        backgroundColor: ok
                                            ? Colors.green
                                            : Colors.red,
                                      );
                                    },
                                  ),
                                  if (canManageRecipe)
                                    _recipeActionChip(
                                      label: 'Delete',
                                      icon: Icons.delete_outline,
                                      danger: true,
                                      onTap: () async {
                                        final ok = await context
                                            .read<LogFoodPageCubit>()
                                            .deleteMyRecipe(recipe);
                                        if (!mounted) return;
                                        _clearRecipeImageCache(recipe.id);
                                        AppDialogs.showSnackBar(
                                          message: ok
                                              ? 'Recipe deleted'
                                              : 'Delete failed',
                                          backgroundColor: ok
                                              ? Colors.green
                                              : Colors.red,
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _recipeActionChip({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool danger = false,
  }) {
    final color = danger ? Colors.red[500]! : Colors.blue[600]!;
    final border = danger ? Colors.red[200]! : Colors.blue[200]!;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14.sp, color: color),
              SizedBox(width: 4.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recipeImageThumb(Future<String?> imageUrlFuture) {
    return FutureBuilder<String?>(
      future: imageUrlFuture,
      builder: (context, snapshot) {
        final url = snapshot.data?.trim() ?? '';
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            width: 48.w,
            height: 48.w,
            color: Colors.grey[200],
            child: url.isEmpty
                ? Icon(
                    Icons.image_outlined,
                    color: Colors.grey[500],
                    size: 20.sp,
                  )
                : Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey[500],
                      size: 20.sp,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildMyFoodsContent() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 8.h,
            bottom: 20.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.add_circle_outline,
                  title: 'Create a Food',
                  isEnabled: true,
                  onTap: () {
                    context.router.push(CreateFoodRoute());
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.flash_on,
                  title: 'Quick add',
                  isEnabled: true,
                  onTap: () async {
                    await context.router.push(
                      QuickAddRoute(diaryDay: widget.forDate),
                    );
                    if (!mounted) return;
                    _tabController.animateTo(0);
                    context.read<LogFoodPageCubit>().selectTab('All');
                  },
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextField(
            controller: _myFoodsSearchController,
            onChanged: _scheduleMyFoodsSearch,
            decoration: InputDecoration(
              hintText: 'Search my foods',
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.blue[200]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.blue[100]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.blue[400]!),
              ),
            ),
          ),
        ),

        SizedBox(height: 16.h),

        Expanded(child: _listMyFoods()),
      ],
    );
  }

  Widget _buildContentForTab(LogFoodPageLoaded state) {
    if (state.selectedTab == 'My Meals') {
      return _buildMyMealsContent();
    } else if (state.selectedTab == 'My Recipes') {
      return _buildMyRecipesContent();
    } else if (state.selectedTab == 'My Foods') {
      return _buildMyFoodsContent();
    }
    return _buildDefaultContent(state);
  }

  Widget _listMyFoods() {
    return BlocBuilder<LogFoodPageCubit, LogFoodPageState>(
      builder: (context, state) {
        if (state is LogFoodPageLoaded) {
          if (state.isLoadingMyFoods ||
              state.isLoadingAll ||
              state.isLoadingMyRecipes ||
              state.isLoadingMyMeals) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: CircularProgressIndicator(color: Colors.blue[600]),
              ),
            );
          }

          final isSearchingMyFoods = _myFoodsSearchController.text
              .trim()
              .isNotEmpty;
          final filteredFoods = isSearchingMyFoods
              ? state.searchResults
              : state.myFoods;

          if (filteredFoods.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 64.sp,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      isSearchingMyFoods
                          ? 'No matching foods'
                          : 'No foods available',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      isSearchingMyFoods
                          ? 'Try a different keyword'
                          : 'Create your first food item',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            itemCount: filteredFoods.length + 1,
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Text(
                  'My Foods',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              final food = filteredFoods[index - 1];
              return FoodItem(
                food: food,
                foods: state.recentFoods,
                selectedMeal: selectedMeal,
                logForDate: widget.forDate,
                onFoodSelected: (f) {
                  _quickAddWithNutritionGuard(f, selectedTab: 'My Foods');
                },
                tabController: _tabController,
                showEditAction: true,
                onEdit: (food) async {
                  await context.router.push(
                    CreateFoodRoute(initialFood: food, isEditing: true),
                  );
                },
                showDeleteAction: true,
                onDelete: (food) async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Delete food'),
                      content: Text('Delete "${food.name}" from My Foods?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  if (confirmed != true) return;
                  final ok = await context
                      .read<LogFoodPageCubit>()
                      .deleteMyFood(food);
                  if (!mounted) return;
                  AppDialogs.showSnackBar(
                    message: ok
                        ? 'Food deleted successfully'
                        : 'Failed to delete food',
                    backgroundColor: ok ? Colors.green : Colors.red,
                    duration: const Duration(seconds: 2),
                  );
                },
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  String _getDateRangeText(LogFoodPageLoaded state) {
    final fromDate = state.fromDate;
    final toDate = state.toDate;
    if (fromDate != null && toDate != null) {
      return '${fromDate.day}/${fromDate.month}/${fromDate.year} - ${toDate.day}/${toDate.month}/${toDate.year}';
    }
    return 'Select Date Range';
  }

  void _showDateRangePicker(BuildContext context, LogFoodPageLoaded state) {
    DateTime? fromDate = state.fromDate;
    DateTime? toDate = state.toDate;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(16.w),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
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
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Builder(
                            builder: (context) {
                              final from = fromDate;
                              return ListTile(
                                title: Text(
                                  'From Date',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  from != null
                                      ? '${from.day}/${from.month}/${from.year}'
                                      : 'Select start date',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: from != null
                                        ? Colors.black
                                        : Colors.grey[400],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.calendar_today,
                                  size: 20.sp,
                                ),
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: fromDate ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: toDate ?? DateTime.now(),
                                  );
                                  if (picked != null) {
                                    setModalState(() {
                                      fromDate = picked;
                                    });
                                  }
                                },
                              );
                            },
                          ),
                          Divider(),
                          Builder(
                            builder: (context) {
                              final to = toDate;
                              return ListTile(
                                title: Text(
                                  'To Date',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  to != null
                                      ? '${to.day}/${to.month}/${to.year}'
                                      : 'Select end date',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: to != null
                                        ? Colors.black
                                        : Colors.grey[400],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.calendar_today,
                                  size: 20.sp,
                                ),
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        toDate ?? (fromDate ?? DateTime.now()),
                                    firstDate: fromDate ?? DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    setModalState(() {
                                      toDate = picked;
                                    });
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 16.h),
                          if (fromDate != null || toDate != null)
                            TextButton(
                              onPressed: () {
                                setModalState(() {
                                  fromDate = null;
                                  toDate = null;
                                });
                              },
                              child: Text(
                                'Clear',
                                style: TextStyle(color: Colors.red[600]),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Apply button
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<LogFoodPageCubit>().setDateRange(
                              fromDate: fromDate,
                              toDate: toDate,
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            foregroundColor: Colors.white,
                          ),
                          child: Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// Mock repository for demonstration
