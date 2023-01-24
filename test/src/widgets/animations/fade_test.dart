import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('Alert Dialog types', () {
    testWidgets(
      'Alert dialog with description shows up',
      (tester) async {
        const tapTarget = Key('tap-target');
        await tester.pumpApp(
          const Scaffold(body: MyWidget(finderKey: tapTarget)),
          BasfThemes.lightMainTheme(),
        );
        expect(find.byIcon(Icons.abc), findsOneWidget);
        await tester.tap(
          find.byKey(tapTarget),
          warnIfMissed: false, // Added to remove unnecesary warning
        );
        await tester.pumpAndSettle();
        // here it should not be visible
        // ! figure out why it does not change the visibility
        // ! and fix the didUpdateWidget test part
        await tester.tap(
          find.byKey(tapTarget),
          warnIfMissed: false, // Added to remove unnecesary warning
        );
        // here it should be visible
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.abc), findsOneWidget);
      },
    );
  });
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key, required this.finderKey});
  final Key finderKey;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => visible = !visible),
      behavior: HitTestBehavior.opaque, // behaviour during the test
      child: Fade(
        visible: visible,
        child: Container(
          color: Colors.red,
          height: 100,
          width: 100,
          key: widget.finderKey,
          child: const Icon(Icons.abc),
          //visible ? Icons.abc : Icons.hide_image),
        ),
      ),
    );
  }
}
