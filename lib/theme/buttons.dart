import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class ButtonThemes {
  static const double buttonHeight = 48;

  static ButtonStyle primaryTextButtonTheme() => TextButton.styleFrom(
    primary: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    minimumSize: const Size(0, buttonHeight),
    maximumSize: const Size(double.infinity, buttonHeight),
    side: BorderSide.none,
  ).copyWith(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return BasfColors.grey;
        } else {
          return BasfColors.darkBlue;
        }
      }),
      textStyle: MaterialStateProperty.all(BasfThemes.mainTextTheme.button),
      foregroundColor: MaterialStateProperty.all(BasfColors.white)
  );

  static ButtonStyle primaryOutlinedButtonTheme() => OutlinedButton.styleFrom(
    primary: BasfColors.darkBlue,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    minimumSize: const Size(0, buttonHeight),
    maximumSize: const Size(double.infinity, buttonHeight),
  ).copyWith(
      side: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        } else {
          return const BorderSide(color: BasfColors.darkBlue);
        }
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return BasfColors.grey;
        } else {
          return BasfColors.white;
        }
      }),
      textStyle: MaterialStateProperty.all(BasfThemes.mainTextTheme.button),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return BasfColors.grey.shade700;
        } else {
          return BasfColors.darkBlue;
        }
      })
  );
}