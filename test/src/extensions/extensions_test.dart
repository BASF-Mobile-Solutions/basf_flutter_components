import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('Strings extensions', () {
    const text = 'exception test';
    test('Capitalized text', () {
      final result = text.toCapitalized();

      expect(
        result,
        equals('Exception test'),
      );
    });

    test('Capitalized without text', () {
      const String? test = null;
      final result = test?.toCapitalized();

      expect(
        result,
        equals(null),
      );
    });

    test('TitleCase with text', () {
      final result = text.toTitleCase();

      expect(
        result,
        equals('Exception Test'),
      );
    });

    test('TitleCase without text', () {
      const String? test = null;
      final result = test?.toTitleCase();

      expect(
        result,
        equals(null),
      );
    });
  });

  group('Widgets extensions', () {
    const items = <Widget>[
      Text('a'),
      Text('b'),
      Text('c'),
      Text('d'),
    ];
    test('Adding separator', () {
      final result = items.joinWithSeparator(HorizontalSpacer.semi());

      expect(
        result.length,
        equals(7),
      );
    });

    test('Adding separator on a single widget', () {
      final result = [const Text('a')].joinWithSeparator(
        HorizontalSpacer.semi(),
      );

      expect(
        result.length,
        equals(1),
      );
    });

    test('Adding space should equal same ammount of Widgets, but with padding',
        () {
      final result = items.spaced();

      expect(
        result.length,
        equals(items.length),
      );
    });

    test('Adding a Spacer widget', () {
      final result = [...items, const Spacer()].spaced();

      expect(
        result.length,
        equals(items.length + 1),
      );
    });

    testWidgets(
      'Finds padding when spacing the widgets',
      (tester) async {
        await tester.pumpApp(
          Column(children: items.spaced()),
        );
        expect(find.byType(Padding), findsNWidgets(items.length));
      },
    );
    testWidgets(
      '''Finds paddings when spacing the widgets, doesnt add padding to this to Spacer''',
      (tester) async {
        await tester.pumpApp(
          Column(children: [...items, const Spacer()].spaced()),
        );
        expect(find.byType(Padding), findsNWidgets(items.length));
      },
    );
  });

  group('Object extensions', () {
    test('Log on object', () {
      final strLen = 'MyOutput'.log();

      expect(strLen, 8);
    });
  });

  group('Object Map<K,V>', () {
    test('where extension', () {
      final people = <String, int>{
        'John': 20,
        'Mary': 21,
        'Peter': 22,
      };

      final subMap = people.where((key, value) => key.length > 4 && value > 20);

      expect(subMap, {'Peter': 22});
    });
    test('whereKey extension', () {
      final people = <String, int>{
        'John': 20,
        'Mary': 21,
        'Peter': 22,
      };

      final subMap = people.whereKey((key) => key.length < 5);

      expect(subMap, {'John': 20, 'Mary': 21});
    });
    test('whereValue extension', () {
      final people = <String, int>{
        'John': 20,
        'Mary': 21,
        'Peter': 22,
      };

      final subMap = people.whereValue((value) => value.isEven);

      expect(subMap, {'John': 20, 'Peter': 22});
    });
  });

  group('Snackbar action show', () {
    testWidgets(
      '''Finds paddings when spacing the widgets, doesnt add padding to this to Spacer''',
      (tester) async {
        const helloSnackBar = 'Hello SnackBar';
        const tapTarget = Key('tap-target');
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () =>
                      AppSnackBar.info(message: helloSnackBar).show(context),
                  behavior: HitTestBehavior.opaque, // behaviour during the test
                  child:
                      const SizedBox(height: 100, width: 100, key: tapTarget),
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
      },
    );
  });
}
