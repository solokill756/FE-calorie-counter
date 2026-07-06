part of 'logfood_page_cubit.dart';

@freezed
class LogFoodPageState with _$LogFoodPageState {
  const factory LogFoodPageState.initial() = LogFoodPageInitial;

  const factory LogFoodPageState.loading() = LogFoodPageLoading;

  const factory LogFoodPageState.loaded({
    // Tab "All" data
    @Default([]) List<FoodModel> recentFoods,
    @Default([]) List<FoodModel> suggestedFoods,
    @Default([]) List<FoodModel> searchResults,
    @Default('') String searchQuery,

    // Tab "My Meals" data
    @Default([]) List<FoodModel> myMeals,

    // Tab "My Recipes" data
    @Default([]) List<FoodModel> myRecipes,

    // Tab "My Foods" data
    @Default([]) List<FoodModel> myFoods,

    // Common state
    @Default('All') String selectedTab,
    DateTime? fromDate,
    DateTime? toDate,
    String? errorMessage,
    @Default(false) bool isLoading,

    // Tab-specific loading states
    @Default(false) bool isLoadingAll,
    @Default(false) bool isLoadingMyMeals,
    @Default(false) bool isLoadingMyRecipes,
    @Default(false) bool isLoadingMyFoods,

    // Suggestions pagination state
    @Default(1) int suggestedFoodsPage,
    @Default(true) bool suggestedFoodsHasMore,
    @Default(false) bool suggestedFoodsIsLoadingMore,
  }) = LogFoodPageLoaded;

  const factory LogFoodPageState.error(String message) = LogFoodPageError;

  // Create food states
  const factory LogFoodPageState.createFoodLoading() =
      LogFoodPageCreateFoodLoading;
  const factory LogFoodPageState.createFoodSuccess(String message) =
      LogFoodPageCreateFoodSuccess;
  const factory LogFoodPageState.createFoodError(String message) =
      LogFoodPageCreateFoodError;
}
