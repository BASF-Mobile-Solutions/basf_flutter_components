import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('BASF button', () {
    testWidgets('BasfButtonTest', (WidgetTester tester) async {
      const text = 'Hi!';
      await tester.pumpApp(
        BasfOutlinedButton(
          text: text,
          leadingIcon: Icons.abc_outlined,
          trailingIcon: Icons.abc_outlined,
          onPressed: () {},
        ),
        BasfThemes.lightMainTheme(BasfThemeType.darkBlue),
      );

      expect(find.byType(BasfOutlinedButton), findsOneWidget);
      expect(find.text(text), findsOneWidget);
      // expect(find.byIcon(Icons.abc), findsOneWidget);
      // expect(find.byIcon(Icons.abc_rounded), findsOneWidget);
    });
    testWidgets('Basf date picker', (WidgetTester tester) async {
      const text = 'Hi!';
      const tapTarget = Key('tap-target');
      await tester.pumpApp(
        Builder(
          builder: (context) {
            return BasfOutlinedButton(
              key: tapTarget,
              text: text,
              leadingIcon: Icons.abc_outlined,
              trailingIcon: Icons.abc_outlined,
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: BasfThemes.datePickerButtonTheme(Theme.of(context)),
                      child: child!,
                    );
                  },
                );
              },
            );
          },
        ),
        BasfThemes.lightMainTheme(BasfThemeType.darkBlue),
      );

      expect(find.byType(DatePickerDialog), findsNothing);
      await tester.tap(
        find.byKey(tapTarget),
        warnIfMissed: false, // Added to remove unnecesary warning
      );
      expect(find.byType(DatePickerDialog), findsNothing);
      await tester.pumpAndSettle();
      expect(find.byType(DatePickerDialog), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
