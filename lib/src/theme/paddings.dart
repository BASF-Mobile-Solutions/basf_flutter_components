import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// BASF custom Paddings
abstract class Paddings {
  /// Default screen padding used at BASF screens
  ///
  /// Example:
  /// ```dart
  /// Padding(
  ///   padding: Paddings.defaultScreenPadding,
  ///   child: MyScreen(),
  /// );
  /// ```
  static EdgeInsetsGeometry get defaultScreenPadding =>
      const EdgeInsets.fromLTRB(
        Dimens.paddingMediumLarge,
        Dimens.paddingMediumLarge,
        Dimens.paddingMediumLarge,
        Dimens.paddingMediumSmall,
      );
}
