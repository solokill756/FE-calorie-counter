import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:asuka/asuka.dart';
import 'package:caloriecounter/firebase_options.dart';
import 'package:caloriecounter/src/common/widgets/only_one_point_widget.dart';
import 'package:caloriecounter/src/modules/more/more.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'src/common/utils/getit_utils.dart';
import 'src/common/utils/app_environment.dart';
import 'src/core/data/local/storage.dart';
import 'src/core/notifications/meal_log_reminder_service.dart';
import 'src/core/notifications/push_notification_service.dart';
import 'src/core/recipe/recipe_generation_coordinator.dart';
import 'src/modules/app/app_router.dart';
import 'src/modules/auth/presentation/application/cubit/auth_cubit.dart';
import 'src/modules/calorie_counter/presentation/application/calorie_cubit/calorie_cubit.dart';
import 'src/modules/diary/presentation/application/diary_cubit/diary_cubit.dart';
import 'src/modules/logfood/presentation/application/cubit/logfood_cubit.dart';
import 'src/modules/logfood/presentation/application/cubit/logfood_page_cubit.dart';
import 'src/modules/nutrition/presentation/application/food_detail_cubit/food_detail_cubit.dart';
import 'src/modules/nutrition/presentation/application/nutrient_detail_cubit/nutrient_detail_cubit.dart';
import 'src/modules/nutrition/presentation/application/nutrition_cubit/nutrition_cubit.dart';
import 'src/modules/progress/progress.dart';
import 'src/modules/weight_form/presentation/application/cubit/weightForm_cubit.dart';
import 'src/modules/exercise/presentation/application/exercise_cubit/exercise_cubit.dart';
import 'src/modules/add/presentation/application/add_cubit/add_cubit.dart';
import 'src/modules/dashboard/presentation/application/dashboard_cubit.dart';
import 'src/modules/water_log/presentation/application/water_log_cubit.dart';

