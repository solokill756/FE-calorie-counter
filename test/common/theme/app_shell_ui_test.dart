import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';

void main() {
  testWidgets('AppShellUi macro getters return dashboard palette colors', (WidgetTester tester) async {
    // Build a minimal app to get a BuildContext
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (context) {
      // Use the getters and attach to a Container so we can read the color
      final carbs = AppShellUi.macroCarbs(context);
      final fat = AppShellUi.macroFat(context);
      final protein = AppShellUi.macroProtein(context);

      // Expose colors via semantics label for easy lookup
      return Column(children: [
        Container(key: Key('carbs'), color: carbs, width: 10, height: 10),
        Container(key: Key('fat'), color: fat, width: 10, height: 10),
        Container(key: Key('protein'), color: protein, width: 10, height: 10),
      ]);
    })));

    // Read back colors from widgets
    final carbsWidget = tester.widget<Container>(find.byKey(Key('carbs')));
    final fatWidget = tester.widget<Container>(find.byKey(Key('fat')));
    final proteinWidget = tester.widget<Container>(find.byKey(Key('protein')));

    expect(carbsWidget.color, equals(const Color(0xFFE65100))); // orange
    expect(fatWidget.color, equals(const Color(0xFF6A1B9A))); // purple
    expect(proteinWidget.color, equals(const Color(0xFF1565C0))); // blue
  });
}
