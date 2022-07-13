import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/test_helpers.dart';

void main() {
  group('Checkboxes', () {
    testWidgets(
      'Active checkbox',
      (tester) async {
        FlutterError.onError = ignoreOverflowErrors;

        // ignore: prefer_function_declarations_over_variables
        final onChanged = (myBool) => true;

        const checkboxText = 'Hi Checkbox!';
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return BasfCheckbox(
                  text: checkboxText,
                  onChanged: onChanged,
                  value: true,
                );
              },
            ),
          ),
        );
        expect(find.text(checkboxText), findsOneWidget);
        expect(find.byType(BasfCheckbox), findsOneWidget);

        await tester.tap(
          find.byType(MaterialButton),
          warnIfMissed: false, // Added to remove unnecesary warning
        );
        await tester.pump();
      },
    );
    testWidgets(
      'Inactive checkbox',
      (tester) async {
        FlutterError.onError = ignoreOverflowErrors;

        const checkboxText = 'Hi Checkbox!';
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return BasfCheckbox(
                  text: checkboxText,
                  // ignore: avoid_returning_null_for_void
                  onChanged: (_) => null,
                  value: false,
                );
              },
            ),
          ),
        );
        expect(find.text(checkboxText), findsOneWidget);
        expect(find.byType(BasfCheckbox), findsOneWidget);
      },
    );
  });
}
