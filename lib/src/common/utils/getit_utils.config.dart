// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:caloriecounter/src/common/utils/logger.dart' as _i364;
import 'package:caloriecounter/src/common/utils/rating_service.dart' as _i575;
import 'package:caloriecounter/src/core/data/remote/services/api_service.dart'
    as _i354;
import 'package:caloriecounter/src/core/data/remote/services/firebase_module.dart'
    as _i81;
import 'package:caloriecounter/src/core/notifications/push_notification_repository.dart'
    as _i773;
import 'package:caloriecounter/src/core/notifications/push_notification_service.dart'
    as _i664;
import 'package:caloriecounter/src/modules/add/presentation/application/add_cubit/add_cubit.dart'
    as _i666;
import 'package:caloriecounter/src/modules/app/app_router.dart' as _i440;
import 'package:caloriecounter/src/modules/auth/data/repository/auth_repository_impl.dart'
    as _i967;
import 'package:caloriecounter/src/modules/auth/data/repository/onboarding_repository_impl.dart'
    as _i284;
import 'package:caloriecounter/src/modules/auth/domain/repository/auth_repository.dart'
    as _i609;
import 'package:caloriecounter/src/modules/auth/domain/repository/onboarding_repository.dart'
    as _i445;
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/auth_cubit.dart'
    as _i546;
import 'package:caloriecounter/src/modules/calorie_counter/data/repository/calorie_repository_impl.dart'
    as _i938;
import 'package:caloriecounter/src/modules/calorie_counter/domain/repository/calorie_repository.dart'
    as _i572;
import 'package:caloriecounter/src/modules/calorie_counter/presentation/application/calorie_cubit/calorie_cubit.dart'
    as _i32;
import 'package:caloriecounter/src/modules/dashboard/data/dashboard_repository_impl.dart'
    as _i741;
import 'package:caloriecounter/src/modules/dashboard/domain/repository/dashboard_repository.dart'
    as _i306;
import 'package:caloriecounter/src/modules/dashboard/presentation/application/dashboard_cubit.dart'
    as _i563;
import 'package:caloriecounter/src/modules/diary/data/repository/diary_repository_impl.dart'
    as _i529;
import 'package:caloriecounter/src/modules/diary/domain/repository/diary_repository.dart'
    as _i652;
import 'package:caloriecounter/src/modules/diary/presentation/application/diary_cubit/diary_cubit.dart'
    as _i776;
import 'package:caloriecounter/src/modules/exercise/data/exercise_repository_impl.dart'
    as _i191;
import 'package:caloriecounter/src/modules/exercise/domain/repository/exercise_repository.dart'
    as _i662;
import 'package:caloriecounter/src/modules/exercise/presentation/application/exercise_cubit/exercise_cubit.dart'
    as _i196;
import 'package:caloriecounter/src/modules/home/domain/repository/home_repo.dart'
    as _i532;
import 'package:caloriecounter/src/modules/logfood/data/repository/food_repository_impl.dart'
    as _i811;
import 'package:caloriecounter/src/modules/logfood/data/repository/logfood_repository_impl.dart'
    as _i828;
import 'package:caloriecounter/src/modules/logfood/data/services/food_api_service.dart'
    as _i89;
import 'package:caloriecounter/src/modules/logfood/domain/repository/food_repository.dart'
    as _i663;
import 'package:caloriecounter/src/modules/logfood/domain/repository/logfood_repo.dart'
    as _i828;
import 'package:caloriecounter/src/modules/logfood/presentation/application/cubit/logfood_cubit.dart'
    as _i485;
import 'package:caloriecounter/src/modules/logfood/presentation/application/cubit/logfood_page_cubit.dart'
    as _i164;
import 'package:caloriecounter/src/modules/more/data/repository/more_repo_impl.dart'
    as _i964;
import 'package:caloriecounter/src/modules/more/domain/repository/more_repo.dart'
    as _i468;
import 'package:caloriecounter/src/modules/more/presentation/application/edit_profile_cubit/edit_profile_cubit.dart'
    as _i148;
import 'package:caloriecounter/src/modules/more/presentation/application/more_cubit/more_cubit.dart'
    as _i29;
import 'package:caloriecounter/src/modules/more/presentation/application/notification_settings_cubit/notification_settings_cubit.dart'
    as _i602;
import 'package:caloriecounter/src/modules/nutrition/data/repository/food_detail_repository_impl.dart'
    as _i459;
import 'package:caloriecounter/src/modules/nutrition/data/repository/nutrient_detail_repository_impl.dart'
    as _i504;
import 'package:caloriecounter/src/modules/nutrition/data/repository/nutrition_repository_impl.dart'
    as _i183;
import 'package:caloriecounter/src/modules/nutrition/data/services/api/nutrition_api_service.dart'
    as _i250;
import 'package:caloriecounter/src/modules/nutrition/data/services/calculators/daily_nutrition_calculator.dart'
    as _i413;
