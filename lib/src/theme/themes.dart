import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// All BASF Theme types, each one holding the primary color
/// that will be used in the theme
enum BasfThemeType {
  /// BASF yellow color
  yellow(BasfColors.orange),

  /// BASF red color
  red(BasfColors.red),

  /// BASF lightGreen color
  lightGreen(BasfColors.lightGreen),

  /// BASF darkGreen color
  darkGreen(BasfColors.darkGreen),

  /// BASF lightBlue color
  lightBlue(BasfColors.lightBlue),

  /// BASF darkBlue color
  darkBlue(BasfColors.darkBlue);

  /// BASF theme type
  const BasfThemeType(this.primaryColor);

  /// BASF theme primary color
  final MaterialColor primaryColor;
}

/// Core of BASF Themes
class BasfThemes {
  /// Default BASF border Radius
  static BorderRadius defaultBorderRadius = BorderRadius.zero;

  /// Default BASF light main theme
  static ThemeData lightMainTheme(BasfThemeType? basfThemeType) {
    final theme = basfThemeType ?? BasfThemeType.darkBlue;

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      textTheme: mainTextTheme,
      appBarTheme: _mainAppBarTheme(theme),
      scaffoldBackgroundColor: BasfColors.white,
      snackBarTheme: _snackBarThemeData(theme),
      colorSchemeSeed: theme.primaryColor,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyles.containedTextButtonStyle(theme.primaryColor),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyles.primaryOutlinedButtonStyle(theme.primaryColor),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      ),
      inputDecorationTheme: BasfInputThemes.getMainInputDecorationTheme(
          theme.primaryColor,
      ),
      hintColor: theme.primaryColor.shade400,
      bottomNavigationBarTheme: _bottomNavigationBarTheme(theme),
    );
  }

  /// BASF Main text theme
  static TextTheme get mainTextTheme {
    return const TextTheme(
      headline1: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 42),
      headline2: CustomTextStyle(fontWeight: FontWeight.normal, fontSize: 42),
      headline3: CustomTextStyle(fontWeight: FontWeight.normal, fontSize: 32),
      headline4: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      headline5: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      headline6: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      bodyText1: CustomTextStyle(fontWeight: FontWeight.normal, fontSize: 16),
      bodyText2: CustomTextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      subtitle1: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      subtitle2: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      caption: CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      button: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      overline: CustomTextStyle(fontWeight: FontWeight.normal, fontSize: 12),
    );
  }

  static AppBarTheme _mainAppBarTheme(BasfThemeType theme) {
    return AppBarTheme(
      backgroundColor: theme.primaryColor,
      titleTextStyle:
          mainTextTheme.subtitle1!.copyWith(color: BasfColors.white),
      iconTheme: const IconThemeData(color: BasfColors.white),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      scrolledUnderElevation: 0,
      elevation: 0,
    );
  }

  static SnackBarThemeData _snackBarThemeData(BasfThemeType theme) {
    return SnackBarThemeData(
      backgroundColor: theme.primaryColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: defaultBorderRadius,
      ),
      contentTextStyle:
          mainTextTheme.subtitle1!.copyWith(color: BasfColors.white),
    );
  }

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
    BasfThemeType theme,
  ) {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: BasfColors.white,
      selectedItemColor: theme.primaryColor,
      unselectedItemColor: theme.primaryColor,
      selectedIconTheme: IconThemeData(color: theme.primaryColor, size: 20),
      unselectedIconTheme: IconThemeData(color: theme.primaryColor, size: 20),
      unselectedLabelStyle: mainTextTheme.overline,
      selectedLabelStyle: mainTextTheme.overline!.copyWith(
        fontWeight: FontWeight.w500,
        color: theme.primaryColor,
      ),
    );
  }

  /// BASF date picker button theme
  static ThemeData datePickerButtonTheme(ThemeData theme) {
    return theme.copyWith(
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BasfThemes.defaultBorderRadius,
          ),
        ),
      ),
    );
  }
}
