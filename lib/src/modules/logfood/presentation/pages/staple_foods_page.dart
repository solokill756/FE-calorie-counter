import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../core/data/local/storage.dart';
import '../../../../core/recipe/fridge_plan_quota_notifier.dart';
import '../../../../core/recipe/recipe_generation_coordinator.dart';
import '../../data/models/food_model.dart';
import '../../data/models/recipe_model.dart';
import '../../domain/repository/food_repository.dart';
import '../../helper/log_food_helper.dart';
import '../application/cubit/staple_foods_cubit.dart';
import '../application/cubit/staple_foods_state.dart';
import 'recipe_editor_page.dart';

@RoutePage()
class StapleFoodsPage extends StatelessWidget {
  const StapleFoodsPage({
    super.key,
    required this.availableFoods,
    this.pantryOnly = false,
  });

  final List<FoodModel> availableFoods;

  /// When true (e.g. opened from More), hide recipe generation — manage staples only.
  final bool pantryOnly;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<StapleFoodsCubit>()..load(),
      child: _StapleFoodsView(
        availableFoods: availableFoods,
        pantryOnly: pantryOnly,
      ),
    );
  }
}

class _StapleFoodsView extends StatefulWidget {
  const _StapleFoodsView({
    required this.availableFoods,
    this.pantryOnly = false,
  });

  final List<FoodModel> availableFoods;
  final bool pantryOnly;

  @override
  State<_StapleFoodsView> createState() => _StapleFoodsViewState();
}

class _StapleFoodsViewState extends State<_StapleFoodsView> {
  final _search = TextEditingController();
  List<FoodModel> _results = [];
  bool _generating = false;
  bool _autoCreatePlanRecipes = true;
  bool _generationInProgress = false;
  Timer? _debounce;

  static const _mealSlots = ['breakfast', 'lunch', 'dinner', 'snack'];

  Color get _primary => Colors.blue[600]!;

