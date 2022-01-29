import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'text_styles.dart';

class BasfThemes {

  static ThemeData lightThemeDarkBlue() {
    return ThemeData(
      fontFamily: 'Roboto',
      textTheme: _mainTextTheme,
      appBarTheme: _mainAppBarTheme,
      scaffoldBackgroundColor: BasfColors.white,
      snackBarTheme: _snackBarThemeData,
      splashColor: BasfColors.darkBlue.withOpacity(0.05),
      highlightColor: BasfColors.darkBlue.withOpacity(0.04),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: BasfColors.darkBlue,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(BasfColors.darkBlue),
      ),
      textSelectionTheme: _enabledTextSelectionTheme,
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: BasfColors.darkBlue,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: BasfColors.darkBlue,
        secondary: BasfColors.lightBlue,
      ),
      iconTheme: const IconThemeData(color: BasfColors.darkBlue),
      // inputDecorationTheme: _inputDecorationTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
    );
  }

  static const TextTheme _mainTextTheme = TextTheme(
    headline1: CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 60),
    headline2: CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 44),
    headline3: CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 32),
    headline4: CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 24),
    headline5: CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 20),
    headline6: CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    bodyText1: CustomTextStyle(fontSize: 16),
    bodyText2: CustomTextStyle(fontSize: 16, lineHeight: 1.5),
    subtitle1: CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    subtitle2: CustomTextStyle(fontWeight: FontWeight.normal, fontSize: 14),
    caption: CustomTextStyle(fontWeight: FontWeight.normal, fontSize: 12),
    button: CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    overline: CustomTextStyle(fontSize: 10.0, lineHeight: 1),
  );

  static final AppBarTheme _mainAppBarTheme = AppBarTheme(
    backgroundColor: BasfColors.darkBlue,
    titleTextStyle: _mainTextTheme.subtitle1!.copyWith(color: BasfColors.white),
    iconTheme: const IconThemeData(color: BasfColors.white),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0,
  );

  static final SnackBarThemeData _snackBarThemeData = SnackBarThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    contentTextStyle: _mainTextTheme.subtitle1!.copyWith(color: BasfColors.white),
  );

  static final TextSelectionThemeData _enabledTextSelectionTheme = TextSelectionThemeData(
    cursorColor: BasfColors.darkBlue,
    selectionHandleColor: BasfColors.darkBlue,
    selectionColor: BasfColors.darkBlue.shade200,
  );

  static final BottomNavigationBarThemeData _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: BasfColors.white,
    selectedItemColor: BasfColors.darkBlue,
    unselectedItemColor: BasfColors.darkBlue,
    selectedIconTheme: const IconThemeData(color: BasfColors.darkBlue, size: 20),
    unselectedIconTheme: const IconThemeData(color: BasfColors.darkBlue, size: 20),
    unselectedLabelStyle: _mainTextTheme.overline,
    selectedLabelStyle: _mainTextTheme.overline!.copyWith(
      fontWeight: FontWeight.w500,
      color: BasfColors.darkBlue,
    ),
  );
}