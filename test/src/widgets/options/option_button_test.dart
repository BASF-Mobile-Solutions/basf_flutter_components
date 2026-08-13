import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/test_helpers.dart';

void main() {
  group('Radio Options', () {
    testWidgets('Active checkbox', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;

      const optionButtonText = 'Hi OptionButton!';
      await tester.pumpApp(
        Scaffold(
          body: Builder(
            builder: (context) {
              return const OptionButton(
                isSelected: true,
                labelText: optionButtonText,
                description: 'This is my cool description 😎',
              );
            },
          ),
        ),
      );
      expect(find.text(optionButtonText), findsOneWidget);
      expect(find.byType(OptionButton), findsOneWidget);

      await tester.tap(
        find.byType(OptionButton),
        warnIfMissed: false, // Added to remove unnecesary warning
      );
      await tester.pump();
    });
  });
}
