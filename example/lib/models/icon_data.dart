import 'package:flutter/material.dart';

/// Uses to generate IconData for BasfIcons
class BasfIconsData extends IconData {
  const BasfIconsData(int code)
      : super(
          code,
          fontFamily: 'BasfIcons',
          fontPackage: 'basf_flutter_components',
        );
}
