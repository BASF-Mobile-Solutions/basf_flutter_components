import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('Snackbar types', () {
    testWidgets('Snackbar Info shows up with text', (tester) async {
      const helloSnackBar = 'Info SnackBar';
      const tapTarget = Key('tap-target');
      await tester.pumpApp(
        Scaffold(
          body: Builder(
            builder: (context) {
              return GestureDetector(
                onTap:
                    () =>
                        AppSnackBar.info(message: helloSnackBar).show(context),
                behavior: HitTestBehavior.opaque, // behaviour during the test
                child: const SizedBox(height: 100, width: 100, key: tapTarget),
              );
            },
          ),
        ),
      );
      expect(find.text(helloSnackBar), findsNothing);
      await tester.tap(
        find.byKey(tapTarget),
        warnIfMissed: false, // Added to remove unnecesary warning
      );
      expect(find.text(helloSnackBar), findsNothing);
      await tester.pump();
      expect(find.text(helloSnackBar), findsOneWidget);
    });
    testWidgets('Snackbar Error shows up with text', (tester) async {
      const helloSnackBar = 'Error SnackBar';
      const tapTarget = Key('tap-target');
      await tester.pumpApp(
        Scaffold(
          body: Builder(
            builder: (context) {
              return GestureDetector(
                onTap:
                    () =>
                        AppSnackBar.error(message: helloSnackBar).show(context),
                behavior: HitTestBehavior.opaque, // behaviour during the test
                child: const SizedBox(height: 100, width: 100, key: tapTarget),
              );
            },
          ),
        ),
      );
      expect(find.text(helloSnackBar), findsNothing);
      await tester.tap(
        find.byKey(tapTarget),
        warnIfMissed: false, // Added to remove unnecesary warning
      );
      expect(find.text(helloSnackBar), findsNothing);
      await tester.pump();
      expect(find.text(helloSnackBar), findsOneWidget);
    });
  });
}