  @override
  void initState() {
    super.initState();
    _autoCreatePlanRecipes = Storage.autoCreatePlanRecipes;
    _loadGenerationStatus();
    FridgePlanGenerationNotifier.instance.addListener(_onGenerationStatusChanged);
    _search.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    FridgePlanGenerationNotifier.instance.removeListener(_onGenerationStatusChanged);
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  void _onGenerationStatusChanged() {
    if (!mounted) return;
    setState(
      () => _generationInProgress =
          FridgePlanGenerationNotifier.instance.inProgress,
    );
  }

  Future<void> _loadGenerationStatus() async {
    final res = await getIt<FoodRepository>().getFridgeGenerationStatus();
    if (!mounted) return;
    res.fold(
      (status) {
        final inFlight = status.inProgress ||
            RecipeGenerationCoordinator.instance.isFridgePlanInFlight;
        _generationInProgress = inFlight;
        FridgePlanGenerationNotifier.instance.setInProgress(inFlight);
        setState(() {});
      },
      (_) {},
    );
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _runSearch(_search.text);
    });
  }

  InputDecoration _searchDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
    );
  }

  Future<void> _runSearch(String q) async {
    final query = q.trim();
    if (query.length < 2) {
      setState(() => _results = []);
      return;
    }
    final res = await getIt<FoodRepository>().searchFoods(query);
    if (!mounted) return;
    res.fold(
      (foods) => setState(() => _results = foods),
      (_) => setState(() => _results = []),
    );
  }

  Future<void> _add(FoodModel food) async {
    final id = food.id;
    if (id == null) {
      AppDialogs.showWarningSnackBar(message: 'This item has no food id');
      return;
    }
    context.read<StapleFoodsCubit>().add(id);
    if (!mounted) return;
    setState(() {
      _results = [];
      _search.clear();
    });
  }

  Future<void> _confirmRemove(FoodModel food) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Remove from pantry?',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        content: Text(
          '“${food.name}” will no longer be used for AI recipes. You can add it again later.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Remove',
              style: TextStyle(
                color: Colors.red[700],
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final id = food.id;
    if (id == null) return;
    context.read<StapleFoodsCubit>().remove(id);
  }

  String _mealLabel(String slot) {
    switch (slot) {
      case 'breakfast':
        return 'Breakfast';
      case 'lunch':
        return 'Lunch';
      case 'dinner':
        return 'Dinner';
      case 'snack':
        return 'Snack';
      default:
        return slot;
    }
  }

  /// Picker flow: bottom sheet (per app dialog rules).
  Future<String?> _pickMealSlot() async {
    var selected = 'lunch';
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
            child: StatefulBuilder(
              builder: (ctx, setS) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Meal for recipe',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: _primary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Uses your pantry staples and today’s remaining calories and macros.",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ..._mealSlots.map(
                      (s) => ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                        title: Text(
                          _mealLabel(s),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        trailing: Icon(
                          selected == s
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: selected == s ? _primary : Colors.grey[400],
                          size: 22.sp,
                        ),
                        onTap: () => setS(() => selected = s),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[800],
                              side: BorderSide(color: Colors.blue[200]!),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: FilledButton(
                            onPressed: () => Navigator.pop(ctx, selected),
                            style: FilledButton.styleFrom(
                              backgroundColor: _primary,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: const Text('Generate'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _suggest() async {
    if (widget.pantryOnly) return;
    final state = context.read<StapleFoodsCubit>().state;
    final staples = state.maybeWhen(
      success: (list) => list,
      orElse: () => <FoodModel>[],
    );
    if (staples.isEmpty) {
      AppDialogs.showSnackBar(
        message: 'Add at least one staple food first',
        backgroundColor: Colors.orange,
      );
      return;
    }
    final slot = await _pickMealSlot();
    if (slot == null || !mounted) return;

    setState(() => _generating = true);
    final helper = LogFoodHelper();
    final dateKey = helper.dateKeyFrom(DateTime.now());
    final res = await getIt<FoodRepository>().generateRecipeFromStaples(
      mealSlot: slot,
      date: dateKey,
    );
    if (!mounted) return;
    setState(() => _generating = false);

    res.fold(
      (data) async {
        AppDialogs.showSnackBar(message: 'Recipe generated successfully');
        if (!mounted) return;
        final draft = data.recipeDraft.withSourceMetadata(
          sourceType: RecipeModel.sourceAiRecipeBuilder,
          mealSlot: slot,
          dateKey: dateKey,
        );
        final saved = await Navigator.of(context).push<bool>(
          MaterialPageRoute(
            builder: (_) => RecipeEditorPage(
              initialDraft: draft,
              availableFoods: widget.availableFoods,
              readOnly: true,
            ),
          ),
        );
        if (saved == true && mounted) {
          Navigator.of(context).pop(true);
        }
      },
      (err) => AppDialogs.showSnackBar(
        message: err.message.isNotEmpty ? err.message : 'Generate failed',
        backgroundColor: Colors.red,
      ),
    );
  }

  void _generateTodayPlan() {
    if (_generationInProgress ||
        RecipeGenerationCoordinator.instance.isFridgePlanInFlight) {
      AppDialogs.showWarningSnackBar(
        message: 'A fridge plan is already generating. Please wait.',
      );
      return;
    }
    final state = context.read<StapleFoodsCubit>().state;
    final staples = state.maybeWhen(
      success: (list) => list,
      orElse: () => <FoodModel>[],
    );
    if (staples.length < 2) {
      AppDialogs.showWarningSnackBar(
        message: 'Add at least two staple foods first',
      );
      return;
    }

    final dateKey = LogFoodHelper().dateKeyFrom(DateTime.now());
    RecipeGenerationCoordinator.instance.startFridgeMealPlan(date: dateKey);
    setState(() => _generationInProgress = true);
  }

  Widget _buildSuggestCta() {
    if (widget.pantryOnly) return const SizedBox.shrink();
    final state = context.read<StapleFoodsCubit>().state;
    final staples = state.maybeWhen(
      success: (list) => list,
      orElse: () => <FoodModel>[],
    );
    final enabled = !_generating && staples.isNotEmpty;
    return GestureDetector(
      onTap: enabled ? _suggest : null,
      child: Container(
        height: 80.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: enabled ? Colors.blue[50] : Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: enabled ? Colors.blue[200]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 24.sp,
              color: enabled ? _primary : Colors.grey[400],
            ),
            SizedBox(height: 4.h),
            Text(
              'Suggest recipe from pantry',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: enabled ? _primary : Colors.grey[400],
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

  Widget _stapleCard(FoodModel f) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue[100]!),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.inventory_2_outlined, color: _primary, size: 22.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              f.name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blue[700],
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red[400],
              size: 22.sp,
            ),
            onPressed: () => _confirmRemove(f),
            tooltip: 'Remove',
          ),
        ],
      ),
    );
  }

  Widget _searchResultTile(FoodModel f) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _add(f),
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.blue[50]!)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  f.name,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                ),
              ),
              if (f.id != null)
                Text(
                  '#${f.id}',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
              SizedBox(width: 8.w),
              Icon(Icons.add_circle_outline, color: _primary, size: 22.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(List<FoodModel> staples) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 4.h),
          child: Text(
            'Search & add',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextField(
            controller: _search,
            decoration: _searchDecoration(
              'Search foods to add to pantry',
            ),
          ),
        ),
        if (_results.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              constraints: BoxConstraints(maxHeight: 220.h),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _results.length,
                  itemBuilder: (_, i) =>
                      _searchResultTile(_results[i]),
                ),
              ),
            ),
          ),
        ],
        SizedBox(height: 16.h),
        if (widget.pantryOnly && !_autoCreatePlanRecipes)
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
            child: FilledButton.icon(
              onPressed:
                  _generationInProgress ? null : _generateTodayPlan,
              style: FilledButton.styleFrom(
                backgroundColor: _primary,
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              icon: const Icon(Icons.auto_awesome),
              label: Text(
                _generationInProgress
                    ? 'Generating plan…'
                    : 'Generate Today',
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Your staples',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              if (staples.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Text(
                    'No staples yet. Search above to add foods you cook with often.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                )
              else
                ...staples.map(_stapleCard),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
          child: _buildSuggestCta(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StapleFoodsCubit>().state;
    return BlocListener<StapleFoodsCubit, StapleFoodsState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (_) {
            // SnackBar is handled per-action in Cubit reload; do not duplicate
          },
          failure: (message) {
            AppDialogs.showErrorSnackBar(message: message);
          },
          orElse: () {},
        );
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  widget.pantryOnly ? 'Pantry' : 'Pantry staples',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: _primary,
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
              body: SafeArea(
                child: state.maybeWhen(
                  loading: () => Center(
                    child: CircularProgressIndicator(color: _primary),
                  ),
                  success: (list) => _buildContent(list),
                  failure: (_) => _buildContent([]),
                  orElse: () => _buildContent([]),
                ),
              ),
            ),
            if (_generating && !widget.pantryOnly)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black.withValues(alpha: 0.35),
                  child: Center(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(color: _primary),
                            SizedBox(height: 16.h),
                            Text(
                              'Generating recipe…',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
