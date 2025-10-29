import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// SystemTheme for BASF apps
class SystemThemes {
  /// Dark Overlay sytle
  static SystemUiOverlayStyle defaultSystemOverlayStyleDark({
    required ThemeData theme,
    bool whiteNavigationBar = true,
  }) {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ).copyWith(
      systemNavigationBarColor: whiteNavigationBar
          ? Colors.white
          : theme.primaryColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: whiteNavigationBar
          ? Brightness.dark
          : Brightness.light,
    );
  }

  /// Light Overlay sytle
  static SystemUiOverlayStyle defaultSystemOverlayStyleLight({
    required ThemeData theme,
    bool whiteNavigationBar = false,
  }) =>
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // For Android (light icons)
        statusBarBrightness: Brightness.dark, // For iOS (light icons)
      ).copyWith(
        systemNavigationBarColor: whiteNavigationBar
            ? Colors.white
            : theme.primaryColor,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: whiteNavigationBar
            ? Brightness.dark
            : Brightness.light,
      );

  /// Set portrait mode for the app
  static void setSystemOrientations() {
    unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    );
  }
}
