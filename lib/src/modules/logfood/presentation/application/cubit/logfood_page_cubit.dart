import 'package:caloriecounter/src/modules/logfood/domain/repository/food_repository.dart';
import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/modules/logfood/helper/log_food_helper.dart';
import 'package:caloriecounter/src/modules/logfood/presentation/application/cubit/logfood_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/models/food_model.dart';
import '../../../data/models/meal_summary_model.dart';
import '../../../data/models/recipe_model.dart';

part 'logfood_page_state.dart';
part 'logfood_page_cubit.freezed.dart';

@singleton
class LogFoodPageCubit extends Cubit<LogFoodPageState> {
  final FoodRepository _foodRepository;
  LogFoodPageLoaded? _previousLoadedState;
  int _foodSearchSeq = 0;

  FoodModel _mapMealSummaryToFoodModel(MealSummaryModel meal) {
    return FoodModel(
      id: meal.id,
      mealTemplateId: meal.id,
      name: meal.name,
      description: meal.directions,
      servingPerContainer: 1,
      units: const ['1 meal'],
      unitSizes: const [1],
      unitShowIndex: 0,
      quantity: 1,
      nutrients: {
        NutrientKeys.caloriesKcal: meal.calories,
        NutrientKeys.carbsTotalG: meal.carbs,
        NutrientKeys.fatTotalG: meal.fat,
        NutrientKeys.proteinG: meal.protein,
      },
      createdAt: meal.createdAt,
    );
  }

  LogFoodPageCubit({required FoodRepository foodRepository})
    : _foodRepository = foodRepository,
      super(const LogFoodPageState.initial());

  String _toCreateFoodErrorMessage(ApiError error) {
    if (error.statusCode == 400) {
      return error.message.isNotEmpty
          ? error.message
          : 'Invalid food data. Please check required fields.';
    }
    if (error.statusCode == 401) {
      return 'Your session has expired. Please sign in again.';
    }
    if (error.statusCode <= 0 || error.statusCode >= 500) {
      return 'Network error. Please try again.';
    }
    return error.message.isNotEmpty
        ? error.message
        : 'Failed to create food item. Please try again later.';
  }

  String _toUpdateFoodErrorMessage(ApiError error) {
    if (error.statusCode == 400) {
      return error.message.isNotEmpty
          ? error.message
          : 'Invalid food data. Please check required fields.';
    }
    if (error.statusCode == 401) {
      return 'Your session has expired. Please sign in again.';
    }
    if (error.statusCode == 404) {
      return 'This food can only be edited from My Foods.';
    }
    if (error.statusCode <= 0 || error.statusCode >= 500) {
      return 'Network error. Please try again.';
    }
    return error.message.isNotEmpty
        ? error.message
        : 'Failed to update food item. Please try again later.';
  }

  Future<void> loadInitialData({String? selectedTab}) async {
    LogFoodPageLoaded? previousState;
    if (state is LogFoodPageLoaded) {
      previousState = state as LogFoodPageLoaded;
      emit(previousState.copyWith(isLoading: true, errorMessage: null));
    } else {
      emit(const LogFoodPageState.loading());
    }

    try {
      // Collect all data first
      final allData = await _loadAllData(previousState);

      // Emit final loaded state with all collected data
      final preservedTab = selectedTab ?? previousState?.selectedTab ?? 'All';
      final preservedFromDate = previousState?.fromDate;
      final preservedToDate = previousState?.toDate;

      emit(
        LogFoodPageState.loaded(
          recentFoods: allData['recentFoods'] ?? [],
          suggestedFoods: allData['suggestedFoods'] ?? [],
          myMeals: allData['myMeals'] ?? [],
          myRecipes: allData['myRecipes'] ?? [],
          myFoods: allData['myFoods'] ?? [],
          selectedTab: preservedTab,
          fromDate: preservedFromDate,
          toDate: preservedToDate,
          isLoading: false,
          isLoadingAll: false,
          isLoadingMyMeals: false,
          isLoadingMyRecipes: false,
          isLoadingMyFoods: false,
          errorMessage: allData['errorMessage'],
        ),
      );
    } catch (e) {
      if (previousState != null) {
        emit(
          previousState.copyWith(
            errorMessage: 'Failed to load data: $e',
            isLoading: false,
          ),
        );
      } else {
        emit(LogFoodPageState.error('Failed to load data: $e'));
      }
    }
  }

