import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/test_helpers.dart';

void main() {
  group('Radio Options', () {
    testWidgets(
      'Active checkbox',
      (tester) async {
        FlutterError.onError = ignoreOverflowErrors;

        // ignore: prefer_function_declarations_over_variables
        final onChanged = (myBool) => true;
        const radioText = 'Hi Radio!';
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return RadioOptions<String>(
                  labelGenerator: (value) => value,
                  values: const ['a', 'b', 'c'],
                  selectedValue: 'a',
                  title: radioText,
                  onSelected: onChanged,
                  identityHelperFunction: (_) => _,
                );
              },
            ),
          ),
        );
        expect(find.text(radioText), findsOneWidget);
        expect(find.byType(RadioOptions<String>), findsOneWidget);
        expect(find.byType(OptionButton), findsNWidgets(3));

        await tester.tap(
          find.widgetWithText(OptionButton, 'b'),
          warnIfMissed: false, // Added to remove unnecesary warning
        );
        await tester.pump();
      },
    );
    testWidgets(
      'Active checkbox',
      (tester) async {
        FlutterError.onError = ignoreOverflowErrors;

        // ignore: prefer_function_declarations_over_variables
        final onChanged = (myBool) => true;
        const radioText = 'Hi Radio!';
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return RadioOptions<String>(
                  labelGenerator: (value) => value,
                  values: const ['a', 'b', 'c'],
                  selectedValue: 'a',
                  title: radioText,
                  onSelected: onChanged,
                );
              },
            ),
          ),
        );
        expect(find.text(radioText), findsOneWidget);
        expect(find.byType(RadioOptions<String>), findsOneWidget);
        expect(find.byType(OptionButton), findsNWidgets(3));

        await tester.tap(
          find.widgetWithText(OptionButton, 'b'),
          warnIfMissed: false, // Added to remove unnecesary warning
        );
        await tester.pump();
      },
    );
  });
}
