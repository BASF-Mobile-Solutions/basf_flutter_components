import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// A collection of Input values being used in the BASF themes
abstract class BasfInputThemes {
  const BasfInputThemes._();

  /// Focused border color
  static const MaterialColor focusedBorderColor = BasfColors.grey;

  /// Main input theme
  static InputDecorationTheme get mainInputDecorationTheme {
    return InputDecorationTheme(
      enabledBorder: _enabledBorder,
      focusedBorder: _focusedBorder,
      errorBorder: _errorBorder,
      focusedErrorBorder: _errorBorder,
      disabledBorder: _disabledBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      iconColor: focusedBorderColor,
      prefixIconColor: focusedBorderColor,
      suffixIconColor: focusedBorderColor,
      hintStyle: BasfThemes.mainTextTheme.subtitle1!
          .copyWith(color: focusedBorderColor.shade400),
    );
  }

  /// Error input theme
  static ThemeData errorInputTheme(ThemeData theme) => theme.copyWith(
        textSelectionTheme: _errorTextSelectionTheme,
        iconTheme: const IconThemeData(color: BasfColors.red),
        hintColor: BasfColors.red.shade400,
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          hintStyle: theme.inputDecorationTheme.hintStyle
              ?.copyWith(color: BasfColors.red.shade400),
        ),
      );

  /// Disabled input theme
  static ThemeData disabledInputTheme(ThemeData theme) => theme.copyWith(
        iconTheme: IconThemeData(color: BasfColors.grey.shade400),
        hintColor: BasfColors.grey.shade400,
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          hintStyle: theme.inputDecorationTheme.hintStyle
              ?.copyWith(color: BasfColors.grey.shade400),
          fillColor: BasfColors.grey.shade100,
          filled: true,
        ),
      );

  static final TextSelectionThemeData _errorTextSelectionTheme =
      TextSelectionThemeData(
    cursorColor: BasfColors.red,
    selectionHandleColor: BasfColors.red,
    selectionColor: BasfColors.red.shade200,
  );

  static final OutlineInputBorder _focusedBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: focusedBorderColor),
    borderRadius: BasfThemes.defaultBorderRadius,
  );

  static final OutlineInputBorder _enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: focusedBorderColor.shade300),
    borderRadius: BasfThemes.defaultBorderRadius,
  );

  static final OutlineInputBorder _disabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: BasfColors.grey.shade300),
    borderRadius: BasfThemes.defaultBorderRadius,
  );

  static final OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: BasfColors.red),
    borderRadius: BasfThemes.defaultBorderRadius,
  );
}