  /// Load all data and return as map
  Future<Map<String, dynamic>> _loadAllData(
    LogFoodPageLoaded? previousState,
  ) async {
    final Map<String, dynamic> result = {
      'recentFoods': <FoodModel>[],
      'suggestedFoods': <FoodModel>[],
      'myMeals': <FoodModel>[],
      'myRecipes': <FoodModel>[],
      'myFoods': <FoodModel>[],
      'errorMessage': null,
    };

    try {
      // Load "All" tab data
      final suggestedFoods = await _foodRepository.getSuggestedFoods();
      result['suggestedFoods'] = suggestedFoods;

      DateTime? startDate;
      DateTime? endDate;
      if (previousState != null) {
        startDate = previousState.fromDate;
        endDate = previousState.toDate;
      }

      final recentFoodsResult = await _foodRepository.getRecentFoods(
        startDate: startDate,
        endDate: endDate,
      );

      recentFoodsResult.fold(
        (foods) {
          final sortedFoods = List<FoodModel>.from(foods);
          LogFoodHelper.sortByLoggedAtNewestFirst(sortedFoods);
          result['recentFoods'] = sortedFoods;
        },
        (error) {
          result['recentFoods'] = previousState?.recentFoods ?? <FoodModel>[];
          result['errorMessage'] = error.message;
        },
      );

      // Load "My Meals" tab data
      final myMealsResult = await _foodRepository.getMyMeals();
      myMealsResult.fold(
        (meals) {
          result['myMeals'] = meals.map(_mapMealSummaryToFoodModel).toList();
        },
        (error) {
          result['myMeals'] = previousState?.myMeals ?? <FoodModel>[];
          result['errorMessage'] ??= error.message;
        },
      );

      // Load "My Recipes" tab data
      final myRecipesResult = await _foodRepository.getMyRecipes();
      myRecipesResult.fold(
        (recipes) {
          result['myRecipes'] = recipes.map(_mapRecipeToFoodModel).toList();
        },
        (error) {
          result['myRecipes'] = previousState?.myRecipes ?? <FoodModel>[];
          result['errorMessage'] ??= error.message;
        },
      );

      // Load "My Foods" tab data
      final myFoodsResult = await _foodRepository.getMyFoods();
      myFoodsResult.fold(
        (foods) {
          // Sort by createdAt (most recent first)
          final sortedFoods = List<FoodModel>.from(foods);
          sortedFoods.sort((a, b) {
            final aTime = a.createdAt;
            final bTime = b.createdAt;
            if (aTime == null && bTime == null) return 0;
            if (aTime == null) return 1;
            if (bTime == null) return -1;
            return bTime.compareTo(aTime); // Descending (newest first)
          });
          result['myFoods'] = sortedFoods;
        },
        (error) {
          result['myFoods'] = previousState?.myFoods ?? <FoodModel>[];
          result['errorMessage'] ??= error.message;
        },
      );
    } catch (e) {
      result['errorMessage'] = 'Failed to load data: $e';
    }

    return result;
  }

