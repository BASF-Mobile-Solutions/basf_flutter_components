import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// All BASF Theme types, each one holding the primary color
/// that will be used in the theme
enum BasfThemeType {
  /// BASF yellow color
  orange(BasfColors.orange),

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
  static BasfThemeType? _lastUsedThemeType;

  /// Default BASF light main theme
  static ThemeData lightMainTheme({
    BasfThemeType basfThemeType = BasfThemeType.darkBlue,
    List<String>? fontFamilyFallback,
  }) {
    _lastUsedThemeType = basfThemeType;

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      fontFamilyFallback: fontFamilyFallback,
      textTheme: mainTextTheme,
      appBarTheme: _mainAppBarTheme(basfThemeType),
      scaffoldBackgroundColor: BasfColors.white,
      snackBarTheme: _snackBarThemeData(basfThemeType),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: basfThemeType.primaryColor,
        errorColor: BasfColors.red,
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          ...ThemeData().pageTransitionsTheme.builders.whereKey(
            (key) => key != TargetPlatform.android,
          ),
          TargetPlatform.android: const FadeForwardsPageTransitionsBuilder(),
        },
      ),
      splashColor: basfThemeType.primaryColor.withValues(alpha: 0.1),
      highlightColor: basfThemeType.primaryColor.withValues(alpha: 0.2),
      iconTheme: IconThemeData(color: basfThemeType.primaryColor),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor: basfThemeType.primaryColor.shade50,
        linearTrackColor: basfThemeType.primaryColor.shade50,
      ),
      popupMenuTheme: const PopupMenuThemeData(menuPadding: EdgeInsets.zero),
      sliderTheme: SliderThemeData(
        inactiveTrackColor: basfThemeType.primaryColor.shade50,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyles.containedTextButtonStyle(
          basfThemeType.primaryColor,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyles.primaryOutlinedButtonStyle(
          basfThemeType.primaryColor,
        ),
      ),
      datePickerTheme: const DatePickerThemeData(
        shape: BeveledRectangleBorder(),
      ),
      inputDecorationTheme: BasfInputThemes.getMainInputDecorationTheme(
        basfThemeType.primaryColor,
      ),
      hintColor: basfThemeType.primaryColor.shade400,
      bottomNavigationBarTheme: _bottomNavigationBarTheme(basfThemeType),
    );
  }

  /// Get material color
  static MaterialColor getMaterialColor() {
    return switch (_lastUsedThemeType) {
      BasfThemeType.orange => BasfColors.orange,
      BasfThemeType.red => BasfColors.red,
      BasfThemeType.lightGreen => BasfColors.lightGreen,
      BasfThemeType.darkGreen => BasfColors.darkGreen,
      BasfThemeType.lightBlue => BasfColors.lightBlue,
      BasfThemeType.darkBlue => BasfColors.darkBlue,
      _ => BasfColors.darkBlue,
    };
  }

  /// primary pale color
  static Color primaryPaleBackgroundColor() {
    return switch (_lastUsedThemeType) {
      BasfThemeType.orange => BasfColors.orangePale,
      BasfThemeType.darkGreen => BasfColors.darkGreenPale,
      _ => BasfColors.darkBluePale,
    };
  }

  /// BASF Main text theme
  static TextTheme get mainTextTheme {
    return const TextTheme(
      displayLarge: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 42),
      displayMedium: CustomTextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 42,
      ),
      displaySmall: CustomTextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 32,
      ),
      headlineMedium: CustomTextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      headlineSmall: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      titleLarge: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      bodyLarge: CustomTextStyle(fontWeight: FontWeight.normal, fontSize: 16),
      bodyMedium: CustomTextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      titleMedium: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      titleSmall: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      bodySmall: CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      labelLarge: CustomTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      labelSmall: CustomTextStyle(fontWeight: FontWeight.normal, fontSize: 12),
    );
  }

  static AppBarTheme _mainAppBarTheme(BasfThemeType theme) {
    return AppBarTheme(
      backgroundColor: theme.primaryColor,
      titleTextStyle: mainTextTheme.titleMedium!.copyWith(
        color: BasfColors.white,
      ),
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
      shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      contentTextStyle: mainTextTheme.titleMedium!.copyWith(
        color: BasfColors.white,
      ),
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
      unselectedLabelStyle: mainTextTheme.labelSmall,
      selectedLabelStyle: mainTextTheme.labelSmall!.copyWith(
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
          foregroundColor: theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BasfThemes.defaultBorderRadius,
          ),
        ),
      ),
    );
  }
}
