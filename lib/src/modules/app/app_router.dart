import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/modules/app/presentation/pages/main_navigation_page.dart';
import 'package:caloriecounter/src/modules/auth/presentation/pages/register_page.dart';
import 'package:caloriecounter/src/modules/logfood/data/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../core/guards/auth_guard.dart';
import '../auth/presentation/pages/signup_flow_page.dart';
import '../auth/presentation/pages/login_page.dart';
import '../calorie_counter/presentation/pages/dashboard_page.dart';
import '../home/presentation/home_page.dart';
import '../logfood/presentation/pages/logfood_detail_page.dart';
import '../logfood/presentation/pages/logfood_page.dart';
import '../logfood/presentation/pages/create_food_page.dart';
import '../logfood/presentation/pages/quick_add_page.dart';
import '../logfood/presentation/pages/create_food_nutrition_page.dart';
import '../logfood/presentation/pages/meal_detail_page.dart';
import '../logfood/presentation/pages/staple_foods_page.dart';

import '../more/presentation/pages/more_page.dart';
import '../more/presentation/pages/edit_profile_page.dart';
import '../more/presentation/pages/edit_goal_page.dart';
import '../more/presentation/pages/user_profile_page.dart';

import '../nutrition/presentation/pages/nutrition_page.dart';
import '../progress/presentation/pages/progress_page.dart';
import '../weight_form/presentation/pages/weight_form_page.dart';
import '../welcome/presentation/pages/welcome_page.dart';
import '../exercise/presentation/pages/exercise_home_page.dart';
import '../exercise/presentation/pages/exercise_catalog_page.dart';
import '../exercise/presentation/pages/exercise_add_log_page.dart';
import '../exercise/presentation/pages/exercise_history_page.dart';
import '../exercise/presentation/pages/exercise_form_page.dart';
import '../water_log/presentation/pages/water_log_page.dart';
import '../notifications/presentation/pages/notifications_page.dart';
import 'main_page.dart';
import 'splash_page.dart';

part 'app_router.gr.dart';

/// Root navigator for global navigation.
final GlobalKey<NavigatorState> appRootNavigatorKey = GlobalKey<NavigatorState>();

@singleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  AppRouter() : super(navigatorKey: appRootNavigatorKey);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainNavigationRoute.page, path: '/', guards: [AuthGuard()]),
    AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
    AutoRoute(page: LogFoodRoute.page, path: '/logfood', guards: [AuthGuard()]),
    AutoRoute(page: SplashRoute.page, path: '/splash'),
    AutoRoute(page: MainRoute.page, path: '/main', guards: [AuthGuard()]),
    AutoRoute(page: MoreRoute.page, guards: [AuthGuard()]),
    AutoRoute(
      page: UserProfileRoute.page,
      path: '/profile',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: EditProfileRoute.page,
      path: '/edit-profile',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: EditGoalRoute.page,
      path: '/edit-goal',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: StapleFoodsRoute.page,
      path: '/more/pantry',
      guards: [AuthGuard()],
    ),
    AutoRoute(page: ProgressRoute.page, guards: [AuthGuard()]),
    AutoRoute(
      page: LogFoodDetailRoute.page,
      path: '/logfood/detail',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: MealDetailRoute.page,
      path: '/logfood/meal-detail',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: QuickAddRoute.page,
      path: '/logfood/quick-add',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: CreateFoodRoute.page,
      path: '/logfood/create',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: CreateFoodNutritionRoute.page,
      path: '/logfood/create/nutrition',
      guards: [AuthGuard()],
    ),
    AutoRoute(page: SignUpFlowRoute.page, path: '/signup-flow'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(
      page: DashboardRoute.page,
      path: '/dashboard',
      guards: [AuthGuard()],
    ),
    AutoRoute(page: RegisterRoute.page, path: '/register'),
    AutoRoute(
      page: WeightFormRoute.page,
      path: '/weight-form',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: NutritionRoute.page,
      path: '/nutrition',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: ExerciseFormRoute.page,
      path: '/exercise/form',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: ExerciseHomeRoute.page,
      path: '/exercise',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: ExerciseCatalogRoute.page,
      path: '/exercise/catalog',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: ExerciseAddLogRoute.page,
      path: '/exercise/add',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: ExerciseHistoryRoute.page,
      path: '/exercise/history',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: WaterLogRoute.page,
      path: '/water-log',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: NotificationsRoute.page,
      path: '/notifications',
      guards: [AuthGuard()],
    ),
  ];
  @override
  RouteType get defaultRouteType => RouteType.custom(
    durationInMilliseconds: 300,
    reverseDurationInMilliseconds: 300,
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  );
}