  /// Load data for "All" tab
  Future<void> _loadAllTabData(LogFoodPageLoaded? previousState) async {
    if (state is LogFoodPageLoaded) {
      final currentState = state as LogFoodPageLoaded;
      emit(currentState.copyWith(isLoadingAll: true));
    }

    try {
      final suggestedFoods = await _foodRepository.getSuggestedFoods();

      DateTime? startDate;
      DateTime? endDate;
      if (previousState != null) {
        startDate = previousState.fromDate;
        endDate = previousState.toDate;
      }

      final recentFoodsResult = await _foodRepository.getRecentFoods(
        startDate: startDate,
        endDate: endDate,
      );

      List<FoodModel> recentFoods = [];
      String? errorMessage;

      recentFoodsResult.fold(
        (foods) {
          recentFoods = List<FoodModel>.from(foods);
          LogFoodHelper.sortByLoggedAtNewestFirst(recentFoods);
        },
        (error) {
          recentFoods = previousState?.recentFoods ?? const [];
          errorMessage = error.message;
        },
      );

      if (state is LogFoodPageLoaded) {
        final currentState = state as LogFoodPageLoaded;
        emit(
          currentState.copyWith(
            recentFoods: recentFoods,
            suggestedFoods: suggestedFoods,
            isLoadingAll: false,
            errorMessage: errorMessage,
          ),
        );
      }
    } catch (e) {
      if (state is LogFoodPageLoaded) {
        final currentState = state as LogFoodPageLoaded;
        emit(
          currentState.copyWith(
            isLoadingAll: false,
            errorMessage: 'Failed to load All tab data: $e',
          ),
        );
      }
    }
  }

  /// Load data for "My Meals" tab
  Future<void> _loadMyMealsTabData(LogFoodPageLoaded? previousState) async {
    await _loadMyMealsTabDataWithFilters(previousState);
  }

  Future<void> _loadMyMealsTabDataWithFilters(
    LogFoodPageLoaded? previousState, {
    String? search,
    bool includeCommunity = false,
  }) async {
    if (state is LogFoodPageLoaded) {
      final currentState = state as LogFoodPageLoaded;
      emit(currentState.copyWith(isLoadingMyMeals: true));
    }

    try {
      final myMealsResult = await _foodRepository.getMyMeals(
        search: search,
        includeCommunity: includeCommunity,
      );
      List<FoodModel> myMeals = [];
      String? errorMessage;
      myMealsResult.fold(
        (meals) => myMeals = meals.map(_mapMealSummaryToFoodModel).toList(),
        (error) {
          myMeals = previousState?.myMeals ?? [];
          errorMessage = error.message;
        },
      );

      if (state is LogFoodPageLoaded) {
        final currentState = state as LogFoodPageLoaded;
        emit(
          currentState.copyWith(
            myMeals: myMeals,
            isLoadingMyMeals: false,
            errorMessage: errorMessage,
          ),
        );
      }
    } catch (e) {
      if (state is LogFoodPageLoaded) {
        final currentState = state as LogFoodPageLoaded;
        emit(
          currentState.copyWith(
            isLoadingMyMeals: false,
            errorMessage: 'Failed to load My Meals tab data: $e',
          ),
        );
      }
    }
  }

  Future<void> searchMyMeals({
    required String query,
    required bool includeCommunity,
  }) async {
    if (state is! LogFoodPageLoaded) return;
    final currentState = state as LogFoodPageLoaded;
    await _loadMyMealsTabDataWithFilters(
      currentState,
      search: query.trim().isEmpty ? null : query.trim(),
      includeCommunity: includeCommunity,
    );
  }

  /// Load data for "My Recipes" tab
  Future<void> _loadMyRecipesTabData(
    LogFoodPageLoaded? previousState, {
    String? search,
    bool includeCommunity = false,
  }) async {
    if (state is LogFoodPageLoaded) {
      final currentState = state as LogFoodPageLoaded;
      emit(currentState.copyWith(isLoadingMyRecipes: true));
    }

    try {
      final myRecipesResult = await _foodRepository.getMyRecipes(
        search: search,
        includeCommunity: includeCommunity,
      );
      List<FoodModel> myRecipes = [];
      String? errorMessage;
      myRecipesResult.fold(
        (recipes) {
          myRecipes = recipes.map(_mapRecipeToFoodModel).toList();
        },
        (error) {
          myRecipes = previousState?.myRecipes ?? [];
          errorMessage = error.message;
        },
      );

      if (state is LogFoodPageLoaded) {
        final currentState = state as LogFoodPageLoaded;
        emit(
          currentState.copyWith(
            myRecipes: myRecipes,
            isLoadingMyRecipes: false,
            errorMessage: errorMessage,
          ),
        );
      }
    } catch (e) {
      if (state is LogFoodPageLoaded) {
        final currentState = state as LogFoodPageLoaded;
        emit(
          currentState.copyWith(
            isLoadingMyRecipes: false,
            errorMessage: 'Failed to load My Recipes tab data: $e',
          ),
        );
      }
    }
  }

