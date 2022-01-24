import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/cupertino.dart';

class BasfTextStyles {
  const BasfTextStyles._();

  ///InputField
  ///---------------------------------------------------------------------------
  ///InputField - The Label on the top of the InputField

  ///InputField - Label Appearance
  static const TextStyle _defaultFieldLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  ///InputField - Text Appearance
  static const TextStyle _defaultFieldText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  ///InputField - Label (Top)
  static TextStyle inputFieldLabel = _defaultFieldLabel.copyWith(
    color: BasfColors.copyTextGrey,
  );

  ///InputField - Hint - Default
  static TextStyle inputFieldHint = _defaultFieldText.copyWith(
    color: BasfColors.darkBlue[400]!,
  );

  ///InputField - Hint - Error
  static TextStyle inputFieldHintError = _defaultFieldText.copyWith(
    color: BasfColors.red[300]!,
  );

  ///InputField - Hint - Focus
  static TextStyle inputFieldHintFocus = _defaultFieldText.copyWith(
    color: BasfColors.darkBlue[500]!,
  );

  ///InputField - Hint - Disabled
  ///InputField - Text Input - Disabled
  static TextStyle inputFieldDisabled = _defaultFieldText.copyWith(
    color: BasfColors.darkGrey,
  );

  ///InputField - Text Input - Default
  static TextStyle inputFieldInput = _defaultFieldText.copyWith(
    color: BasfColors.copyTextGrey,
  );

  ///InputField - Text Input - Error
  static TextStyle inputFieldError = _defaultFieldText.copyWith(
    color: BasfColors.red,
  );

  ///InputField - Error Label (Bottom)
  static TextStyle inputFieldErrorLabel = _defaultFieldLabel.copyWith(
    color: BasfColors.red,
  );

  ///End of InputField
  ///---------------------------------------------------------------------------

  ///Buttons
  ///---------------------------------------------------------------------------
  ///Contained Button - Default
  static const TextStyle containedButton = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: BasfColors.white,
  );

  ///Contained Button - Disabled Negative
  static const TextStyle containedButtonDisabledNegative = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: BasfColors.copyTextGrey,
  );

  ///End of ContainedButton
  ///---------------------------------------------------------------------------

  ///Footer
  static const TextStyle footer = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: BasfColors.darkGrey,
  );

  ///Version
  static const TextStyle version = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: BasfColors.darkGrey,
  );

  ///Alert Dialog
  ///---------------------------------------------------------------------------
  static const alertDialogTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const alertDialogBody = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );

  static const alertDialogDismiss = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: BasfColors.red,
  );

  static const alertDialogConfirm = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: BasfColors.darkBlue,
  );

  ///End Alert Dialog
  ///---------------------------------------------------------------------------
}
