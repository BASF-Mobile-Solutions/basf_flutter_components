import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

const double _buttonHeight = 48;
const EdgeInsetsGeometry _padding = EdgeInsets.all(15);
const Size _minimumSize = Size(0, _buttonHeight);

/// BASF button styles
abstract class ButtonStyles {
  /// Contained text button style
  static ButtonStyle containedTextButtonStyle(Color primaryColor) =>
      _TextButtonStyles().containedTextButtonStyle(primaryColor);

  /// Transparent text button style
  static ButtonStyle transparentTextButtonStyle(Color primaryColor) =>
      _TextButtonStyles().transparentTextButtonStyle(primaryColor);

  /// Hint text button style
  static ButtonStyle hintTextButtonStyle(Color primaryColor) =>
      _TextButtonStyles().hintTextButtonStyle(primaryColor);

  /// Primary outlined  text button style∫
  static ButtonStyle primaryOutlinedButtonStyle(Color primaryColor) =>
      _OutlinedButtonStyles().primaryOutlinedButtonStyle(primaryColor);
}

class _TextButtonStyles extends ButtonStyles {
  ButtonStyle containedTextButtonStyle(Color primaryColor) =>
      TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: _padding,
        minimumSize: _minimumSize,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BasfThemes.defaultBorderRadius,
        ),
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BasfColors.grey;
          } else {
            return primaryColor;
          }
        }),
        foregroundColor: WidgetStateProperty.all(BasfColors.white),
      );

  ButtonStyle transparentTextButtonStyle(Color foregroundColor) {
    return TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      backgroundColor: BasfColors.transparent,
      foregroundColor: foregroundColor,
      minimumSize: Size.zero,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BasfThemes.defaultBorderRadius,
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textStyle: BasfThemes.mainTextTheme.bodySmall,
    ).copyWith(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.disabled)
            ? BasfColors.grey
            : foregroundColor;
      }),
    );
  }

  ButtonStyle hintTextButtonStyle(Color primaryColor) {
    return transparentTextButtonStyle(primaryColor).copyWith(
      textStyle: WidgetStateProperty.all(BasfThemes.mainTextTheme.titleSmall),
      padding: WidgetStateProperty.all(const EdgeInsets.all(5)),
      foregroundColor: WidgetStateProperty.all(BasfColors.grey),
      overlayColor: WidgetStateProperty.all(BasfColors.grey.shade100),
    );
  }
}

class _OutlinedButtonStyles extends ButtonStyles {
  ButtonStyle primaryOutlinedButtonStyle(Color primaryColor) =>
      OutlinedButton.styleFrom(
        padding: _padding,
        minimumSize: _minimumSize,
        shape: RoundedRectangleBorder(
          borderRadius: BasfThemes.defaultBorderRadius,
        ),
      ).copyWith(
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          } else {
            return BorderSide(color: primaryColor);
          }
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BasfColors.grey;
          } else {
            return BasfColors.transparent;
          }
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BasfColors.white;
          } else {
            return primaryColor;
          }
        }),
      );
}
