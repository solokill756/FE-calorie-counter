import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:caloriecounter/src/modules/exercise/presentation/pages/exercise_history_page.dart';
import 'package:caloriecounter/src/modules/exercise/presentation/application/exercise_cubit/exercise_cubit.dart';
import 'package:caloriecounter/src/modules/exercise/domain/models/exercise_models.dart';

class MockExerciseCubit extends MockCubit<ExerciseUiState>
    implements ExerciseCubit {}

void main() {
  late MockExerciseCubit mockExerciseCubit;

  setUp(() {
    mockExerciseCubit = MockExerciseCubit();
  });

  testWidgets('Delete button is not present on the UI', (tester) async {
    final testItem = ExerciseLogListItem(
      id: 1,
      exerciseId: 101,
      exerciseName: 'Running',
      exerciseType: 'cardio',
      startedAt: DateTime(2026, 5, 29, 10, 0),
      minutesPerformed: 30.0,
      caloriesBurned: 300.0,
      source: 'manual',
    );

    final testHistoryPage = ExerciseLogListPage(
      items: [testItem],
      page: 1,
      limit: 50,
      total: 1,
    );

    when(() => mockExerciseCubit.state).thenReturn(
      ExerciseUiState(
        listLoading: false,
        history: testHistoryPage,
      ),
    );
    when(() => mockExerciseCubit.loadHistory(any(), any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return BlocProvider<ExerciseCubit>.value(
                value: mockExerciseCubit,
                child: const ExerciseHistoryPage(),
              );
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Running'), findsOneWidget);

    final deleteButton = find.byIcon(Icons.delete_outline);
    expect(deleteButton, findsNothing);
  });
}
