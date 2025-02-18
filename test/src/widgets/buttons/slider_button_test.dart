import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('BASF Slider Button', () {
    testWidgets('Slider button text', (WidgetTester tester) async {
      const text = 'Hi!';
      await tester.pumpApp(
        SliderButton(text: text, onConfirmation: () {}),
        BasfThemes.lightMainTheme(),
      );

      expect(find.byType(SliderButton), findsOneWidget);
      expect(find.text(text), findsOneWidget);
      // Swipe the item a bit
      await tester.drag(find.byType(GestureDetector), const Offset(270, 0));
      await tester.pumpAndSettle();

      // Swipe all the way
      await tester.drag(find.byType(GestureDetector), const Offset(50000, 0));
      await tester.pumpAndSettle();
    });
    testWidgets('Slider button text, themed', (WidgetTester tester) async {
      const text = 'Hi!';
      await tester.pumpApp(
        SliderButton(
          text: text,
          onConfirmation: () {},
          backgroundColor: Colors.red,
          backgroundColorEnd: Colors.orange,
          backgroundShape: BorderRadius.circular(20),
          stickToEnd: true,
        ),
        BasfThemes.lightMainTheme(),
      );

      expect(find.byType(SliderButton), findsOneWidget);
      // Swipe the item to dismiss it.
      await tester.drag(find.byType(GestureDetector), const Offset(50000, 0));
      await tester.pumpAndSettle();
    });

    testWidgets('Slider test slider button in the middle', (
      WidgetTester tester,
    ) async {
      await tester.pumpApp(
        SliderButton(onConfirmation: () {}, width: 2000, height: 500),
        BasfThemes.lightMainTheme(),
      );

      expect(find.byType(SliderButton), findsOneWidget);
      // holding it to maintain the widget in site after drag
      await tester.timedDrag(
        find.byType(GestureDetector),
        const Offset(10000, 0),
        const Duration(seconds: 5),
      );
      await tester.pumpAndSettle();
    });
  });
}
