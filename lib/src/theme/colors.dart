import 'package:flutter/material.dart';

/// This class contains every official BASF Color and their swatches.
///
/// (The structure is inspired by Material's Colors class)
///
/// (1) The [50] value of the MaterialColors is set additionally
/// to the next darker one.
/// This prevents null pointer errors if you use these MaterialColors in themes.
abstract class BasfColors {
  BasfColors._();

  // BASF - Default Colors
  /// Transparent color
  static const Color transparent = Color(0x00000000);

  /// White color
  static const Color white = Color(0xFFFFFFFF);

  /// Black color
  static const Color black = Color(0xFF000000);

  // BASF - Grey Swatches
  /// Box grey color
  static const Color boxGrey = Color(0xFFF0F0F0);

  /// Box light grey color
  static const Color boxLightGrey = Color(0xFFFBFBFB);

  /// Background grey color
  static const Color backgroundGrey = Color(0xFFF7F9FC);

  /// Light grey color
  static const Color lightGrey = Color(0xFFDDDDDD);

  /// Middle grey color
  static const Color middleGrey = Color(0xFFADADAD);

  /// Dark grey color
  static const Color darkGrey = Color(0xFF7E7E7E);

  /// CopyText grey color
  static const Color copyTextGrey = Color(0xFF373737);

  /// Shadow color
  static const Color shadowColor = Color(0x1F25503B);

  // BASF - additional blue colors
  /// Blue grey color
  static const Color greyBlue = Color(0xFFE5EDF4);

  /// Grey MaterialColor
  static const MaterialColor grey = MaterialColor(
    0xFF9E9E9E,
    <int, Color>{
      50: boxGrey,
      75: boxGrey,
      100: Color(0xFFECECEC),
      175: lightGrey,
      200: Color(0xFFD8D8D8),
      300: Color(0xFFC5C5C5),
      400: Color(0xFFB1B1B1),
      425: middleGrey,
      500: Color(0xFF9E9E9E),
      600: darkGrey,
      700: Color(0xFF5F5F5F),
      800: Color(0xFF3F3F3F),
      825: copyTextGrey,
      900: Color(0xFF202020),
    },
  );

  // BASF - Light Blue Swatches
  /// Light blue pale color
  static const Color lightBluePale = Color(0xFFDEF1F8);

  /// Background blue color
  static const Color backgroundBlue = Color(0xFFF2F6FA);

  /// Light blue color
  static const MaterialColor lightBlue = MaterialColor(
    0xFF21A0D2,
    <int, Color>{
      50: lightBluePale,
      75: lightBluePale,
      100: Color(0xFFD3ECF6),
      200: Color(0xFFA6D9ED),
      300: Color(0xFF7AC6E4),
      375: Color(0xFF59B8DE),
      400: Color(0xFF4DB3DB),
      500: Color(0xFF21A0D2),
      600: Color(0xFF1A80A8),
      700: Color(0xFF14607E),
      800: Color(0xFF0D4054),
      900: Color(0xFF000F1E),
    },
  );

  // BASF - Dark Blue Swatches
  /// Dark blue color
  static const Color darkBluePale = Color(0xFFD9E4EF);

  /// Dark blue MaterialColor
  static const MaterialColor darkBlue = MaterialColor(
    0xFF004A96,
    <int, Color>{
      50: darkBluePale, //(1)
      75: darkBluePale,
      100: Color(0xFFCCDBEA),
      200: Color(0xFF99B7D5),
      300: Color(0xFF6692C0),
      375: Color(0xFF336EAB),
      400: Color(0xFF2665A6),
      500: Color(0xFF004A96),
      600: Color(0xFF003B78),
      700: Color(0xFF002C5A),
      800: Color(0xFF001E3C),
      900: Color(0xFF000F1E),
    },
  );

  // BASF - Light Green Swatches
  /// Light green color
  static const Color lightGreenPale = Color(0xFFE0EED2);

