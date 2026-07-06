import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../core/recipe/recipe_generation_coordinator.dart';
import '../../data/models/food_model.dart';
import '../../domain/repository/food_repository.dart';
import '../../helper/log_food_helper.dart';

/// Picks several foods (no pantry POST) and starts background recipe generation with [foodIds].
class SuggestRecipeFromFoodsPage extends StatefulWidget {
  const SuggestRecipeFromFoodsPage({super.key, required this.availableFoods});

  final List<FoodModel> availableFoods;

  @override
  State<SuggestRecipeFromFoodsPage> createState() =>
      _SuggestRecipeFromFoodsPageState();
}

class _SuggestRecipeFromFoodsPageState
    extends State<SuggestRecipeFromFoodsPage> {
  final Set<int> _selectedIds = {};
  final Map<int, FoodModel> _selectedFoodCache = {};
  String _mealSlot = 'lunch';
  final TextEditingController _search = TextEditingController();
  final TextEditingController _preferenceController = TextEditingController();

  /// Same as All tab: server search via `includeAll: true`; empty → show [availableFoods].
  String _searchQuery = '';
  List<FoodModel> _searchResults = [];
  int _searchSeq = 0;
  Timer? _searchDebounce;

  static const _slots = ['breakfast', 'lunch', 'dinner', 'snack'];

  Color get _primary => Colors.blue[600]!;

  List<FoodModel> get _displayFoods {
    if (_searchQuery.isEmpty) return widget.availableFoods;
    return _searchResults;
  }

  List<FoodModel> get _selectedFoods {
    final byId = <int, FoodModel>{};
    for (final f in widget.availableFoods) {
      final id = f.id;
      if (id != null) byId[id] = f;
    }
    for (final f in _searchResults) {
      final id = f.id;
      if (id != null) byId[id] = f;
    }
    byId.addAll(_selectedFoodCache);
    return _selectedIds.map((id) => byId[id]).whereType<FoodModel>().toList();
  }

  /// Foods from this screen + API hits so [RecipeEditorPage] can resolve ingredients.
  List<FoodModel> _mergedAvailableForCoordinator() {
    final map = <int, FoodModel>{};
    for (final f in widget.availableFoods) {
      final id = f.id;
      if (id != null) map[id] = f;
    }
    for (final f in _searchResults) {
      final id = f.id;
      if (id != null) map[id] = f;
    }
    return map.values.toList();
  }

  Future<void> _runSearch(String raw) async {
    final q = raw.trim();
    final seq = ++_searchSeq;
    setState(() => _searchQuery = q);
    if (q.length < 2) {
      setState(() => _searchResults = []);
      return;
    }
    final res = await getIt<FoodRepository>().searchFoods(q, includeAll: true);
    if (!mounted || seq != _searchSeq) return;
    res.fold(
      (foods) => setState(() => _searchResults = foods),
      (_) => setState(() => _searchResults = []),
    );
  }

  void _onSearchChanged(String raw) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _runSearch(raw);
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _search.dispose();
    _preferenceController.dispose();
    super.dispose();
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

  void _toggle(FoodModel f) {
    final id = f.id;
    if (id == null) return;
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
        _selectedFoodCache.remove(id);
      } else {
        _selectedIds.add(id);
        _selectedFoodCache[id] = f;
      }
    });
  }

  void _removeSelected(int id) {
    setState(() {
      _selectedIds.remove(id);
      _selectedFoodCache.remove(id);
    });
  }

  void _onGenerate() {
    if (_selectedIds.isEmpty) {
      AppDialogs.showSnackBar(
        message: 'Select at least one food.',
        backgroundColor: Colors.orange,
      );
      return;
    }
    final helper = LogFoodHelper();
    final dateKey = helper.dateKeyFrom(DateTime.now());
    final ids = _selectedIds.toList()..sort();
    final preference = _preferenceController.text.trim();
    final constraints = <String, dynamic>{};
    if (preference.isNotEmpty) {
      constraints['description'] = preference;
    }
    Navigator.of(context).pop();
    RecipeGenerationCoordinator.instance.startGenerate(
      foodIds: ids,
      mealSlot: _mealSlot,
      date: dateKey,
      constraints: constraints.isEmpty ? null : constraints,
      availableFoods: _mergedAvailableForCoordinator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedFoods = _selectedFoods;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Suggest recipe',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 4.h),
              child: Text(
                'Meal',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _slots.map((s) {
                  final on = _mealSlot == s;
                  return ChoiceChip(
                    disabledColor: Colors.white,
                    selectedShadowColor: Colors.white,
                    label: Text(_mealLabel(s)),
                    selected: on,
                    onSelected: (_) => setState(() => _mealSlot = s),
                    selectedColor: Colors.blue[100],
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 13.sp,
                      color: on ? _primary : Colors.black87,
                      fontWeight: on ? FontWeight.w600 : FontWeight.w400,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: _search,
                onChanged: _onSearchChanged,
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
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: _preferenceController,
                minLines: 2,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText:
                      'Describe your desired dish (e.g. light, less oily, quick to cook)',
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
            if (selectedFoods.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected ingredients (${selectedFoods.length})',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 104.h),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: selectedFoods.map((food) {
                            final id = food.id;
                            return InputChip(
                              label: Text(
                                food.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              ),
                              onDeleted: id == null
                                  ? null
                                  : () => _removeSelected(id),
                              deleteIcon: Icon(
                                Icons.close,
                                size: 16.sp,
                                color: colorScheme.onPrimaryContainer,
                              ),
                              backgroundColor: colorScheme.primaryContainer,
                              side: BorderSide(
                                color: colorScheme.primary.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
              child: Text(
                'Choose ingredients (saved only when you finish the recipe editor)',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
              ),
            ),
            Expanded(
              child: _searchQuery.isNotEmpty && _displayFoods.isEmpty
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
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      itemCount: _displayFoods.length,
                      itemBuilder: (context, i) {
                        final f = _displayFoods[i];
                        final id = f.id;
                        final checked = id != null && _selectedIds.contains(id);
                        return CheckboxListTile(
                          value: checked,
                          onChanged: id == null ? null : (_) => _toggle(f),
                          title: Text(
                            f.name,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          subtitle: id != null
                              ? Text('#$id', style: TextStyle(fontSize: 11.sp))
                              : const Text('No id — cannot use for generation'),
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              child: FilledButton(
                onPressed: _onGenerate,
                style: FilledButton.styleFrom(
                  backgroundColor: _primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Generate',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
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
