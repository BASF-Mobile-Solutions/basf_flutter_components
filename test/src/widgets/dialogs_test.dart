import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Alert Dialog types', () {
    /*
    testWidgets(
      'Alert dialog with description shows up',
      (tester) async {
        FlutterError.onError = ignoreOverflowErrors;

        const helloDialog = 'Hello Dialog';
        const dismissText = 'Dismiss';
        const confirmText = 'OK';
        const tapTarget = Key('tap-target');
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () => showDialog<void>(
                    context: context,
                    builder: (context) {
                      return const BasfAlertDialog(
                        title: helloDialog,
                        description: 'Only Confirm is default',
                        //onlyConfirm: true, // Optional
                        confirmText: confirmText,
                        dismissText: dismissText,
                      );
                    },
                  ),
                  behavior: HitTestBehavior.opaque, // behaviour during the test
                  child:
                      const SizedBox(height: 100, width: 100, key: tapTarget),
                );
              },
            ),
          ),
          BasfThemes.lightMainTheme(BasfThemeType.darkBlue),
        );
        expect(find.text(helloDialog), findsNothing);
        expect(find.byType(BasfAlertDialog), findsNothing);
        await tester.tap(
          find.byKey(tapTarget),
          warnIfMissed: false, // Added to remove unnecesary warning
        );
        expect(find.byType(BasfAlertDialog), findsNothing);
        expect(find.text(helloDialog), findsNothing);
        await tester.pump();
        expect(find.text(helloDialog), findsOneWidget);
        expect(find.byType(BasfAlertDialog), findsOneWidget);
        // Buttons are visible
        expect(
          find.widgetWithText(BasfOutlinedButton, dismissText),
          findsOneWidget,
        );
        expect(
          find.widgetWithText(BasfTextButton, confirmText),
          findsOneWidget,
        );

        expect(find.text(confirmText), findsOneWidget);
        expect(find.text(dismissText), findsOneWidget);

        expect(find.byType(BasfAlertDialog), findsOneWidget);
        await tester.tap(find.text(confirmText));
        await tester.pump();
        expect(find.byType(BasfAlertDialog), findsNothing);

        await tester.tap(
          find.byKey(tapTarget),
          warnIfMissed: false, // Added to remove unnecesary warning
        );
        await tester.pump();

        expect(find.byType(BasfAlertDialog), findsOneWidget);
        await tester.tap(find.text(dismissText));
        await tester.pump();
        expect(find.byType(BasfAlertDialog), findsNothing);
        
        // Lets mock the pressed function
        // ! Mock taps -> dismiss, confirm
        //await tester.tap(
        //  find.widgetWithText(BasfOutlinedButton, dismissText),
        //  warnIfMissed: false,
        //);

        //await tester.tap(
        //  find.widgetWithText(BasfOutlinedButton, 'Cancel'),
        //  warnIfMissed: false, // Added to remove unnecesary warning
        //);
        //await tester.pump();
        //expect(find.byType(BasfAlertDialog), findsNothing);
      },
    );
  */
  });
}
