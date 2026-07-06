import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:caloriecounter/src/common/widgets/unified_error_display.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => child,
        ),
      ),
    );
  }

  group('UnifiedErrorDisplay', () {
    testWidgets('renders error message', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          UnifiedErrorDisplay(
            message: 'Test Error Message',
            subtitle: 'Please try again.',
            onRetry: () {},
            primaryColor: Colors.blue,
          ),
        ),
      );

      expect(find.text('Test Error Message'), findsOneWidget);
      expect(find.text('Please try again.'), findsOneWidget);
    });

    testWidgets('renders retry button', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          UnifiedErrorDisplay(
            message: 'Test Error',
            subtitle: 'Please try again.',
            onRetry: () {},
            primaryColor: Colors.blue,
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('calls onRetry when button tapped', (tester) async {
      bool retryPressed = false;
      await tester.pumpWidget(
        buildTestableWidget(
          UnifiedErrorDisplay(
            message: 'Test Error',
            subtitle: 'Retry',
            onRetry: () => retryPressed = true,
            primaryColor: Colors.blue,
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(retryPressed, true);
    });

    testWidgets('renders warning icon', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          UnifiedErrorDisplay(
            message: 'Test Error',
            subtitle: 'Please try again.',
            onRetry: () {},
            primaryColor: Colors.blue,
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
