import 'dart:async';

import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/common/utils/rating_service.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:caloriecounter/src/modules/logfood/data/models/food_model.dart';
import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/core/recipe/fridge_plan_quota_notifier.dart';
import 'package:caloriecounter/src/modules/logfood/data/models/fridge_meal_plan_result_model.dart';
import 'package:caloriecounter/src/modules/logfood/data/models/recipe_builder_generate_model.dart';
import 'package:caloriecounter/src/modules/logfood/data/models/recipe_model.dart';
import 'package:caloriecounter/src/modules/logfood/domain/repository/food_repository.dart';
import 'package:caloriecounter/src/modules/logfood/presentation/application/cubit/logfood_page_cubit.dart';
import 'package:caloriecounter/src/modules/logfood/presentation/pages/recipe_editor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Fire-and-forget recipe generation: in-app snackbar when foreground, OS
/// notification when not. Tap notification opens [RecipeEditorPage] via [appRootNavigatorKey].
class RecipeGenerationCoordinator {
  RecipeGenerationCoordinator._();

  static final RecipeGenerationCoordinator instance =
      RecipeGenerationCoordinator._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  AppLifecycleState _lifecycle = AppLifecycleState.resumed;

  static const _channelId = 'recipe_generation';
  static const _channelName = 'Recipe generation';
  static const _channelDescription = 'Notifies when an AI recipe is ready';

  final Map<String, _PendingRecipe> _pending = {};

  bool _fridgePlanInFlight = false;
  bool _recipeInFlight = false;

  bool get isFridgePlanInFlight => _fridgePlanInFlight;
  bool get isRecipeInFlight => _recipeInFlight;

  bool _initialized = false;

  void updateLifecycle(AppLifecycleState state) {
    _lifecycle = state;
  }