  /// Light green MaterialColor
  static const MaterialColor lightGreen = MaterialColor(
    0xFF65AC1E,
    <int, Color>{
      50: lightGreenPale,
      100: lightGreenPale,
      200: Color(0xFFC1DEA5),
      300: Color(0xFFA3CD78),
      375: Color(0xFF8CC156),
      400: Color(0xFF84BD4B),
      500: Color(0xFF65AC1E),
      600: Color(0xFF518A18),
      700: Color(0xFF3D6712),
      800: Color(0xFF28450C),
      900: Color(0xFF142206),
    },
  );

  // BASF - Dark Green Swatches
  /// Dark green color
  static const Color darkGreenPale = Color(0xFFD9EBE1);

  /// Dark green MaterialColor
  static const MaterialColor darkGreen = MaterialColor(
    0xFF00793A,
    <int, Color>{
      50: darkGreenPale,
      75: darkGreenPale,
      100: Color(0xFFCCE4D8),
      200: Color(0xFF99C9B0),
      300: Color(0xFF66AF89),
      375: Color(0xFF66AF89),
      400: Color(0xFF339461),
      500: Color(0xFF00793A),
      600: Color(0xFF00612E),
      700: Color(0xFF004923),
      800: Color(0xFF003017),
      900: Color(0xFF00180C),
    },
  );

  // BASF - Orange Swatches
  /// Orange color
  static const Color orangePale = Color(0xFFFDEFD9);

  /// Orange MaterialColor
  static const MaterialColor orange = MaterialColor(
    0xFFF39500,
    <int, Color>{
      50: orangePale, //(1)
      75: orangePale,
      100: Color(0xFFFDEACC),
      200: Color(0xFFFAD599),
      300: Color(0xFFF8BF66),
      375: Color(0xFFF6AF40),
      400: Color(0xFFF5AA33),
      500: Color(0xFFF39500),
      600: Color(0xFFC27700),
      700: Color(0xFF925900),
      800: Color(0xFF613C00),
      900: Color(0xFF311E00),
    },
  );

  // BASF - Red Swatches
  /// Red pale color
  static const Color redPale = Color(0xFFF6D9DE);

  /// Red MaterialColor
  static const MaterialColor red = MaterialColor(
    0xFFC50022,
    <int, Color>{
      50: redPale,
      75: redPale,
      100: Color(0xFFF3CCD3),
      200: Color(0xFFE899A7),
      300: Color(0xFFDC667A),
      375: Color(0xFFD34059),
      400: Color(0xFFD1334E),
      500: Color(0xFFC50022),
      600: Color(0xFF9E001B),
      700: Color(0xFF760014),
      800: Color(0xFF4F000E),
      900: Color(0xFF270007),
    },
  );

  // Color Groups
  /// The BASF primary color swatches, excluding grey.
  static const List<MaterialColor> primaries = <MaterialColor>[
    lightBlue,
    darkBlue,
    lightGreen,
    darkGreen,
    orange,
    red,
  ];

  /// The BASF primary color swatches, excluding grey.
  static const List<Color> paleColors = <Color>[
    lightBluePale,
    darkBluePale,
    lightGreenPale,
    darkGreenPale,
    orangePale,
    redPale,
  ];

  /// The BASF primary color swatches, with grey.
  static const List<MaterialColor> swatchColors = <MaterialColor>[
    lightBlue,
    darkBlue,
    lightGreen,
    darkGreen,
    orange,
    red,
    grey,
  ];

  /// All BASF colors excluding Black, White and Transparent
  /*
  List<Color> _all() {
    return <Color>[
      lightBluePale,
      lightBlue,
      darkBluePale,
      darkBlue,
      lightGreenPale,
      lightGreen,
      darkGreenPale,
      darkGreen,
      orangePale,
      orange,
      redPale,
      red,
      boxGrey,
      lightGrey,
      middleGrey,
      grey,
      darkGrey,
      copyTextGrey,
    ];
  }
  */
}
