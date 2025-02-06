import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// A list of shadows being used in the BASF widgets
class BasfShadows {
  /// A simple light BoxShadow
  static const BoxShadow lightShadow = BoxShadow(
    color: BasfColors.shadowColor,
    blurRadius: 20,
    offset: Offset(0, 4),
  );

  /// A small BoxShadow
  static const BoxShadow smallShadow = BoxShadow(
    color: BasfColors.greyBlue,
    blurRadius: 20,
    offset: Offset(0, 4),
  );
}