  /// Load data for "My Foods" tab
  Future<void> _loadMyFoodsTabData(LogFoodPageLoaded? previousState) async {
    if (state is LogFoodPageLoaded) {
      final currentState = state as LogFoodPageLoaded;
      emit(currentState.copyWith(isLoadingMyFoods: true));
    }

    try {
      final myFoodsResult = await _foodRepository.getMyFoods();

      List<FoodModel> myFoods = [];
      String? errorMessage;

      myFoodsResult.fold(
        (foods) {
          // Sort by createdAt (most recent first)
          final sortedFoods = List<FoodModel>.from(foods);
          sortedFoods.sort((a, b) {
            final aTime = a.createdAt;
            final bTime = b.createdAt;
            if (aTime == null && bTime == null) return 0;
            if (aTime == null) return 1;
            if (bTime == null) return -1;
            return bTime.compareTo(aTime); // Descending (newest first)
          });
          myFoods = sortedFoods;
        },
        (error) {
          myFoods = previousState?.myFoods ?? const [];
          errorMessage = error.message;
        },
      );

      if (state is LogFoodPageLoaded) {
        final currentState = state as LogFoodPageLoaded;
        emit(
          currentState.copyWith(
            myFoods: myFoods,
            isLoadingMyFoods: false,
            errorMessage: errorMessage,
          ),
        );
      }
    } catch (e) {
      if (state is LogFoodPageLoaded) {
        final currentState = state as LogFoodPageLoaded;
        emit(
          currentState.copyWith(
            isLoadingMyFoods: false,
            errorMessage: 'Failed to load My Foods tab data: $e',
          ),
        );
      }
    }
  }