import 'package:caloriecounter/src/modules/nutrition/data/services/daily_nutrition_calculation_service.dart'
    as _i985;
import 'package:caloriecounter/src/modules/nutrition/data/services/food_nutrient_processor_service.dart'
    as _i44;
import 'package:caloriecounter/src/modules/nutrition/data/services/nutrient_aggregation_service.dart'
    as _i904;
import 'package:caloriecounter/src/modules/nutrition/data/services/nutrient_extractor_service.dart'
    as _i409;
import 'package:caloriecounter/src/modules/nutrition/data/services/nutrition_api_service.dart'
    as _i928;
import 'package:caloriecounter/src/modules/nutrition/domain/repository/food_detail_repository.dart'
    as _i959;
import 'package:caloriecounter/src/modules/nutrition/domain/repository/nutrient_detail_repository.dart'
    as _i678;
import 'package:caloriecounter/src/modules/nutrition/domain/repository/nutrition_repository.dart'
    as _i585;
import 'package:caloriecounter/src/modules/nutrition/presentation/application/food_detail_cubit/food_detail_cubit.dart'
    as _i409;
import 'package:caloriecounter/src/modules/nutrition/presentation/application/nutrient_detail_cubit/nutrient_detail_cubit.dart'
    as _i444;
import 'package:caloriecounter/src/modules/nutrition/presentation/application/nutrition_cubit/nutrition_cubit.dart'
    as _i87;
import 'package:caloriecounter/src/modules/progress/data/repository/process_repo_impl.dart'
    as _i522;
import 'package:caloriecounter/src/modules/progress/data/repository/progress_trends_repository_impl.dart'
    as _i835;
import 'package:caloriecounter/src/modules/progress/domain/repository/progress_repo.dart'
    as _i573;
import 'package:caloriecounter/src/modules/progress/domain/repository/progress_trends_repository.dart'
    as _i495;
import 'package:caloriecounter/src/modules/progress/presentation/application/progress_cubit/progress_cubit.dart'
    as _i131;
import 'package:caloriecounter/src/modules/progress/presentation/application/progress_trends_cubit/progress_trends_cubit.dart'
    as _i499;
import 'package:caloriecounter/src/modules/water_log/data/water_log_repository_impl.dart'
    as _i771;
import 'package:caloriecounter/src/modules/water_log/domain/repository/water_log_repository.dart'
    as _i82;
import 'package:caloriecounter/src/modules/water_log/presentation/application/water_log_cubit.dart'
    as _i84;
import 'package:caloriecounter/src/modules/weight_form/data/repository/weight_form_impl.dart'
    as _i18;
import 'package:caloriecounter/src/modules/weight_form/domain/repository/weightForm_repo.dart'
    as _i157;
