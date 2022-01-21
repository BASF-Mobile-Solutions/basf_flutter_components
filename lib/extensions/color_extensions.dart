import 'package:flutter/material.dart';

/// takes a Hex String and converts to a [Color]
/// 
/// Example:
/// ```dart
/// HexColor.fromHex('#ffffff');
/// ```
extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

/// darkens a [Color] with a range from 0.0 to 1.0
///
/// Example:
/// ```dart
/// Color myColor = darken(Colors.red, 0.2);
/// ```
///
/// See also:
///
///  * [lighten]
Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

/// lightens a [Color] with a range from 0.0 to 1.0
///
/// Example:
/// ```dart
/// Color myColor = lighten(Colors.red, 0.2);
/// ```
/// 
/// See also:
///
///  * [darken]
Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
