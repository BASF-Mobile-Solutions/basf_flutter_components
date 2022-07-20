// import 'package:basf_flutter_components/basf_flutter_components.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import '../../../helpers/pump_app.dart';

// TODO: Update this test
void main() {
  /*
  group('Dropdown', () {
    
    testWidgets(
      'Dropdown with text controller text',
      (tester) async {
        //    FlutterError.onError = ignoreOverflowErrors;
        const key = Key('dropdown');
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return BasfDropDownInput(
                  key: key,
                  controller: TextEditingController(text: ' a '),
                  values: const ['a', 'b', 'c'],
                  isLoading: true, // Optional
                );
              },
            ),
          ),
        );
        expect(find.byType(BasfDropDownInput), findsOneWidget);
      },
    );
    testWidgets(
      'Dropdown without text in controller',
      (tester) async {
        //    FlutterError.onError = ignoreOverflowErrors;
        const key = Key('dropdown');
        final controller = TextEditingController();
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return BasfDropDownInput(
                  key: key,
                  controller: controller,
                  values: const ['a', 'b', 'c'],
                );
              },
            ),
          ),
        );
        expect(find.byType(BasfDropDownInput), findsOneWidget);
        expect(find.byKey(key), findsOneWidget);
        await tester.tap(
          find.byType(PopupMenuButton<String>),
          warnIfMissed: false, // Added to remove unnecesary warning
        );

        // Repeatedly calls pump with the given duration until there are no
        // longer any frames scheduled. This will call pump at least once, even
        // if no frames are scheduled when the function is called, to flush any
        // pending microtasks which may themselves schedule a frame.
        await tester.pumpAndSettle();
        final childButton = find.text('b');
        expect(childButton, findsOneWidget);
        await tester.tap(childButton);
        await tester.pumpAndSettle();
      },
    );
  });
  */
}