import 'package:caloriecounter/src/modules/weight_form/presentation/application/cubit/weightForm_cubit.dart'
    as _i673;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final loggerModule = _$LoggerModule();
    final firebaseModule = _$FirebaseModule();
    final apiModule = _$ApiModule();
    gh.singleton<_i207.Talker>(() => loggerModule.talker());
    gh.singleton<_i666.AddCubit>(() => _i666.AddCubit());
    gh.singleton<_i440.AppRouter>(() => _i440.AppRouter());
    gh.singleton<_i532.HomeRepository>(() => _i532.HomeRepository());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.auth);
    gh.lazySingleton<_i457.FirebaseStorage>(() => firebaseModule.storage);
    gh.lazySingleton<_i409.NutrientExtractorService>(
        () => _i409.NutrientExtractorServiceImpl());
    gh.lazySingleton<_i904.NutrientAggregationService>(
        () => _i904.NutrientAggregationServiceImpl());
    gh.lazySingleton<_i575.RatingService>(() => _i575.RatingServiceImpl());
    gh.lazySingleton<_i985.DailyNutritionCalculationService>(
        () => _i985.DailyNutritionCalculationServiceImpl());
    gh.lazySingleton<_i773.PushNotificationRepository>(
        () => _i773.PushNotificationRepository(gh<InvalidType>()));
    gh.factory<String>(
      () => apiModule.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.factory<_i602.NotificationSettingsCubit>(() =>
        _i602.NotificationSettingsCubit(
            gh<_i773.PushNotificationRepository>()));
    gh.lazySingleton<_i413.DailyNutritionCalculator>(
        () => _i413.DailyNutritionCalculatorImpl());
    gh.lazySingleton<_i664.PushNotificationService>(
        () => _i664.PushNotificationService(
              gh<_i773.PushNotificationRepository>(),
              gh<_i440.AppRouter>(),
            ));
    gh.lazySingleton<_i44.FoodNutrientProcessorService>(() =>
        _i44.FoodNutrientProcessorServiceImpl(
            gh<_i409.NutrientExtractorService>()));
    gh.singleton<_i361.Dio>(() => apiModule.dio(
          gh<String>(instanceName: 'baseUrl'),
          gh<_i207.Talker>(),
        ));
    gh.lazySingleton<_i250.NutritionApiService>(
        () => _i250.NutritionApiServiceImpl(gh<_i361.Dio>()));
    gh.factory<_i468.MoreRepository>(
        () => _i964.MoreRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i663.FoodRepository>(
        () => _i811.FoodRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i828.LogFoodRepository>(
        () => _i828.LogFoodRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i652.DiaryRepository>(
        () => _i529.DiaryRepositoryImpl(gh<_i361.Dio>()));
    gh.singleton<_i164.LogFoodPageCubit>(() =>
        _i164.LogFoodPageCubit(foodRepository: gh<_i663.FoodRepository>()));
    gh.lazySingleton<_i928.NutritionApiService>(
        () => _i928.NutritionApiServiceImpl(gh<_i361.Dio>()));
    gh.factory<_i609.AuthRepository>(
        () => _i967.AuthRepositoryImpl(gh<_i361.Dio>()));
    gh.factory<_i573.ProgressRepository>(
        () => _i522.ProcessRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i572.CalorieRepository>(
        () => _i938.CalorieRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i82.WaterLogRepository>(
        () => _i771.WaterLogRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i662.ExerciseRepository>(
        () => _i191.ExerciseRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i495.ProgressTrendsRepository>(
        () => _i835.ProgressTrendsRepositoryImpl(gh<_i361.Dio>()));
    gh.factory<_i157.WeightFormRepository>(
        () => _i18.WeightFormRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i306.DashboardRepository>(
        () => _i741.DashboardRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i585.NutritionRepository>(
        () => _i183.NutritionRepositoryImpl(
              gh<_i250.NutritionApiService>(),
              gh<_i904.NutrientAggregationService>(),
              gh<_i985.DailyNutritionCalculationService>(),
            ));
    gh.factory<_i445.OnboardingRepository>(
        () => _i284.OnboardingRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i89.FoodApiService>(
        () => _i89.FoodApiServiceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i959.FoodDetailRepository>(
        () => _i459.FoodDetailRepositoryImpl(gh<_i361.Dio>()));
    gh.factory<_i84.WaterLogCubit>(
        () => _i84.WaterLogCubit(gh<_i82.WaterLogRepository>()));
    gh.singleton<_i32.CalorieCubit>(
        () => _i32.CalorieCubit(gh<_i572.CalorieRepository>()));
    gh.singleton<_i673.WeightFormCubit>(() => _i673.WeightFormCubit(
        weightFormRepository: gh<_i157.WeightFormRepository>()));
    gh.singleton<_i131.ProgressCubit>(
        () => _i131.ProgressCubit(gh<_i573.ProgressRepository>()));
    gh.lazySingleton<_i678.NutrientDetailRepository>(
        () => _i504.NutrientDetailRepositoryImpl(
              gh<_i828.LogFoodRepository>(),
              gh<_i585.NutritionRepository>(),
            ));
    gh.lazySingleton<_i563.DashboardCubit>(() => _i563.DashboardCubit(
          gh<_i306.DashboardRepository>(),
          gh<_i82.WaterLogRepository>(),
        ));
    gh.singleton<_i776.DiaryCubit>(
        () => _i776.DiaryCubit(gh<_i652.DiaryRepository>()));
    gh.singleton<_i409.FoodDetailCubit>(
        () => _i409.FoodDetailCubit(gh<_i959.FoodDetailRepository>()));
    gh.singleton<_i485.LogFoodCubit>(() =>
        _i485.LogFoodCubit(logFoodRepository: gh<_i828.LogFoodRepository>()));
    gh.singleton<_i29.MoreCubit>(() => _i29.MoreCubit(
          gh<_i609.AuthRepository>(),
          gh<_i495.ProgressTrendsRepository>(),
        ));
    gh.factory<_i148.EditProfileCubit>(() => _i148.EditProfileCubit(
          gh<_i609.AuthRepository>(),
          gh<_i29.MoreCubit>(),
        ));
    gh.singleton<_i499.ProgressTrendsCubit>(
        () => _i499.ProgressTrendsCubit(gh<_i495.ProgressTrendsRepository>()));
    gh.singleton<_i196.ExerciseCubit>(
        () => _i196.ExerciseCubit(gh<_i662.ExerciseRepository>()));
    gh.singleton<_i87.NutritionCubit>(
        () => _i87.NutritionCubit(gh<_i585.NutritionRepository>()));
    gh.singleton<_i444.NutrientDetailCubit>(
        () => _i444.NutrientDetailCubit(gh<_i678.NutrientDetailRepository>()));
    gh.singleton<_i546.AuthCubit>(() => _i546.AuthCubit(
          authRepository: gh<_i609.AuthRepository>(),
          onboardingRepository: gh<_i445.OnboardingRepository>(),
          moreCubit: gh<_i29.MoreCubit>(),
        ));
    return this;
  }
}

class _$LoggerModule extends _i364.LoggerModule {}

class _$FirebaseModule extends _i81.FirebaseModule {}

class _$ApiModule extends _i354.ApiModule {}
