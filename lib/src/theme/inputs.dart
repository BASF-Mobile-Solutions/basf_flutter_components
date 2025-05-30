import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// A collection of Input values being used in the BASF themes
abstract class BasfInputThemes {
  const BasfInputThemes._();

  /// Main input theme
  static InputDecorationTheme getMainInputDecorationTheme(MaterialColor color) {
    return InputDecorationTheme(
      enabledBorder: _enabledBorder(color),
      focusedBorder: _focusedBorder(color),
      errorBorder: _errorBorder,
      focusedErrorBorder: _errorBorder,
      disabledBorder: _disabledBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      iconColor: color,
      prefixIconColor: color,
      suffixIconColor: color,
      hintStyle: BasfThemes.mainTextTheme.bodyLarge!.copyWith(
        color: BasfColors.darkGrey,
      ),
    );
  }

  /// Error input theme
  static ThemeData errorInputTheme(ThemeData theme) => theme.copyWith(
    textSelectionTheme: _errorTextSelectionTheme,
    iconTheme: const IconThemeData(color: BasfColors.red),
  );

  /// Disabled input theme
  static ThemeData disabledInputTheme(ThemeData theme) => theme.copyWith(
    iconTheme: IconThemeData(color: BasfColors.grey.shade400),
    inputDecorationTheme: theme.inputDecorationTheme.copyWith(
      hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
        color: BasfColors.middleGrey,
      ),
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

  static OutlineInputBorder _focusedBorder(MaterialColor color) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BasfThemes.defaultBorderRadius,
      );

  static OutlineInputBorder _enabledBorder(MaterialColor color) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color.shade300),
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
