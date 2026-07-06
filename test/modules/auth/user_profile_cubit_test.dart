import 'package:bloc_test/bloc_test.dart';
import 'package:caloriecounter/src/core/data/local/storage.dart';
import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_nutritional_threshold_model.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:caloriecounter/src/modules/auth/domain/repository/auth_repository.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_cubit.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

final _serverProfile = UserProfileModel(
  displayName: 'Bob',
  email: 'bob@test.com',
  dailyCalorieTarget: 2100,
  macroCarbsG: 260,
  nutritionalThresholds: [
    const UserNutritionalThreshold(nutrient: 'sugars', maxAmount: 20, unit: 'g'),
  ],
);

void main() {
  late _MockAuthRepository authRepository;
  late UserProfileCubit cubit;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await Storage.setup();
  });

  setUp(() {
    authRepository = _MockAuthRepository();
    cubit = UserProfileCubit(authRepository);
  });

  tearDown(() => cubit.close());

  blocTest<UserProfileCubit, UserProfileState>(
    'refresh emits loaded and updates local identity only',
    build: () {
      when(() => authRepository.getUserProfile())
          .thenAnswer((_) async => Success(_serverProfile));
      return cubit;
    },
    act: (c) => c.refresh(),
    expect: () => [
      predicate<UserProfileState>((state) {
        return state.maybeWhen(
          loaded: (profile) => profile.dailyCalorieTarget == 2100,
          orElse: () => false,
        );
      }),
    ],
    verify: (_) {
      final identity = Storage.userIdentity;
      expect(identity?.email, 'bob@test.com');
      expect(identity?.displayName, 'Bob');
      expect(identity?.toJson().containsKey('dailyCalorieTarget'), isFalse);
    },
  );

  blocTest<UserProfileCubit, UserProfileState>(
    'refresh error keeps previous profile',
    build: () {
      when(() => authRepository.getUserProfile())
          .thenAnswer((_) async => Failure(ApiError(500, 'network')));
      return cubit;
    },
    seed: () => UserProfileState.loaded(_serverProfile),
    act: (c) => c.refresh(),
    expect: () => [
      predicate<UserProfileState>((state) {
        return state.maybeWhen(
          error: (_, previous) => previous?.dailyCalorieTarget == 2100,
          orElse: () => false,
        );
      }),
    ],
  );
}
