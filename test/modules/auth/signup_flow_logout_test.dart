import 'package:bloc_test/bloc_test.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/auth_cubit.dart';
import 'package:caloriecounter/src/modules/auth/presentation/pages/signup_flow_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late MockAuthCubit authCubit;

  setUpAll(() {
    registerFallbackValue(const UserProfileModel());
  });

  setUp(() {
    authCubit = MockAuthCubit();
    when(() => authCubit.state).thenReturn(const AuthState.initial());
    when(
      () => authCubit.loadOnboardingDraft(any()),
    ).thenAnswer((_) async => const UserProfileModel());
  });

  testWidgets('shows logout confirmation from onboarding app bar', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return BlocProvider<AuthCubit>.value(
              value: authCubit,
              child: const SignUpFlowPage(),
            );
          },
        ),
      ),
    );

    await tester.pump();

    await tester.tap(find.byTooltip('Log out'));
    await tester.pumpAndSettle();

    expect(find.text('Log out?'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Log out'), findsOneWidget);
  });
}
