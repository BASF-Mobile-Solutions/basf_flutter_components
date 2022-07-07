import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/cupertino.dart';

/// A collection of BASF Text Styles
abstract class BasfTextStyles {
  const BasfTextStyles._();

  // InputField
  // InputField - The Label on the top of the InputField

  // InputField - Label Appearance
  static const TextStyle _defaultFieldLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  // InputField - Text Appearance
  static const TextStyle _defaultFieldText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  /// InputField - Label (Top)
  static final TextStyle inputFieldLabel = _defaultFieldLabel.copyWith(
    color: BasfColors.copyTextGrey,
  );

  /// InputField - Hint - Default
  static final TextStyle inputFieldHint = _defaultFieldText.copyWith(
    color: BasfColors.darkBlue[400],
  );

  /// InputField - Hint - Error
  static final TextStyle inputFieldHintError = _defaultFieldText.copyWith(
    color: BasfColors.red[300],
  );

  /// InputField - Hint - Focus
  static final TextStyle inputFieldHintFocus = _defaultFieldText.copyWith(
    color: BasfColors.darkBlue[500],
  );

  /// InputField - Hint - Disabled
  /// InputField - Text Input - Disabled
  static final TextStyle inputFieldDisabled = _defaultFieldText.copyWith(
    color: BasfColors.darkGrey,
  );

  /// InputField - Text Input - Default
  static final TextStyle inputFieldInput = _defaultFieldText.copyWith(
    color: BasfColors.copyTextGrey,
  );

  /// InputField - Text Input - Error
  static final TextStyle inputFieldError = _defaultFieldText.copyWith(
    color: BasfColors.red,
  );

  /// InputField - Error Label (Bottom)
  static final TextStyle inputFieldErrorLabel = _defaultFieldLabel.copyWith(
    color: BasfColors.red,
  );

  // Buttons

  /// Contained Button - Default
  static const TextStyle containedButton = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: BasfColors.white,
  );

  /// Contained Button - Disabled Negative
  static const TextStyle containedButtonDisabledNegative = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: BasfColors.copyTextGrey,
  );

  /// Footer
  static const TextStyle footer = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: BasfColors.darkGrey,
  );

  /// Version
  static const TextStyle version = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: BasfColors.darkGrey,
  );

  /// Alert Dialog
  static const alertDialogTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  /// Alert Dialog Body
  static const alertDialogBody = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );

  /// Alert Dialog Dismiss
  static const alertDialogDismiss = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: BasfColors.red,
  );

  /// Alert Dialog Confirm
  static const alertDialogConfirm = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: BasfColors.darkBlue,
  );
}

/// Custom text style used at BASF Themes
class CustomTextStyle extends TextStyle {
  /// Custom text style used at BASF Themes
  const CustomTextStyle({
    Color super.color = BasfColors.copyTextGrey,
    super.fontSize,
    super.fontFamily,
    super.fontWeight,
    double? lineHeight,
    super.letterSpacing,
  }) : super(height: lineHeight);
}
