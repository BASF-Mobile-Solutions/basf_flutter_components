import 'package:flutter/services.dart';

/// Extension InputFormatter to be used in TextFields
abstract class InputFormatter {
  /// InputFormatter to convert all characters to uppercase
  static List<TextInputFormatter> get upperCase => [_UpperCaseTextFormatter()];

  /// InputFormatter to only allow digits
  static List<TextInputFormatter> get onlyDigits {
    return [FilteringTextInputFormatter.allow(RegExp('[0-9]'))];
  }
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: TextSelection.fromPosition(
        TextPosition(offset: newValue.selection.baseOffset),
      ),
    );
  }
}
