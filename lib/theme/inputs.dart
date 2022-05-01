import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class BasfInputThemes {
  static MaterialColor focusedBorderColor = BasfColors.grey;
  static const double _borderWidth = 1;

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

  static ThemeData get errorInputTheme => BasfThemes.lightMainTheme.copyWith(
        textSelectionTheme: _errorTextSelectionTheme,
        iconTheme: const IconThemeData(color: BasfColors.red),
        hintColor: BasfColors.red.shade400,
        inputDecorationTheme:
            BasfThemes.lightMainTheme.inputDecorationTheme.copyWith(
          hintStyle: BasfThemes.lightMainTheme.inputDecorationTheme.hintStyle
              ?.copyWith(
            color: BasfColors.red.shade400,
          ),
        ),
      );

  static ThemeData get disabledInputTheme => BasfThemes.lightMainTheme.copyWith(
        iconTheme: IconThemeData(color: BasfColors.grey.shade400),
        hintColor: BasfColors.grey.shade400,
        inputDecorationTheme:
            BasfThemes.lightMainTheme.inputDecorationTheme.copyWith(
          hintStyle: BasfThemes.lightMainTheme.inputDecorationTheme.hintStyle
              ?.copyWith(
            color: BasfColors.grey.shade400,
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

  static final OutlineInputBorder _focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(
        color: focusedBorderColor,
        width: _borderWidth,
    ),
    borderRadius: BasfThemes.defaultBorderRadius,
  );

  static final OutlineInputBorder _enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(
        color: focusedBorderColor.shade300,
        width: _borderWidth,
    ),
    borderRadius: BasfThemes.defaultBorderRadius,
  );

  static final OutlineInputBorder _disabledBorder = OutlineInputBorder(
    borderSide: BorderSide(
        color: BasfColors.grey.shade300,
        width: _borderWidth,
    ),
    borderRadius: BasfThemes.defaultBorderRadius,
  );

  static final OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderSide: const BorderSide(
        color: BasfColors.red,
        width: _borderWidth,
    ),
    borderRadius: BasfThemes.defaultBorderRadius,
  );
}
