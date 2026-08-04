import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

const _errorMessage = 'Wrong input';
const _label = 'Delivery';

String? _notEmpty(String? value) => (value ?? '').isEmpty ? _errorMessage : null;

/// Mandatory fields validate to an empty string, which shows the error state
/// without an error message
String? _mandatory(String? value) => (value ?? '').isEmpty ? '' : null;

void main() {
  group('BasfTextField validation display', () {
    Future<void> pumpField(
      WidgetTester tester, {
      AutovalidateMode? autovalidateMode,
      String? Function(String?)? validator = _notEmpty,
      FocusNode? focusNode,
      TextEditingController? controller,
    }) async {
      await tester.pumpApp(
        Scaffold(
          body: BasfTextField(
            labelText: _label,
            controller: controller ?? TextEditingController(),
            focusNode: focusNode,
            validator: validator,
            autovalidateMode: autovalidateMode,
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    InputDecoration decorationOf(WidgetTester tester) {
      return tester.widget<TextField>(find.byType(TextField)).decoration!;
    }

    testWidgets('shows the error right away when the mode is not set', (tester) async {
      // BasfTextField.fromTextFieldData forwards a null mode for every
      // TextFieldData that does not set one, so null must keep validating
      await pumpField(tester);

      expect(find.text(_errorMessage), findsOneWidget);
    });

    testWidgets('shows the error right away on always', (tester) async {
      await pumpField(tester, autovalidateMode: AutovalidateMode.always);

      expect(find.text(_errorMessage), findsOneWidget);
    });

    testWidgets('never shows the error on disabled', (tester) async {
      await pumpField(tester, autovalidateMode: AutovalidateMode.disabled);

      expect(find.text(_errorMessage), findsNothing);

      await tester.enterText(find.byType(TextField), 'a');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '');
      await tester.pumpAndSettle();

      expect(find.text(_errorMessage), findsNothing);
    });

    testWidgets('shows the error only after input on onUserInteraction', (tester) async {
      await pumpField(tester, autovalidateMode: AutovalidateMode.onUserInteraction);

      expect(find.text(_errorMessage), findsNothing);

      await tester.enterText(find.byType(TextField), '1');
      await tester.pumpAndSettle();

      expect(find.text(_errorMessage), findsNothing);

      await tester.enterText(find.byType(TextField), '');
      await tester.pumpAndSettle();

      expect(find.text(_errorMessage), findsOneWidget);
    });

    testWidgets('shows the error only after losing focus on onUnfocus', (tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await pumpField(
        tester,
        autovalidateMode: AutovalidateMode.onUnfocus,
        focusNode: focusNode,
      );

      expect(find.text(_errorMessage), findsNothing);

      focusNode.requestFocus();
      await tester.pumpAndSettle();

      expect(find.text(_errorMessage), findsNothing);

      focusNode.unfocus();
      await tester.pumpAndSettle();

      expect(find.text(_errorMessage), findsOneWidget);
    });

    testWidgets('detects unfocus without an external focus node', (tester) async {
      await pumpField(tester, autovalidateMode: AutovalidateMode.onUnfocus);

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.text(_errorMessage), findsNothing);

      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();

      expect(find.text(_errorMessage), findsOneWidget);
    });

    testWidgets('keeps the messageless error state of mandatory fields', (tester) async {
      await pumpField(tester, validator: _mandatory);

      expect(decorationOf(tester).error, isNotNull);
      expect(decorationOf(tester).errorText, isNull);

      await tester.enterText(find.byType(TextField), '1');
      await tester.pumpAndSettle();

      expect(decorationOf(tester).error, isNull);
    });

    testWidgets('gates the mandatory error state by the mode as well', (tester) async {
      await pumpField(
        tester,
        validator: _mandatory,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

      expect(decorationOf(tester).error, isNull);

      await tester.enterText(find.byType(TextField), '1');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '');
      await tester.pumpAndSettle();

      expect(decorationOf(tester).error, isNotNull);
    });

    testWidgets('shows no error state without a validator', (tester) async {
      await pumpField(tester, validator: null);

      expect(decorationOf(tester).error, isNull);
      expect(decorationOf(tester).errorText, isNull);
      expect(find.text(_errorMessage), findsNothing);
    });
  });
}
