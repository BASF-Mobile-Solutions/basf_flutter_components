import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('BASF button', () {
    testWidgets('BasfButtonTest with style', (WidgetTester tester) async {
      await tester.pumpApp(
        BasfTextButton.contained(
          onPressed: () {},
          leadingIcon: Icons.abc,
          trailingIcon: Icons.abc_rounded,
          iconSize: 50,
          style: TextButton.styleFrom(),
          child: const Text('Test'),
        ),
        BasfThemes.lightMainTheme(),
      );

      expect(find.byType(BasfTextButton), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      // expect(find.byIcon(Icons.abc), findsOneWidget);
      // expect(find.byIcon(Icons.abc_rounded), findsOneWidget);
    });
    testWidgets('BasfButtonTest', (WidgetTester tester) async {
      await tester.pumpApp(
        BasfTextButton.contained(
          onPressed: () {},
          leadingIcon: Icons.abc,
          trailingIcon: Icons.abc_rounded,
          iconSize: 50,
          child: const Text('Test'),
        ),
        BasfThemes.lightMainTheme(),
      );

      expect(find.byType(BasfTextButton), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      // expect(find.byIcon(Icons.abc), findsOneWidget);
      // expect(find.byIcon(Icons.abc_rounded), findsOneWidget);
    });
    testWidgets('BasfButtonTest hint with style', (WidgetTester tester) async {
      await tester.pumpApp(
        Builder(
          builder:
              (context) => BasfTextButton.hint(
                onPressed: () {},
                style: TextButton.styleFrom(),
                child: const Text('Test'),
              ),
        ),
        BasfThemes.lightMainTheme(),
      );

      expect(find.byType(BasfTextButton), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      //  expect(find.widgetWithText(Text, 'Test'), findsOneWidget);
    });
    testWidgets('BasfButtonTest hint', (WidgetTester tester) async {
      await tester.pumpApp(
        Builder(
          builder:
              (context) => BasfTextButton.hint(
                onPressed: () {},
                child: const Text('Test'),
              ),
        ),
        BasfThemes.lightMainTheme(),
      );

      expect(find.byType(BasfTextButton), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      //  expect(find.widgetWithText(Text, 'Test'), findsOneWidget);
    });
    testWidgets('BasfButtonTest transparent with style', (
      WidgetTester tester,
    ) async {
      //
      await tester.pumpApp(
        Builder(
          builder:
              (context) => BasfTextButton.transparent(
                onPressed: () {},
                leadingIcon: Icons.abc,
                trailingIcon: Icons.abc_rounded,
                style: TextButton.styleFrom(),
                child: const Text('Test'),
              ),
        ),
        BasfThemes.lightMainTheme(),
      );

      expect(find.byType(BasfTextButton), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      //  expect(find.widgetWithText(Text, 'Test'), findsOneWidget);
    });
    testWidgets('BasfButtonTest transparent', (WidgetTester tester) async {
      //
      await tester.pumpApp(
        Builder(
          builder:
              (context) => BasfTextButton.transparent(
                onPressed: () {},
                leadingIcon: Icons.abc,
                trailingIcon: Icons.abc_rounded,
                child: const Text('Test'),
              ),
        ),
        BasfThemes.lightMainTheme(),
      );

      expect(find.byType(BasfTextButton), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      //  expect(find.widgetWithText(Text, 'Test'), findsOneWidget);
    });
  });
}