  /// Select a tab
  void selectTab(String tab) {
    if (state is! LogFoodPageLoaded) return;

    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(selectedTab: tab));
  }

  /// Search foods (for "All" tab)
  Future<void> searchFoods(
    String query, {
    bool includeAll = true,
    bool mineOnly = false,
  }) async {
    if (state is! LogFoodPageLoaded) return;

    final currentState = state as LogFoodPageLoaded;
    final trimmedQuery = query.trim();
    final seq = ++_foodSearchSeq;
    if (trimmedQuery.length < 2) {
      emit(currentState.copyWith(searchQuery: '', searchResults: []));
      return;
    }

    await _foodRepository
        .searchFoods(trimmedQuery, includeAll: includeAll, mineOnly: mineOnly)
        .fold(
          (foods) {
            if (seq != _foodSearchSeq || state is! LogFoodPageLoaded) return;
            final latestState = state as LogFoodPageLoaded;
            emit(
              latestState.copyWith(
                searchQuery: trimmedQuery,
                searchResults: foods,
              ),
            );
          },
          (error) {
            if (seq != _foodSearchSeq || state is! LogFoodPageLoaded) return;
            final latestState = state as LogFoodPageLoaded;
            emit(
              latestState.copyWith(
                searchQuery: trimmedQuery,
                searchResults: [],
              ),
            );
          },
        );
  }

  /// Set date range for "All" tab
  void setDateRange({DateTime? fromDate, DateTime? toDate}) {
    if (state is! LogFoodPageLoaded) return;

    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(fromDate: fromDate, toDate: toDate));

    // Reload "All" tab data with new date range
    _loadAllTabData(currentState);
  }

  Future<void> searchMyRecipes(
    String query, {
    bool includeCommunity = false,
  }) async {
    if (state is! LogFoodPageLoaded) return;
    final currentState = state as LogFoodPageLoaded;
    await _loadMyRecipesTabData(
      currentState,
      search: query.trim().isEmpty ? null : query.trim(),
      includeCommunity: includeCommunity,
    );
  }

  /// Reload specific tab data
  Future<void> reloadTab(
    String tab, {
    String? myRecipesSearch,
    bool includeCommunityRecipes = false,
  }) async {
    if (state is! LogFoodPageLoaded) return;

    final currentState = state as LogFoodPageLoaded;

    switch (tab) {
      case 'All':
        await _loadAllTabData(currentState);
        break;
      case 'My Meals':
        await _loadMyMealsTabData(currentState);
        break;
      case 'My Recipes':
        await _loadMyRecipesTabData(
          currentState,
          search: myRecipesSearch,
          includeCommunity: includeCommunityRecipes,
        );
        break;
      case 'My Foods':
        await _loadMyFoodsTabData(currentState);
        break;
    }
  }

  /// Reload only recent foods (for "All" tab)
  Future<void> reloadRecentFoods() async {
    LogFoodPageLoaded? currentState;

    if (state is LogFoodPageLoaded) {
      currentState = state as LogFoodPageLoaded;
    } else if (state is LogFoodLogDetailSuccess || state is LogFoodLogSuccess) {
      if (_previousLoadedState != null) {
        currentState = _previousLoadedState;
        emit(_previousLoadedState!);
      } else {
        await loadInitialData(selectedTab: 'All');
        return;
      }
    } else {
      return;
    }

    if (currentState == null) return;

    try {
      emit(currentState.copyWith(isLoadingAll: true));
      final startDate = currentState.fromDate;
      final endDate = currentState.toDate;

      final recentFoodsResult = await _foodRepository.getRecentFoods(
        startDate: startDate,
        endDate: endDate,
      );

      List<FoodModel> recentFoods = [];
      String? errorMessage;

      recentFoodsResult.fold(
        (foods) {
          recentFoods = List<FoodModel>.from(foods);
          LogFoodHelper.sortByLoggedAtNewestFirst(recentFoods);
        },
        (error) {
          recentFoods = currentState?.recentFoods ?? [];
          errorMessage = error.message;
        },
      );

      emit(
        currentState.copyWith(
          recentFoods: recentFoods,
          errorMessage: errorMessage,
          isLoadingAll: false,
        ),
      );
    } catch (e) {
      emit(
        currentState.copyWith(
          errorMessage: 'Failed to reload recent foods: $e',
          isLoadingAll: false,
        ),
      );
    }
  }

  Future<void> reloadMyFoods() async {
    LogFoodPageLoaded? currentState;

    if (state is LogFoodPageLoaded) {
      currentState = state as LogFoodPageLoaded;
    } else if (state is LogFoodPageCreateFoodSuccess) {
      if (_previousLoadedState != null) {
        currentState = _previousLoadedState;
        emit(_previousLoadedState!);
      } else {
        await loadInitialData(selectedTab: 'My Foods');
        return;
      }
    } else {
      return;
    }

    if (currentState == null) return;

    try {
      emit(currentState.copyWith(isLoadingMyFoods: true));
      final myFoodsResult = await _foodRepository.getMyFoods();
      List<FoodModel> myFoods = [];
      String? errorMessage;

      myFoodsResult.fold(
        (foods) {
          // Sort by createdAt (most recent first)
          final sortedFoods = List<FoodModel>.from(foods);
          sortedFoods.sort((a, b) {
            final aTime = a.createdAt;
            final bTime = b.createdAt;
            if (aTime == null && bTime == null) return 0;
            if (aTime == null) return 1;
            if (bTime == null) return -1;
            return bTime.compareTo(aTime); // Descending (newest first)
          });
          myFoods = sortedFoods;
        },
        (error) {
          myFoods = currentState!.myFoods;
          errorMessage = error.message;
        },
      );

      emit(
        currentState.copyWith(
          myFoods: myFoods,
          errorMessage: errorMessage,
          isLoadingMyFoods: false,
        ),
      );
    } catch (e) {
      emit(
        currentState.copyWith(
          errorMessage: 'Failed to reload my foods: $e',
          isLoadingMyFoods: false,
        ),
      );
    }
  }

  /// Get current tab data
  List<FoodModel> getCurrentTabData() {
    if (state is! LogFoodPageLoaded) return [];

    final currentState = state as LogFoodPageLoaded;

    if (currentState.searchQuery.isNotEmpty) {
      return currentState.searchResults;
    }

    switch (currentState.selectedTab) {
      case 'My Meals':
        return const [];
      case 'My Recipes':
        return const [];
      case 'My Foods':
        return currentState.myFoods;
      default:
        return [];
    }
  }

  /// Reload all data (API call)
  Future<void> reloadAllData() async {
    final previousState = state is LogFoodPageLoaded
        ? state as LogFoodPageLoaded
        : null;

    try {
      await loadInitialData(selectedTab: previousState?.selectedTab ?? 'All');
    } catch (e) {
      if (previousState != null) {
        emit(previousState.copyWith(errorMessage: 'Failed to reload data: $e'));
      }
    }
  }

  /// Create a new food item
  Future<void> createFood(FoodModel food) async {
    if (state is! LogFoodPageLoaded) return;

    _previousLoadedState = state as LogFoodPageLoaded;

    try {
      emit(const LogFoodPageState.createFoodLoading());
      final result = await _foodRepository.addFood(food);
      result.fold(
        (createdFood) {
          emit(
            const LogFoodPageState.createFoodSuccess(
              'Food item created successfully!',
            ),
          );
        },
        (error) {
          emit(
            LogFoodPageState.createFoodError(_toCreateFoodErrorMessage(error)),
          );
        },
      );
    } catch (e) {
      emit(LogFoodPageState.createFoodError('Failed to create food item: $e'));
    }
  }

  Future<void> updateFood(FoodModel food) async {
    if (state is! LogFoodPageLoaded || food.id == null) return;

    _previousLoadedState = state as LogFoodPageLoaded;

    try {
      emit(const LogFoodPageState.createFoodLoading());
      final result = await _foodRepository.updateFood(food.id.toString(), food);
      result.fold(
        (_) {
          emit(
            const LogFoodPageState.createFoodSuccess(
              'Food item updated successfully!',
            ),
          );
        },
        (error) {
          emit(
            LogFoodPageState.createFoodError(_toUpdateFoodErrorMessage(error)),
          );
        },
      );
    } catch (e) {
      emit(LogFoodPageState.createFoodError('Failed to update food item: $e'));
    }
  }

  Future<bool> deleteMyFood(FoodModel food) async {
    if (food.id == null || state is! LogFoodPageLoaded) {
      return false;
    }
    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(isLoadingMyFoods: true));

    final result = await _foodRepository.deleteFood(food.id.toString());
    return result.fold(
      (_) {
        final updatedMyFoods = currentState.myFoods
            .where((f) => f.id != food.id)
            .toList();
        final updatedSearchResults = currentState.searchResults
            .where((f) => f.id != food.id)
            .toList();
        emit(
          currentState.copyWith(
            myFoods: updatedMyFoods,
            searchResults: updatedSearchResults,
            isLoadingMyFoods: false,
            errorMessage: null,
          ),
        );
        return true;
      },
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMyFoods: false,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> createMeal(String name, {String? imageUrl}) async {
    if (state is! LogFoodPageLoaded) return false;
    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(isLoadingMyMeals: true));
    final result = await _foodRepository.createMeal(name, imageUrl: imageUrl);
    return result.fold(
      (meal) {
        final updated = [
          _mapMealSummaryToFoodModel(meal),
          ...currentState.myMeals,
        ];
        emit(currentState.copyWith(myMeals: updated, isLoadingMyMeals: false));
        return true;
      },
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMyMeals: false,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> copyPreviousMeal(String name) async {
    if (state is! LogFoodPageLoaded) return false;
    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(isLoadingMyMeals: true));
    final result = await _foodRepository.copyPreviousMeal(name);
    return result.fold(
      (meal) {
        final updated = [
          _mapMealSummaryToFoodModel(meal),
          ...currentState.myMeals,
        ];
        emit(currentState.copyWith(myMeals: updated, isLoadingMyMeals: false));
        return true;
      },
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMyMeals: false,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> deleteMyMeal(FoodModel meal) async {
    if (state is! LogFoodPageLoaded || meal.id == null) return false;
    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(isLoadingMyMeals: true));
    final result = await _foodRepository.deleteMeal(meal.id!);
    return result.fold(
      (_) {
        final updated = currentState.myMeals
            .where((m) => m.id != meal.id)
            .toList();
        emit(currentState.copyWith(myMeals: updated, isLoadingMyMeals: false));
        return true;
      },
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMyMeals: false,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> updateMeal(
    int mealId, {
    String? name,
    String? directions,
    int? shareWith,
    String? imageUrl,
  }) async {
    if (state is! LogFoodPageLoaded) return false;
    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(isLoadingMyMeals: true));
    final result = await _foodRepository.updateMeal(
      mealId,
      name: name,
      directions: directions,
      shareWith: shareWith,
      imageUrl: imageUrl,
    );
    return result.fold(
      (meal) {
        final mealModel = _mapMealSummaryToFoodModel(meal);
        final updated = currentState.myMeals
            .map((m) => m.id == mealId ? mealModel : m)
            .toList();
        emit(currentState.copyWith(myMeals: updated, isLoadingMyMeals: false));
        return true;
      },
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMyMeals: false,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> addFoodToMeal(int mealId, int foodId) async {
    if (state is! LogFoodPageLoaded) return false;
    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(isLoadingMyMeals: true));
    final result = await _foodRepository.addFoodToMeal(mealId, foodId: foodId);
    return result.fold(
      (meal) {
        final mealModel = _mapMealSummaryToFoodModel(meal);
        final updated = currentState.myMeals
            .map((m) => m.id == mealId ? mealModel : m)
            .toList();
        emit(currentState.copyWith(myMeals: updated, isLoadingMyMeals: false));
        return true;
      },
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMyMeals: false,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> deleteMyRecipe(FoodModel recipe) async {
    if (state is! LogFoodPageLoaded || recipe.id == null) return false;
    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(isLoadingMyRecipes: true));
    final result = await _foodRepository.deleteRecipe(recipe.id!);
    return result.fold(
      (_) {
        final updated = currentState.myRecipes
            .where((r) => r.id != recipe.id)
            .toList();
        emit(
          currentState.copyWith(myRecipes: updated, isLoadingMyRecipes: false),
        );
        return true;
      },
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMyRecipes: false,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> convertRecipeToMeal(int recipeId) async {
    if (state is! LogFoodPageLoaded) return false;
    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(isLoadingMyRecipes: true));
    final result = await _foodRepository.convertRecipeToMeal(recipeId);
    return result.fold(
      (meal) {
        final updatedMeals = [
          _mapMealSummaryToFoodModel(meal),
          ...currentState.myMeals,
        ];
        emit(
          currentState.copyWith(
            myMeals: updatedMeals,
            isLoadingMyRecipes: false,
          ),
        );
        return true;
      },
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMyRecipes: false,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> createRecipe(RecipeModel recipe) async {
    if (state is! LogFoodPageLoaded) return false;
    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(isLoadingMyRecipes: true));
    final result = await _foodRepository.createRecipe(recipe);
    return result.fold(
      (created) {
        final item = FoodModel(
          id: created.id,
          name: created.name,
          description: created.description,
          nutrients: const {},
          servingPerContainer: 1,
          units: const ['1 recipe'],
          unitSizes: const [1],
          unitShowIndex: 0,
          quantity: 1,
        );
        emit(
          currentState.copyWith(
            myRecipes: [item, ...currentState.myRecipes],
            isLoadingMyRecipes: false,
          ),
        );
        return true;
      },
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMyRecipes: false,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> updateRecipe(int recipeId, RecipeModel recipe) async {
    if (state is! LogFoodPageLoaded) return false;
    final currentState = state as LogFoodPageLoaded;
    emit(currentState.copyWith(isLoadingMyRecipes: true));
    final result = await _foodRepository.updateRecipe(recipeId, recipe);
    return result.fold(
      (updatedRecipe) {
        final updatedItem = _mapRecipeToFoodModel(updatedRecipe);
        final list = currentState.myRecipes
            .map((r) => r.id == recipeId ? updatedItem : r)
            .toList();
        emit(currentState.copyWith(myRecipes: list, isLoadingMyRecipes: false));
        return true;
      },
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMyRecipes: false,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  /// Load more suggestions (for infinite scroll)
  Future<void> loadMoreSuggestions() async {
    if (state is! LogFoodPageLoaded) return;

    final currentState = state as LogFoodPageLoaded;
    const pageSize = 10;

    // Don't load if already loading or no more items
    if (currentState.suggestedFoodsIsLoadingMore ||
        !currentState.suggestedFoodsHasMore) {
      return;
    }

    emit(currentState.copyWith(suggestedFoodsIsLoadingMore: true));

    try {
      final nextPage = currentState.suggestedFoodsPage + 1;
      final newSuggestions = await _foodRepository.getSuggestedFoods(
        page: nextPage,
        pageSize: pageSize,
      );

      final hasMore = newSuggestions.length == pageSize;

      if (newSuggestions.isEmpty) {
        emit(
          currentState.copyWith(
            suggestedFoodsIsLoadingMore: false,
            suggestedFoodsHasMore: false,
          ),
        );
      } else {
        emit(
          currentState.copyWith(
            suggestedFoods: [...currentState.suggestedFoods, ...newSuggestions],
            suggestedFoodsPage: nextPage,
            suggestedFoodsIsLoadingMore: false,
            suggestedFoodsHasMore: hasMore,
          ),
        );
      }
    } catch (e) {
      emit(
        currentState.copyWith(
          suggestedFoodsIsLoadingMore: false,
          errorMessage: 'Failed to load more suggestions: $e',
        ),
      );
    }
  }

  String _aiRecipeListDescription(String label, RecipeModel recipe) {
    return [
      '$label'
          '${recipe.mealSlot == null ? '' : ' - ${_formatMealSlot(recipe.mealSlot!)}'}'
          '${recipe.dateKey == null ? '' : ' - ${recipe.dateKey}'}'
          '${recipe.score == null ? '' : ' - Score ${(recipe.score! * 100).round()}%'}',
      if ((recipe.description ?? '').trim().isNotEmpty)
        recipe.description!.trim(),
      if (recipe.warnings.isNotEmpty)
        'Warnings: ${recipe.warnings.take(2).join('; ')}',
    ].join('\n');
  }

  FoodModel _mapRecipeToFoodModel(RecipeModel recipe) {
    final String? brand;
    final String? description;
    if (recipe.isFridgeAiPlan) {
      brand = 'AI Fridge Plan';
      description = _aiRecipeListDescription('AI Fridge Plan', recipe);
    } else if (recipe.isAiBuilderRecipe) {
      brand = 'AI Builder';
      description = _aiRecipeListDescription('AI Recipe Builder', recipe);
    } else if (recipe.shareWith == 2) {
      brand = 'Community';
      description = recipe.description;
    } else {
      brand = null;
      description = recipe.description;
    }
    return FoodModel(
      id: recipe.id,
      name: recipe.name,
      description: description,
      brand: brand,
      nutrients: const {},
      servingPerContainer: 1,
      units: const ['1 recipe'],
      unitSizes: const [1],
      unitShowIndex: 0,
      quantity: 1,
      isVerified: recipe.isVerified,
    );
  }

  String _formatMealSlot(String slot) {
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
}