  bool get _isForeground => _lifecycle == AppLifecycleState.resumed;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );

    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidImpl?.requestNotificationsPermission();
  }

  void _onNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;
    final pending = _pending.remove(payload);
    if (pending == null) return;
    _openRecipeEditor(pending);
  }

  void _openRecipeEditor(_PendingRecipe pending) {
    final nav = appRootNavigatorKey.currentState;
    if (nav == null) return;
    final savedId = pending.savedRecipeId;
    if (savedId != null) {
      unawaited(
        nav.push<void>(
          MaterialPageRoute<void>(
            builder: (_) => RecipeEditorPage(
              recipeId: savedId,
              availableFoods: pending.availableFoods,
              readOnly: true,
            ),
          ),
        ),
      );
      return;
    }
    final draft = pending.draft;
    if (draft != null) {
      unawaited(
        nav.push<void>(
          MaterialPageRoute<void>(
            builder: (_) => RecipeEditorPage(
              initialDraft: draft,
              availableFoods: pending.availableFoods,
              readOnly: true,
            ),
          ),
        ),
      );
    }
  }

  /// Starts generation without blocking the UI. Shows a short snackbar immediately.
  void startGenerate({
    required List<int> foodIds,
    required String mealSlot,
    String? date,
    Map<String, dynamic>? constraints,
    required List<FoodModel> availableFoods,
  }) {
    if (_recipeInFlight) {
      AppDialogs.showSnackBar(
        message: 'A recipe is already generating…',
        backgroundColor: Colors.orange.shade800,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    _recipeInFlight = true;
    final jobId = '${DateTime.now().microsecondsSinceEpoch}';
    AppDialogs.showSnackBar(
      message: 'Generating recipe in the background…',
      backgroundColor: Colors.blue.shade800,
      duration: const Duration(seconds: 3),
    );

    unawaited(
      _runJob(
        jobId: jobId,
        foodIds: foodIds,
        mealSlot: mealSlot,
        date: date,
        constraints: constraints,
        availableFoods: availableFoods,
      ),
    );
  }

  /// Starts full-day fridge plan generation without blocking the UI.
  void startFridgeMealPlan({String? date, bool replace = false}) {
    if (_fridgePlanInFlight) {
      AppDialogs.showSnackBar(
        message: 'A fridge plan is already generating…',
        backgroundColor: Colors.orange.shade800,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    _fridgePlanInFlight = true;
    FridgePlanGenerationNotifier.instance.setInProgress(true);
    AppDialogs.showSnackBar(
      message: 'Generating fridge plan in the background…',
      backgroundColor: Colors.blue.shade800,
      duration: const Duration(seconds: 3),
    );

    unawaited(_runFridgePlanJob(date: date, replace: replace));
  }

  Future<void> _runFridgePlanJob({String? date, bool replace = false}) async {
    try {
      final res = await getIt<FoodRepository>().generateFridgeMealPlan(
        date: date,
        replace: replace,
      );

      res.fold(
        (FridgeMealPlanResult data) async {
          FridgePlanGenerationNotifier.instance.setInProgress(false);
          final context = appRootNavigatorKey.currentState?.context;
          if (context != null) {
            unawaited(getIt<RatingService>().maybeRateAppAfterAiUsage(context));
          }
          await getIt<LogFoodPageCubit>().reloadTab('My Recipes');
          _notifyFridgePlanSuccess(data);
        },
        (ApiError err) => _notifyFridgePlanFailure(err),
      );
    } finally {
      _fridgePlanInFlight = false;
      FridgePlanGenerationNotifier.instance.setInProgress(false);
    }
  }

  void _notifyFridgePlanSuccess(FridgeMealPlanResult data) {
    final message = data.summaryMessage;
    if (_isForeground) {
      AppDialogs.showSnackBar(
        message: message,
        duration: const Duration(seconds: 8),
      );
      return;
    }

    unawaited(
      _plugin.show(
        DateTime.now().microsecondsSinceEpoch % 0x7fffffff,
        'Fridge plan ready',
        message,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      ),
    );
  }

  void _notifyFridgePlanFailure(ApiError err) {
    final message = err.message.isNotEmpty
        ? err.message
        : 'Fridge plan generation failed.';
    final backgroundColor =
        err.statusCode == 409 ? Colors.orange.shade800 : Colors.red;
    if (_isForeground) {
      AppDialogs.showSnackBar(
        message: message,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    unawaited(
      _plugin.show(
        DateTime.now().microsecondsSinceEpoch % 0x7fffffff,
        'Fridge plan failed',
        message,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      ),
    );
  }

  Future<void> _runJob({
    required String jobId,
    required List<int> foodIds,
    required String mealSlot,
    String? date,
    Map<String, dynamic>? constraints,
    required List<FoodModel> availableFoods,
  }) async {
    try {
      final res = await getIt<FoodRepository>().generateRecipeFromStaples(
      mealSlot: mealSlot,
      date: date,
      foodIds: foodIds,
      constraints: constraints,
    );

    res.fold(
      (RecipeBuilderGenerateResult data) {
        unawaited(
          _persistGeneratedRecipe(
            jobId: jobId,
            data: data,
            availableFoods: availableFoods,
            mealSlot: mealSlot,
            date: date,
          ),
        );
      },
      (ApiError err) {
        if (_isForeground) {
          AppDialogs.showSnackBar(
            message: err.message.isNotEmpty
                ? err.message
                : 'Recipe generation failed.',
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          );
        } else {
          unawaited(
            _plugin.show(
              jobId.hashCode.abs() % 0x7fffffff,
              'Recipe generation failed',
              err.message.isNotEmpty ? err.message : 'Please try again.',
              NotificationDetails(
                android: AndroidNotificationDetails(
                  _channelId,
                  _channelName,
                  channelDescription: _channelDescription,
                  importance: Importance.high,
                  priority: Priority.high,
                  icon: '@mipmap/ic_launcher',
                ),
                iOS: const DarwinNotificationDetails(
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                ),
              ),
            ),
          );
        }
      },
    );
    } finally {
      _recipeInFlight = false;
    }
  }

  /// Saves generated draft to the server so it appears under My Recipes, then notifies.
  Future<void> _persistGeneratedRecipe({
    required String jobId,
    required RecipeBuilderGenerateResult data,
    required List<FoodModel> availableFoods,
    required String mealSlot,
    String? date,
  }) async {
    final context = appRootNavigatorKey.currentState?.context;
    if (context != null) {
      unawaited(getIt<RatingService>().maybeRateAppAfterAiUsage(context));
    }

    final saveRes = await getIt<FoodRepository>().createRecipe(
      data.recipeDraft.withSourceMetadata(
        sourceType: RecipeModel.sourceAiRecipeBuilder,
        mealSlot: mealSlot,
        dateKey: date,
      ),
    );
    final saved = saveRes.getOrNull();

    if (saved != null) {
      await getIt<LogFoodPageCubit>().reloadTab('My Recipes');
      _pending[jobId] = _PendingRecipe(
        draft: null,
        savedRecipeId: saved.id,
        availableFoods: availableFoods,
      );

      if (_isForeground) {
        AppDialogs.showSnackBar(
          message: 'Recipe saved to My Recipes.',
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Edit',
            textColor: Colors.white,
            onPressed: () {
              final pending = _pending.remove(jobId);
              if (pending == null) return;
              _openRecipeEditor(pending);
            },
          ),
        );
      } else {
        unawaited(
          _plugin.show(
            jobId.hashCode.abs() % 0x7fffffff,
            'Recipe saved',
            'Tap to open and edit your recipe.',
            NotificationDetails(
              android: AndroidNotificationDetails(
                _channelId,
                _channelName,
                channelDescription: _channelDescription,
                importance: Importance.high,
                priority: Priority.high,
                icon: '@mipmap/ic_launcher',
              ),
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ),
            payload: jobId,
          ),
        );
      }
      return;
    }

    final err = saveRes.exceptionOrNull();
    final msg = err is ApiError && err.message.isNotEmpty
        ? err.message
        : 'Could not save automatically.';

    _pending[jobId] = _PendingRecipe(
      draft: data.recipeDraft,
      savedRecipeId: null,
      availableFoods: availableFoods,
    );

    if (_isForeground) {
      AppDialogs.showSnackBar(
        message:
            'Recipe is ready but was not saved ($msg). Tap Open to review and save.',
        duration: const Duration(seconds: 10),
        backgroundColor: Colors.deepOrange.shade700,
        action: SnackBarAction(
          label: 'Open',
          textColor: Colors.white,
          onPressed: () {
            final pending = _pending.remove(jobId);
            if (pending == null) return;
            _openRecipeEditor(pending);
          },
        ),
      );
    } else {
      unawaited(
        _plugin.show(
          jobId.hashCode.abs() % 0x7fffffff,
          'Recipe ready',
          'Not saved yet — tap to review and save. $msg',
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channelId,
              _channelName,
              channelDescription: _channelDescription,
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: jobId,
        ),
      );
    }
  }
}

class _PendingRecipe {
  _PendingRecipe({this.draft, this.savedRecipeId, required this.availableFoods})
    : assert(
        draft != null || savedRecipeId != null,
        'Need draft or savedRecipeId',
      );

  final RecipeModel? draft;
  final int? savedRecipeId;
  final List<FoodModel> availableFoods;
}