ThemeData _appLightTheme() {
  const seed = Color(0xFF1E88E5);
  final base = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.light,
  );
  // Richer but cohesive palette: blue primary, indigo secondary, teal tertiary,
  // warm-neutral surfaces and soft outlines (still reads "natural" for health/food).
  final scheme = base.copyWith(
    primary: const Color(0xFF156FB8),
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFD3E9FB),
    onPrimaryContainer: const Color(0xFF0A355F),
    secondary: const Color(0xFF3949AB),
    onSecondary: Colors.white,
    secondaryContainer: const Color(0xFFE8EAF6),
    onSecondaryContainer: const Color(0xFF1A237E),
    tertiary: const Color(0xFF00796B),
    onTertiary: Colors.white,
    tertiaryContainer: const Color(0xFFB2DFDB),
    onTertiaryContainer: const Color(0xFF003D33),
    surface: const Color(0xFFFFFBFE),
    onSurface: const Color(0xFF1C1B1F),
    surfaceContainerLowest: Colors.white,
    surfaceContainerLow: const Color(0xFFF5F8FC),
    surfaceContainer: const Color(0xFFEEF3F9),
    surfaceContainerHigh: const Color(0xFFE6EDF5),
    surfaceContainerHighest: const Color(0xFFD9E3EF),
    onSurfaceVariant: const Color(0xFF45474E),
    outline: const Color(0xFFB8C5D6),
    outlineVariant: const Color(0xFFDDE4EC),
    error: const Color(0xFFB3261E),
    onError: Colors.white,
    errorContainer: const Color(0xFFF9DEDC),
    onErrorContainer: const Color(0xFF410E0B),
    shadow: const Color(0xFF1E2A36).withValues(alpha: 0.18),
    scrim: Colors.black54,
    inverseSurface: const Color(0xFF303034),
    onInverseSurface: const Color(0xFFF3F2F7),
    inversePrimary: const Color(0xFFA6D0FF),
  );
  return ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surfaceContainerLow,
    dividerTheme: DividerThemeData(color: scheme.outlineVariant, thickness: 1),
    cardTheme: CardThemeData(
      color: scheme.surfaceContainerLowest,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.65)),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scheme.tertiary,
      foregroundColor: scheme.onTertiary,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    dialogTheme: const DialogThemeData(surfaceTintColor: Colors.transparent),
    chipTheme: ChipThemeData(
      surfaceTintColor: Colors.transparent,
      side: BorderSide(color: scheme.outlineVariant),
      labelStyle: TextStyle(color: scheme.onSurface, fontSize: 14),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: Colors.transparent,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      surfaceTintColor: Colors.transparent,
    ),
    datePickerTheme: DatePickerThemeData(
      surfaceTintColor: Colors.transparent,
      headerBackgroundColor: scheme.primary,
      headerForegroundColor: scheme.onPrimary,
    ),
    timePickerTheme: TimePickerThemeData(
      dialHandColor: scheme.primary,
      hourMinuteColor: scheme.surfaceContainerHighest,
      entryModeIconColor: scheme.primary,
    ),
  );
}

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // Fix status bar color issue on Android
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
      // Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (Platform.isIOS) {
        // Init Google Sign In với proper configuration
        GoogleSignIn.standard;
      }
      WidgetsFlutterBinding.ensureInitialized();
      await AppEnvironment.setup();
      await Storage.setup();
      await GetItUtils.setup();
      // Setup GetIt dependencies
      await getIt.reset();
      configureDependencies();
      final talker = getIt<Talker>();
      _setupErrorHooks(talker);

      Bloc.observer = TalkerBlocObserver(talker: talker);
      await MealLogReminderService.instance.init();
      // Keep local meal reminders as a fallback until push preference caching is available.
      unawaited(MealLogReminderService.instance.scheduleRollingWindow());
      unawaited(getIt<PushNotificationService>().init());

      runApp(
        OnlyOnePointerRecognizerWidget(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<AuthCubit>()),
              BlocProvider.value(value: getIt<CalorieCubit>()),
              BlocProvider.value(value: getIt<MoreCubit>()),
              BlocProvider.value(value: getIt<DiaryCubit>()),
              BlocProvider.value(value: getIt<WeightFormCubit>()),
              BlocProvider.value(value: getIt<ProgressCubit>()),
              BlocProvider.value(value: getIt<ProgressTrendsCubit>()),
              BlocProvider.value(value: getIt<AddCubit>()),
              BlocProvider.value(value: getIt<LogFoodPageCubit>()),
              BlocProvider.value(value: getIt<LogFoodCubit>()),
              BlocProvider.value(value: getIt<FoodDetailCubit>()),
              BlocProvider.value(value: getIt<NutrientDetailCubit>()),
              BlocProvider.value(value: getIt<NutritionCubit>()),
              BlocProvider.value(value: getIt<ExerciseCubit>()),
              BlocProvider.value(value: getIt<DashboardCubit>()),
              BlocProvider.value(value: getIt<WaterLogCubit>()),
            ],
            child: const MyApp(),
          ),
        ),
      );
    },
    (error, stack) {
      getIt<Talker>().handle(error, stack);
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final initial = WidgetsBinding.instance.lifecycleState;
    if (initial != null) {
      RecipeGenerationCoordinator.instance.updateLifecycle(initial);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    RecipeGenerationCoordinator.instance.updateLifecycle(state);
    if (state == AppLifecycleState.resumed) {
      unawaited(MealLogReminderService.instance.scheduleRollingWindow());
      unawaited(getIt<PushNotificationService>().registerCurrentToken());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Calorie Counter',
          theme: _appLightTheme(),
          routerConfig: getIt<AppRouter>().config(),
          builder: Asuka.builder,
        );
      },
    );
  }
}

Future _setupErrorHooks(Talker talker, {bool catchFlutterErrors = true}) async {
  if (catchFlutterErrors) {
    FlutterError.onError = (FlutterErrorDetails details) async {
      _reportError(details.exception, details.stack, talker);
    };
  }

  PlatformDispatcher.instance.onError = (error, stack) {
    _reportError(error, stack, talker);
    return true;
  };

  /// Web doesn't have Isolate error listener support
  if (!kIsWeb) {
    Isolate.current.addErrorListener(
      RawReceivePort((dynamic pair) async {
        final isolateError = pair as List<dynamic>;
        _reportError(
          isolateError.first.toString(),
          isolateError.last.toString(),
          talker,
        );
      }).sendPort,
    );
  }
}

void _reportError(dynamic error, dynamic stackTrace, Talker talker) async {
  talker.error('Unhandled Exception', error, stackTrace);
}
