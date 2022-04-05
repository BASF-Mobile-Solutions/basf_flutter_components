import 'package:flutter/cupertino.dart';

import 'colors.dart';

class BasfShadows {
  static const BoxShadow lightShadow = BoxShadow(
    color: BasfColors.shadowColor,
    blurRadius: 20,
    offset: Offset(0, 4),
  );

  static const BoxShadow smallShadow = BoxShadow(
    color: BasfColors.greyBlue,
    blurRadius: 20,
    offset: Offset(0, 4),
  );
}
