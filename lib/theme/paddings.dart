import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';

class Paddings {
  static EdgeInsetsGeometry get defaultScreenPadding =>
      const EdgeInsets.fromLTRB(
        Dimens.paddingMediumLarge,
        Dimens.paddingMediumLarge,
        Dimens.paddingMediumLarge,
        Dimens.paddingMediumSmall,
      );
}
