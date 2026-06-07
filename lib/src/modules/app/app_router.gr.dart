// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CreateFoodNutritionRoute.name: (routeData) {
      final args = routeData.argsAs<CreateFoodNutritionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateFoodNutritionPage(
          key: args.key,
          food: args.food,
          isEditing: args.isEditing,
        ),
      );
    },
    CreateFoodRoute.name: (routeData) {
      final args = routeData.argsAs<CreateFoodRouteArgs>(
          orElse: () => const CreateFoodRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateFoodPage(
          key: args.key,
          initialFood: args.initialFood,
          isEditing: args.isEditing,
        ),
      );
    },
    DashboardRoute.name: (routeData) {
      final args = routeData.argsAs<DashboardRouteArgs>(
          orElse: () => const DashboardRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DashboardPage(
          key: args.key,
          onNavigateToDiary: args.onNavigateToDiary,
          onNavigateToProgress: args.onNavigateToProgress,
        ),
      );
    },
    EditGoalRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditGoalPage(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditProfilePage(),
      );
    },
    ExerciseAddLogRoute.name: (routeData) {
      final args = routeData.argsAs<ExerciseAddLogRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExerciseAddLogPage(
          key: args.key,
          exerciseId: args.exerciseId,
        ),
      );
    },
    ExerciseCatalogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExerciseCatalogPage(),
      );
    },
    ExerciseFormRoute.name: (routeData) {
      final args = routeData.argsAs<ExerciseFormRouteArgs>(
          orElse: () => const ExerciseFormRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExerciseFormPage(
          key: args.key,
          exerciseId: args.exerciseId,
        ),
      );
    },
    ExerciseHistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExerciseHistoryPage(),
      );
    },
    ExerciseHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExerciseHomePage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    LogFoodDetailRoute.name: (routeData) {
      final args = routeData.argsAs<LogFoodDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LogFoodDetailPage(
          key: args.key,
          foodId: args.foodId,
          food: args.food,
          historyFoods: args.historyFoods,
          forLogDate: args.forLogDate,
        ),
      );
    },
    LogFoodRoute.name: (routeData) {
      final args = routeData.argsAs<LogFoodRouteArgs>(
          orElse: () => const LogFoodRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LogFoodPage(
          key: args.key,
          forDate: args.forDate,
          initialMeal: args.initialMeal,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    MainNavigationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainNavigationPage(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    MealDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MealDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MealDetailPage(
          key: args.key,
          mealId: args.mealId,
        ),
      );
    },
    MoreRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MorePage(),
      );
    },
    NotificationSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotificationSettingsPage(),
      );
    },
    NutritionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NutritionPage(),
      );
    },
    ProgressRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProgressPage(),
      );
    },
    QuickAddRoute.name: (routeData) {
      final args = routeData.argsAs<QuickAddRouteArgs>(
          orElse: () => const QuickAddRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QuickAddPage(
          key: args.key,
          diaryDay: args.diaryDay,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
    SignUpFlowRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpFlowPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    StapleFoodsRoute.name: (routeData) {
      final args = routeData.argsAs<StapleFoodsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StapleFoodsPage(
          key: args.key,
          availableFoods: args.availableFoods,
          pantryOnly: args.pantryOnly,
        ),
      );
    },
    UserProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserProfilePage(),
      );
    },
    WaterLogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WaterLogPage(),
      );
    },
    WeightFormRoute.name: (routeData) {
      final args = routeData.argsAs<WeightFormRouteArgs>(
          orElse: () => const WeightFormRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WeightFormPage(
          key: args.key,
          entryId: args.entryId,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [CreateFoodNutritionPage]
class CreateFoodNutritionRoute
    extends PageRouteInfo<CreateFoodNutritionRouteArgs> {
  CreateFoodNutritionRoute({
    Key? key,
    required FoodModel food,
    bool isEditing = false,
    List<PageRouteInfo>? children,
  }) : super(
          CreateFoodNutritionRoute.name,
          args: CreateFoodNutritionRouteArgs(
            key: key,
            food: food,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateFoodNutritionRoute';

  static const PageInfo<CreateFoodNutritionRouteArgs> page =
      PageInfo<CreateFoodNutritionRouteArgs>(name);
}

class CreateFoodNutritionRouteArgs {
  const CreateFoodNutritionRouteArgs({
    this.key,
    required this.food,
    this.isEditing = false,
  });

  final Key? key;

  final FoodModel food;

  final bool isEditing;

  @override
  String toString() {
    return 'CreateFoodNutritionRouteArgs{key: $key, food: $food, isEditing: $isEditing}';
  }
}

/// generated route for
/// [CreateFoodPage]
class CreateFoodRoute extends PageRouteInfo<CreateFoodRouteArgs> {
  CreateFoodRoute({
    Key? key,
    FoodModel? initialFood,
    bool isEditing = false,
    List<PageRouteInfo>? children,
  }) : super(
          CreateFoodRoute.name,
          args: CreateFoodRouteArgs(
            key: key,
            initialFood: initialFood,
            isEditing: isEditing,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateFoodRoute';

  static const PageInfo<CreateFoodRouteArgs> page =
      PageInfo<CreateFoodRouteArgs>(name);
}

class CreateFoodRouteArgs {
  const CreateFoodRouteArgs({
    this.key,
    this.initialFood,
    this.isEditing = false,
  });

  final Key? key;

  final FoodModel? initialFood;

  final bool isEditing;

  @override
  String toString() {
    return 'CreateFoodRouteArgs{key: $key, initialFood: $initialFood, isEditing: $isEditing}';
  }
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    Key? key,
    void Function()? onNavigateToDiary,
    void Function()? onNavigateToProgress,
    List<PageRouteInfo>? children,
  }) : super(
          DashboardRoute.name,
          args: DashboardRouteArgs(
            key: key,
            onNavigateToDiary: onNavigateToDiary,
            onNavigateToProgress: onNavigateToProgress,
          ),
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<DashboardRouteArgs> page =
      PageInfo<DashboardRouteArgs>(name);
}

class DashboardRouteArgs {
  const DashboardRouteArgs({
    this.key,
    this.onNavigateToDiary,
    this.onNavigateToProgress,
  });

  final Key? key;

  final void Function()? onNavigateToDiary;

  final void Function()? onNavigateToProgress;

  @override
  String toString() {
    return 'DashboardRouteArgs{key: $key, onNavigateToDiary: $onNavigateToDiary, onNavigateToProgress: $onNavigateToProgress}';
  }
}

/// generated route for
/// [EditGoalPage]
class EditGoalRoute extends PageRouteInfo<void> {
  const EditGoalRoute({List<PageRouteInfo>? children})
      : super(
          EditGoalRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditGoalRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExerciseAddLogPage]
class ExerciseAddLogRoute extends PageRouteInfo<ExerciseAddLogRouteArgs> {
  ExerciseAddLogRoute({
    Key? key,
    required int exerciseId,
    List<PageRouteInfo>? children,
  }) : super(
          ExerciseAddLogRoute.name,
          args: ExerciseAddLogRouteArgs(
            key: key,
            exerciseId: exerciseId,
          ),
          initialChildren: children,
        );

  static const String name = 'ExerciseAddLogRoute';

  static const PageInfo<ExerciseAddLogRouteArgs> page =
      PageInfo<ExerciseAddLogRouteArgs>(name);
}

class ExerciseAddLogRouteArgs {
  const ExerciseAddLogRouteArgs({
    this.key,
    required this.exerciseId,
  });

  final Key? key;

  final int exerciseId;

  @override
  String toString() {
    return 'ExerciseAddLogRouteArgs{key: $key, exerciseId: $exerciseId}';
  }
}

/// generated route for
/// [ExerciseCatalogPage]
class ExerciseCatalogRoute extends PageRouteInfo<void> {
  const ExerciseCatalogRoute({List<PageRouteInfo>? children})
      : super(
          ExerciseCatalogRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExerciseCatalogRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExerciseFormPage]
class ExerciseFormRoute extends PageRouteInfo<ExerciseFormRouteArgs> {
  ExerciseFormRoute({
    Key? key,
    int? exerciseId,
    List<PageRouteInfo>? children,
  }) : super(
          ExerciseFormRoute.name,
          args: ExerciseFormRouteArgs(
            key: key,
            exerciseId: exerciseId,
          ),
          initialChildren: children,
        );

  static const String name = 'ExerciseFormRoute';

  static const PageInfo<ExerciseFormRouteArgs> page =
      PageInfo<ExerciseFormRouteArgs>(name);
}

class ExerciseFormRouteArgs {
  const ExerciseFormRouteArgs({
    this.key,
    this.exerciseId,
  });

  final Key? key;

  final int? exerciseId;

  @override
  String toString() {
    return 'ExerciseFormRouteArgs{key: $key, exerciseId: $exerciseId}';
  }
}

/// generated route for
/// [ExerciseHistoryPage]
class ExerciseHistoryRoute extends PageRouteInfo<void> {
  const ExerciseHistoryRoute({List<PageRouteInfo>? children})
      : super(
          ExerciseHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExerciseHistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExerciseHomePage]
class ExerciseHomeRoute extends PageRouteInfo<void> {
  const ExerciseHomeRoute({List<PageRouteInfo>? children})
      : super(
          ExerciseHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExerciseHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LogFoodDetailPage]
class LogFoodDetailRoute extends PageRouteInfo<LogFoodDetailRouteArgs> {
  LogFoodDetailRoute({
    Key? key,
    required int foodId,
    required FoodModel food,
    required List<FoodModel> historyFoods,
    DateTime? forLogDate,
    List<PageRouteInfo>? children,
  }) : super(
          LogFoodDetailRoute.name,
          args: LogFoodDetailRouteArgs(
            key: key,
            foodId: foodId,
            food: food,
            historyFoods: historyFoods,
            forLogDate: forLogDate,
          ),
          initialChildren: children,
        );

  static const String name = 'LogFoodDetailRoute';

  static const PageInfo<LogFoodDetailRouteArgs> page =
      PageInfo<LogFoodDetailRouteArgs>(name);
}

class LogFoodDetailRouteArgs {
  const LogFoodDetailRouteArgs({
    this.key,
    required this.foodId,
    required this.food,
    required this.historyFoods,
    this.forLogDate,
  });

  final Key? key;

  final int foodId;

  final FoodModel food;

  final List<FoodModel> historyFoods;

  final DateTime? forLogDate;

  @override
  String toString() {
    return 'LogFoodDetailRouteArgs{key: $key, foodId: $foodId, food: $food, historyFoods: $historyFoods, forLogDate: $forLogDate}';
  }
}

/// generated route for
/// [LogFoodPage]
class LogFoodRoute extends PageRouteInfo<LogFoodRouteArgs> {
  LogFoodRoute({
    Key? key,
    DateTime? forDate,
    String? initialMeal,
    List<PageRouteInfo>? children,
  }) : super(
          LogFoodRoute.name,
          args: LogFoodRouteArgs(
            key: key,
            forDate: forDate,
            initialMeal: initialMeal,
          ),
          initialChildren: children,
        );

  static const String name = 'LogFoodRoute';

  static const PageInfo<LogFoodRouteArgs> page =
      PageInfo<LogFoodRouteArgs>(name);
}

class LogFoodRouteArgs {
  const LogFoodRouteArgs({
    this.key,
    this.forDate,
    this.initialMeal,
  });

  final Key? key;

  final DateTime? forDate;

  final String? initialMeal;

  @override
  String toString() {
    return 'LogFoodRouteArgs{key: $key, forDate: $forDate, initialMeal: $initialMeal}';
  }
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainNavigationPage]
class MainNavigationRoute extends PageRouteInfo<void> {
  const MainNavigationRoute({List<PageRouteInfo>? children})
      : super(
          MainNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainNavigationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MealDetailPage]
class MealDetailRoute extends PageRouteInfo<MealDetailRouteArgs> {
  MealDetailRoute({
    Key? key,
    required int mealId,
    List<PageRouteInfo>? children,
  }) : super(
          MealDetailRoute.name,
          args: MealDetailRouteArgs(
            key: key,
            mealId: mealId,
          ),
          initialChildren: children,
        );

  static const String name = 'MealDetailRoute';

  static const PageInfo<MealDetailRouteArgs> page =
      PageInfo<MealDetailRouteArgs>(name);
}

class MealDetailRouteArgs {
  const MealDetailRouteArgs({
    this.key,
    required this.mealId,
  });

  final Key? key;

  final int mealId;

  @override
  String toString() {
    return 'MealDetailRouteArgs{key: $key, mealId: $mealId}';
  }
}

/// generated route for
/// [MorePage]
class MoreRoute extends PageRouteInfo<void> {
  const MoreRoute({List<PageRouteInfo>? children})
      : super(
          MoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoreRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotificationSettingsPage]
class NotificationSettingsRoute extends PageRouteInfo<void> {
  const NotificationSettingsRoute({List<PageRouteInfo>? children})
      : super(
          NotificationSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NutritionPage]
class NutritionRoute extends PageRouteInfo<void> {
  const NutritionRoute({List<PageRouteInfo>? children})
      : super(
          NutritionRoute.name,
          initialChildren: children,
        );

  static const String name = 'NutritionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProgressPage]
class ProgressRoute extends PageRouteInfo<void> {
  const ProgressRoute({List<PageRouteInfo>? children})
      : super(
          ProgressRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProgressRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QuickAddPage]
class QuickAddRoute extends PageRouteInfo<QuickAddRouteArgs> {
  QuickAddRoute({
    Key? key,
    DateTime? diaryDay,
    List<PageRouteInfo>? children,
  }) : super(
          QuickAddRoute.name,
          args: QuickAddRouteArgs(
            key: key,
            diaryDay: diaryDay,
          ),
          initialChildren: children,
        );

  static const String name = 'QuickAddRoute';

  static const PageInfo<QuickAddRouteArgs> page =
      PageInfo<QuickAddRouteArgs>(name);
}

class QuickAddRouteArgs {
  const QuickAddRouteArgs({
    this.key,
    this.diaryDay,
  });

  final Key? key;

  final DateTime? diaryDay;

  @override
  String toString() {
    return 'QuickAddRouteArgs{key: $key, diaryDay: $diaryDay}';
  }
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpFlowPage]
class SignUpFlowRoute extends PageRouteInfo<void> {
  const SignUpFlowRoute({List<PageRouteInfo>? children})
      : super(
          SignUpFlowRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpFlowRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StapleFoodsPage]
class StapleFoodsRoute extends PageRouteInfo<StapleFoodsRouteArgs> {
  StapleFoodsRoute({
    Key? key,
    required List<FoodModel> availableFoods,
    bool pantryOnly = false,
    List<PageRouteInfo>? children,
  }) : super(
          StapleFoodsRoute.name,
          args: StapleFoodsRouteArgs(
            key: key,
            availableFoods: availableFoods,
            pantryOnly: pantryOnly,
          ),
          initialChildren: children,
        );

  static const String name = 'StapleFoodsRoute';

  static const PageInfo<StapleFoodsRouteArgs> page =
      PageInfo<StapleFoodsRouteArgs>(name);
}

class StapleFoodsRouteArgs {
  const StapleFoodsRouteArgs({
    this.key,
    required this.availableFoods,
    this.pantryOnly = false,
  });

  final Key? key;

  final List<FoodModel> availableFoods;

  final bool pantryOnly;

  @override
  String toString() {
    return 'StapleFoodsRouteArgs{key: $key, availableFoods: $availableFoods, pantryOnly: $pantryOnly}';
  }
}

/// generated route for
/// [UserProfilePage]
class UserProfileRoute extends PageRouteInfo<void> {
  const UserProfileRoute({List<PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WaterLogPage]
class WaterLogRoute extends PageRouteInfo<void> {
  const WaterLogRoute({List<PageRouteInfo>? children})
      : super(
          WaterLogRoute.name,
          initialChildren: children,
        );

  static const String name = 'WaterLogRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WeightFormPage]
class WeightFormRoute extends PageRouteInfo<WeightFormRouteArgs> {
  WeightFormRoute({
    Key? key,
    String? entryId,
    List<PageRouteInfo>? children,
  }) : super(
          WeightFormRoute.name,
          args: WeightFormRouteArgs(
            key: key,
            entryId: entryId,
          ),
          initialChildren: children,
        );

  static const String name = 'WeightFormRoute';

  static const PageInfo<WeightFormRouteArgs> page =
      PageInfo<WeightFormRouteArgs>(name);
}

class WeightFormRouteArgs {
  const WeightFormRouteArgs({
    this.key,
    this.entryId,
  });

  final Key? key;

  final String? entryId;

  @override
  String toString() {
    return 'WeightFormRouteArgs{key: $key, entryId: $entryId}';
  }
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
