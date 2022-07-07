import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('Text Fields', () {
    testWidgets(
      'Basf TextField',
      (tester) async {
        const text = 'Hello World';
        final controller = TextEditingController(text: text);
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return BasfTextField(
                  controller: controller,
                  decoration: const InputDecoration(labelText: 'Label'),
                );
              },
            ),
          ),
        );
        await tester.tap(
          find.byType(TextField),
          warnIfMissed: false, // Added to remove unnecesary warning
        );
        expect(find.byType(TextField), findsOneWidget);
        await tester.enterText(find.byType(TextField), text);
        await tester.pumpAndSettle();
        // finds the text inputed
        expect(find.text(text), findsOneWidget);
      },
    );

    testWidgets(
      'Basf TextFormField',
      (tester) async {
        const text = 'Hello World';
        final controller = TextEditingController(text: text);
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return BasfTextField(
                  enabled: true,
                  controller: controller,
                  decoration: const InputDecoration(labelText: 'Label'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                );
              },
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
      },
    );
    testWidgets(
      'Basf TextFormField not enabled and with inputdecoration',
      (tester) async {
        const text = 'Hello World';
        final controller = TextEditingController(text: text);
        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                return BasfTextField(
                  enabled: false,
                  controller: controller,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.dangerous),
                    isCollapsed: true,
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                );
              },
            ),
          ),
        );
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byType(Icon), findsOneWidget);
      },
    );
    testWidgets(
      // ! add the error theme
      'Basf TextFormField key',
      (tester) async {
        final controller = TextEditingController();
        final key = GlobalKey<FormState>();

        await tester.pumpApp(
          Scaffold(
            body: Builder(
              builder: (context) {
                key.currentState?.validate();
                return BasfTextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.red),
                  formKey: key,

                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  // validator: (_) => 'false',
                );
              },
            ),
          ),
        );
        expect(find.byType(TextField), findsOneWidget);
      },
    );
  });
}
