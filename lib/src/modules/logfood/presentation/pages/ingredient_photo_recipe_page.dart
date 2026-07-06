import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../core/data/local/storage.dart';
import '../../../../core/recipe/recipe_generation_coordinator.dart';
import '../../../../core/services/firebase_storage_upload_service.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../data/models/ingredient_recognition_model.dart';
import '../../helper/log_food_helper.dart';
import '../application/cubit/ingredient_vision_cubit.dart';
import '../application/cubit/ingredient_vision_state.dart';

class IngredientPhotoRecipePage extends StatelessWidget {
  const IngredientPhotoRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<IngredientVisionCubit>(),
      child: const _IngredientPhotoRecipePageBody(),
    );
  }
}

class _IngredientPhotoRecipePageBody extends StatefulWidget {
  const _IngredientPhotoRecipePageBody();

  @override
  State<_IngredientPhotoRecipePageBody> createState() =>
      _IngredientPhotoRecipePageBodyState();
}

class _IngredientPhotoRecipePageBodyState
    extends State<_IngredientPhotoRecipePageBody> {
  static const _slots = ['breakfast', 'lunch', 'dinner', 'snack'];
  static const _difficulties = ['easy', 'medium', 'hard'];

  File? _image;
  String? _imageUrl;
  String _mealSlot = 'lunch';
  String _difficulty = 'easy';
  final _prepController = TextEditingController();
  final _maxCaloriesController = TextEditingController();
  final _preferenceController = TextEditingController();
  final List<_IngredientSelection> _ingredients = [];

  @override
  void dispose() {
    _prepController.dispose();
    _maxCaloriesController.dispose();
    _preferenceController.dispose();
    for (final item in _ingredients) {
      item.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImage(bool camera) async {
    try {
      final file = camera
          ? await ImagePickerService.takePhoto(
              maxWidth: 1200,
              imageQuality: 70,
            )
          : await ImagePickerService.pickFromGallery(
              maxWidth: 1200,
              imageQuality: 70,
            );
      if (file == null || !mounted) return;
      setState(() {
        _image = file;
        _imageUrl = null;
        _replaceIngredients([]);
      });
    } catch (_) {
      AppDialogs.showSnackBar(
        message: camera ? 'Failed to take photo' : 'Failed to pick image',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> _recognize() async {
    final image = _image;
    if (image == null) {
      AppDialogs.showSnackBar(
        message: 'Choose an ingredient photo first.',
        backgroundColor: Colors.orange.shade800,
      );
      return;
    }

    try {
      final url =
          _imageUrl ??
          await FirebaseStorageUploadService.uploadImageFile(
            filePath: image.path,
            folder: 'ingredient-images',
            ownerId: Storage.userID?.toString(),
          );
      _imageUrl = url;
      if (!mounted) return;
      context.read<IngredientVisionCubit>().recognize(url, topK: 5);
    } catch (_) {
      if (!mounted) return;
      AppDialogs.showSnackBar(
        message: 'Failed to upload ingredient photo.',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> _matchAgain(_IngredientSelection item) async {
    final name = item.controller.text.trim();
    if (name.length < 2) {
      AppDialogs.showSnackBar(
        message: 'Ingredient name is too short.',
        backgroundColor: Colors.orange.shade800,
      );
      return;
    }
    context.read<IngredientVisionCubit>().matchAgain(item.id, name);
  }

  void _generateRecipe() {
    final selected = _ingredients
        .map((item) => item.selectedCandidate)
        .whereType<FoodCandidateModel>()
        .toList();
    if (selected.isEmpty) {
      AppDialogs.showSnackBar(
        message: 'Select at least one matched food.',
        backgroundColor: Colors.orange.shade800,
      );
      return;
    }
    if (selected.length != _ingredients.length) {
      AppDialogs.showSnackBar(
        message: 'Choose one food for each detected ingredient.',
        backgroundColor: Colors.orange.shade800,
      );
      return;
    }

    final foodIds = selected.map((item) => item.foodId).toSet().toList()
      ..sort();
    final foods = selected.map((item) => item.toFoodModel()).toList();
    final constraints = <String, dynamic>{'difficulty': _difficulty};
    final prep = int.tryParse(_prepController.text.trim());
    if (prep != null && prep > 0) {
      constraints['preparationTime'] = prep;
    }
    final maxCalories = int.tryParse(_maxCaloriesController.text.trim());
    if (maxCalories != null && maxCalories > 0) {
      constraints['maxCalories'] = maxCalories;
    }
    final preference = _preferenceController.text.trim();
    if (preference.isNotEmpty) {
      constraints['description'] = preference;
    }

    RecipeGenerationCoordinator.instance.startGenerate(
      foodIds: foodIds,
      mealSlot: _mealSlot,
      date: LogFoodHelper().dateKeyFrom(DateTime.now()),
      constraints: constraints,
      availableFoods: foods,
    );
    Navigator.of(context).pop();
  }

  void _replaceIngredients(List<DetectedIngredientModel> ingredients) {
    final previousSelected = {
      for (final item in _ingredients) item.id: item.selectedFoodId,
    };
    for (final item in _ingredients) {
      item.dispose();
    }
    _ingredients
      ..clear()
      ..addAll(ingredients.map((detected) {
        final selection = _IngredientSelection.fromDetected(detected);
        final previousFoodId = previousSelected[selection.id];
        if (previousFoodId != null &&
            detected.candidates.any((c) => c.foodId == previousFoodId)) {
          selection.selectedFoodId = previousFoodId;
        }
        return selection;
      }));
  }

  void _removeIngredient(_IngredientSelection item) {
    setState(() {
      item.dispose();
      _ingredients.remove(item);
    });
    context.read<IngredientVisionCubit>().replaceAll(
      _ingredients.map((entry) => entry.toDetected()).toList(),
    );
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

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final visionState = context.watch<IngredientVisionCubit>().state;
    final isBusy = visionState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return BlocListener<IngredientVisionCubit, IngredientVisionState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (ingredients, _) {
            if (mounted) {
              setState(() => _replaceIngredients(ingredients));
            }
            if (ingredients.isEmpty) {
              AppDialogs.showSnackBar(
                message: 'No ingredients detected. Try another photo.',
                backgroundColor: Colors.orange.shade800,
              );
            }
          },
          failure: (message) {
            AppDialogs.showSnackBar(
              message: message,
              backgroundColor: Colors.red,
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colors.surfaceBright,
          title: const Text('AI recipe from photo'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
            children: [
              _imagePreview(colors),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: isBusy ? null : () => _pickImage(false),
                      icon: const Icon(Icons.photo_library_outlined),
                      label: const Text('Gallery'),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: isBusy ? null : () => _pickImage(true),
                      icon: const Icon(Icons.photo_camera_outlined),
                      label: const Text('Camera'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              FilledButton.icon(
                onPressed: isBusy ? null : _recognize,
                icon: isBusy
                    ? SizedBox(
                        width: 18.w,
                        height: 18.w,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.auto_awesome),
                label: Text(isBusy ? 'Processing...' : 'Recognize ingredients'),
              ),
              SizedBox(height: 18.h),
              if (_ingredients.isNotEmpty) ...[
                Text(
                  'Detected ingredients',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.h),
                ..._ingredients.map((item) => _ingredientCard(item, colors)),
                SizedBox(height: 8.h),
                OutlinedButton.icon(
                  onPressed: isBusy
                      ? null
                      : () {
                          setState(() {
                            _ingredients.add(_IngredientSelection(
                              id: 'manual-${_ingredients.length + 1}',
                              name: '',
                              candidates: [],
                            ));
                          });
                        },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add missing ingredient'),
                ),
                SizedBox(height: 18.h),
                _recipeOptions(colors),
                SizedBox(height: 18.h),
                FilledButton(
                  onPressed: isBusy ? null : _generateRecipe,
                  child: const Text('Generate and save recipe'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePreview(ColorScheme colors) {
    final image = _image;
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: image == null
            ? Center(
                child: Icon(
                  Icons.image_search_outlined,
                  size: 42.sp,
                  color: colors.onSurfaceVariant,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(image, fit: BoxFit.cover),
              ),
      ),
    );
  }

  Widget _ingredientCard(_IngredientSelection item, ColorScheme colors) {
    final isBusy = context.watch<IngredientVisionCubit>().state.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: item.controller,
                  decoration: const InputDecoration(
                    labelText: 'Ingredient name',
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              IconButton(
                tooltip: 'Match again',
                onPressed: isBusy ? null : () => _matchAgain(item),
                icon: const Icon(Icons.search),
              ),
              IconButton(
                tooltip: 'Remove ingredient',
                onPressed: isBusy ? null : () => _removeIngredient(item),
                icon: Icon(Icons.delete_outline, color: colors.error),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          if (item.candidates.isEmpty)
            Text(
              'No matching foods found',
              style: TextStyle(color: colors.error, fontSize: 13.sp),
            )
          else
            ...item.candidates.map(
              (candidate) => RadioListTile<int>(
                value: candidate.foodId,
                groupValue: item.selectedFoodId,
                contentPadding: EdgeInsets.zero,
                dense: true,
                onChanged: (value) {
                  setState(() => item.selectedFoodId = value);
                },
                title: Text(
                  candidate.foodName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${_formatAmount(candidate.servingSize)} ${candidate.servingUnit} - '
                  '${candidate.calories.round()} kcal - '
                  'score ${(candidate.score * 100).round()}%',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _recipeOptions(ColorScheme colors) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Recipe options',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _slots.map((slot) {
              return ChoiceChip(
                backgroundColor: Colors.white,
                selectedColor: colors.primaryContainer,
                label: Text(_mealLabel(slot)),
                selected: _mealSlot == slot,
                onSelected: (_) => setState(() => _mealSlot = slot),
              );
            }).toList(),
          ),
          SizedBox(height: 12.h),
          DropdownButtonFormField<String>(
            value: _difficulty,
            decoration: const InputDecoration(labelText: 'Difficulty'),
            items: _difficulties
                .map(
                  (value) => DropdownMenuItem(value: value, child: Text(value)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _difficulty = value);
            },
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: _prepController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Max prep time (minutes, optional)',
            ),
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: _maxCaloriesController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Max calories (kcal, optional)',
            ),
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: _preferenceController,
            minLines: 2,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Dish preference (optional)',
              hintText: 'e.g. less oily, warm soup style, high protein',
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double value) {
    final rounded = value.roundToDouble();
    if ((value - rounded).abs() < 1e-9) {
      return rounded.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }
}

class _IngredientSelection {
  _IngredientSelection({
    required this.id,
    required String name,
    required this.candidates,
    this.confidence = 0,
  }) : controller = TextEditingController(text: name),
       selectedFoodId = candidates.isEmpty ? null : candidates.first.foodId;

  factory _IngredientSelection.fromDetected(DetectedIngredientModel item) {
    return _IngredientSelection(
      id: item.clientIngredientId,
      name: item.detectedName,
      candidates: item.candidates,
      confidence: item.confidence,
    );
  }

  final String id;
  final double confidence;
  final TextEditingController controller;
  List<FoodCandidateModel> candidates;
  int? selectedFoodId;

  DetectedIngredientModel toDetected() {
    return DetectedIngredientModel(
      clientIngredientId: id,
      detectedName: controller.text.trim(),
      confidence: confidence,
      candidates: candidates,
    );
  }

  FoodCandidateModel? get selectedCandidate {
    final selected = selectedFoodId;
    if (selected == null) return null;
    for (final candidate in candidates) {
      if (candidate.foodId == selected) return candidate;
    }
    return null;
  }

  void replace(DetectedIngredientModel item) {
    candidates = item.candidates;
    selectedFoodId = candidates.isEmpty ? null : candidates.first.foodId;
  }

  void dispose() {
    controller.dispose();
  }
}
