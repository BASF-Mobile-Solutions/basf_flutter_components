import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('Strings extensions', () {
    const text = 'exception test';
    test('Capitalized text', () {
      final result = text.toCapitalized();

      expect(result, equals('Exception test'));
    });

    test('Capitalized without text', () {
      const String? test = null;
      final result = test?.toCapitalized();

      expect(result, equals(null));
    });

    test('TitleCase with text', () {
      final result = text.toTitleCase();

      expect(result, equals('Exception Test'));
    });

    test('TitleCase without text', () {
      const String? test = null;
      final result = test?.toTitleCase();

      expect(result, equals(null));
    });
  });

  group('Sentence case', () {
    test('Splits camelCase', () {
      expect('errorMessages'.toSentenceCase(), equals('Error messages'));
    });

    test('Splits snake_case and kebab-case', () {
      expect('send_by'.toSentenceCase(), equals('Send by'));
      expect('mat-doc-no'.toSentenceCase(), equals('Mat doc no'));
    });

    test('Keeps a single word', () {
      expect('instance'.toSentenceCase(), equals('Instance'));
    });

    test('Stays empty for an empty text', () {
      expect(''.toSentenceCase(), equals(''));
    });
  });

  group('JSON string extension', () {
    test('Decodes a JSON object with the JSON nested in its values', () {
      final result = r'{"detail":"{\"code\":500}"}'.toJsonValue();

      expect(
        result,
        equals({
          'detail': {'code': 500},
        }),
      );
    });

    test('Has no JSON value for plain text', () {
      expect('Purchase order 4711 not found'.toJsonValue(), isNull);
    });

    test('Has no JSON value for broken or empty JSON', () {
      expect('{"detail": '.toJsonValue(), isNull);
      expect(''.toJsonValue(), isNull);
      expect('{"detail": '.toPrettyJson(), equals('{"detail": '));
    });

    test('Pretty prints a JSON object', () {
      final result = '{"title":"Internal Server Error","status":"500"}'.toPrettyJson();

      expect(result, equals('{\n  "title": "Internal Server Error",\n  "status": "500"\n}'));
    });

    test('Pretty prints a JSON array', () {
      final result = '[1,2]'.toPrettyJson();

      expect(result, equals('[\n  1,\n  2\n]'));
    });

    test('Expands JSON nested in a string value', () {
      const detail =
          r'{"detail":"{\"errorMessages\":[{\"text\":\"Purchase order 4711 not found\"}]}"}';
      final result = detail.toPrettyJson();

      expect(
        result,
        equals(
          '{\n'
          '  "detail": {\n'
          '    "errorMessages": [\n'
          '      {\n'
          '        "text": "Purchase order 4711 not found"\n'
          '      }\n'
          '    ]\n'
          '  }\n'
          '}',
        ),
      );
    });

    test('Leaves plain text as it is', () {
      expect(
        'Purchase order 4711 not found'.toPrettyJson(),
        equals('Purchase order 4711 not found'),
      );
    });

    test('Leaves text that only looks like JSON as it is', () {
      const mapToString = '{title: Internal Server Error, status: 500}';

      expect(mapToString.toPrettyJson(), equals(mapToString));
    });
  });

  group('Widgets extensions', () {
    const items = <Widget>[Text('a'), Text('b'), Text('c'), Text('d')];
    test('Adding separator', () {
      final result = items.joinWithSeparator(HorizontalSpacer.semi());

      expect(result.length, equals(7));
    });

    test('Adding separator on a single widget', () {
      final result = [
        const Text('a'),
      ].joinWithSeparator(HorizontalSpacer.semi());

      expect(result.length, equals(1));
    });

    test(
      'Adding space should equal same ammount of Widgets, but with padding',
      () {
        final result = items.spaced();

        expect(result.length, equals(items.length));
      },
    );

    test('Adding a Spacer widget', () {
      final result = [...items, const Spacer()].spaced();

      expect(result.length, equals(items.length + 1));
    });

    testWidgets('Finds padding when spacing the widgets', (tester) async {
      await tester.pumpApp(Column(children: items.spaced()));
      expect(find.byType(Padding), findsNWidgets(items.length));
    });
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
      final people = <String, int>{'John': 20, 'Mary': 21, 'Peter': 22};

      final subMap = people.where((key, value) => key.length > 4 && value > 20);

      expect(subMap, {'Peter': 22});
    });
    test('whereKey extension', () {
      final people = <String, int>{'John': 20, 'Mary': 21, 'Peter': 22};

      final subMap = people.whereKey((key) => key.length < 5);

      expect(subMap, {'John': 20, 'Mary': 21});
    });
    test('whereValue extension', () {
      final people = <String, int>{'John': 20, 'Mary': 21, 'Peter': 22};

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
                  onTap: () => AppSnackBar.info(message: helloSnackBar).show(context),
                  behavior: HitTestBehavior.opaque, // behaviour during the test
                  child: const SizedBox(
                    height: 100,
                    width: 100,
                    key: tapTarget,
                  ),
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
  group('Context extensions', () {
    testWidgets('theme of context', (tester) async {
      // FlutterError.onError = ignoreOverflowErrors;
      final theme = ThemeData(brightness: Brightness.light);
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: Brightness.dark),
          home: const Scaffold(),
        ),
      );

      // Capture a BuildContext object
      final BuildContext context = tester.element(find.byType(MaterialApp));

      expect(context.theme.brightness, theme.brightness);
    });
  });
}
