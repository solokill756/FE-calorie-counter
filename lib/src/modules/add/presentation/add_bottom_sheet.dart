import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:caloriecounter/src/modules/logfood/data/models/food_model.dart';
import 'package:caloriecounter/src/modules/logfood/domain/repository/food_repository.dart';
import 'package:caloriecounter/src/modules/logfood/presentation/pages/ingredient_photo_recipe_page.dart';
import 'package:caloriecounter/src/modules/logfood/presentation/pages/suggest_recipe_from_foods_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'application/add_cubit/add_cubit.dart';
import 'components/add_components.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      builder: (context) => BlocProvider(
        create: (context) => AddCubit(),
        child: const AddBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit, AddState>(
      listener: (context, state) {
        // Handle navigation based on selected action
        if (state.selectedAction != null) {
          Navigator.pop(context);
          _handleAction(context, state.selectedAction!);
        }
      },
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.62,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar
              Container(
                margin: EdgeInsets.only(top: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ), // Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    child: AddComponents.buildQuickAddOptions(
                      context,
                      onLogFoodTap: () => context.read<AddCubit>().logFood(),
                      onBarcodeScanTap: () =>
                          context.read<AddCubit>().barcodeScan(),
                      onVoiceLogTap: () => context.read<AddCubit>().voiceLog(),
                      onMealScanTap: () => context.read<AddCubit>().mealScan(),
                      onWaterTap: () => context.read<AddCubit>().addWater(),
                      onWeightTap: () => context.read<AddCubit>().addWeight(),
                      onExerciseTap: () =>
                          context.read<AddCubit>().addExercise(),
                      onAiSuggestRecipeTap: () =>
                          context.read<AddCubit>().aiSuggestRecipe(),
                      onAiPhotoRecipeTap: () =>
                          context.read<AddCubit>().aiPhotoRecipe(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleAction(BuildContext context, AddAction action) {
    // Handle the selected action
    switch (action) {
      case AddAction.logFood:
        context.router.push(LogFoodRoute());
        break;
      case AddAction.barcodeScan:
        _showMessage('Opening Barcode Scanner...');
        break;
      case AddAction.voiceLog:
        _showMessage('Starting Voice Log...');
        break;
      case AddAction.mealScan:
        _showMessage('Opening Camera for Meal Scan...');
        break;
      case AddAction.water:
        context.router.push(const WaterLogRoute());
        break;
      case AddAction.weight:
        context.router.push(WeightFormRoute());
        break;
      case AddAction.exercise:
        context.router.push(const ExerciseHomeRoute());
        break;
      case AddAction.aiSuggestRecipe:
        _openAiSuggestRecipe(context);
        break;
      case AddAction.aiPhotoRecipe:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const IngredientPhotoRecipePage(),
          ),
        );
        break;
    }
  }

  Future<void> _openAiSuggestRecipe(BuildContext context) async {
    final navigator = Navigator.of(context);
    _showMessage('Loading foods for AI recipe...');
    final repo = getIt<FoodRepository>();
    final myFoodsResult = await repo.getMyFoods();
    final suggestedFoods = await repo.getSuggestedFoods(pageSize: 25);
    final myFoods = myFoodsResult.fold(
      (foods) => foods,
      (_) => <FoodModel>[],
    );
    final byId = <int, FoodModel>{};
    for (final food in [...myFoods, ...suggestedFoods]) {
      final id = food.id;
      if (id != null) byId[id] = food;
    }
    final availableFoods = byId.values.toList();
    if (availableFoods.isEmpty) {
      AppDialogs.showSnackBar(
        message: 'No foods available for recipe generation.',
        backgroundColor: Colors.orange.shade800,
      );
      return;
    }
    navigator.push(
      MaterialPageRoute(
        builder: (_) => SuggestRecipeFromFoodsPage(
          availableFoods: availableFoods,
        ),
      ),
    );
  }

  void _showMessage(String message) {
    AppDialogs.showSnackBar(
      message: message,
      backgroundColor: Colors.blue.shade800,
      duration: const Duration(seconds: 2),
    );
  }
}
