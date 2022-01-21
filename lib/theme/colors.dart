import 'package:flutter/material.dart';

///This class contains every official BASF Color and their swatches.
///
/// (The structure is inspired by Material's Colors class)
///
/// (1) The [50] value of the MaterialColors is set additionally to the next darker one.
///     This prevents null pointer errors if you use these MaterialColors in themes.

class BASFColors {
  BASFColors._();

  ///BASF - Default Colors
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  ///BASF - Grey Swatches
  static const Color boxGrey = Color(_boxGreyValue);
  static const Color lightGrey = Color(_lightGreyValue);
  static const Color middleGrey = Color(_middleGreyValue);
  static const Color darkGrey = Color(_darkGreyValue);
  static const Color copyTextGrey = Color(_copyTextGreyValue);
  static const MaterialColor grey = MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      50: Color(_boxGreyValue), //(1)
      75: Color(_boxGreyValue),
      100: Color(0xFFECECEC),
      175: Color(_lightGreyValue),
      200: Color(0xFFD8D8D8),
      300: Color(0xFFC5C5C5),
      400: Color(0xFFB1B1B1),
      425: Color(_middleGreyValue),
      500: Color(_greyPrimaryValue),
      600: Color(_darkGreyValue),
      700: Color(0xFF5F5F5F),
      800: Color(0xFF3F3F3F),
      825: Color(_copyTextGreyValue),
      900: Color(0xFF202020),
    },
  );
  static const int _greyPrimaryValue = 0xFF9E9E9E;
  static const int _boxGreyValue = 0xFFF0F0F0;
  static const int _lightGreyValue = 0xFFDDDDDD;
  static const int _middleGreyValue = 0xFFADADAD;
  static const int _darkGreyValue = 0xFF7E7E7E;
  static const int _copyTextGreyValue = 0xFF373737;

  ///BASF - Light Blue Swatches
  static const Color lightBluePale = Color(_lightBluePaleValue);
  static const MaterialColor lightBlue = MaterialColor(
    _lightBluePrimaryValue,
    <int, Color>{
      50: Color(_lightBluePaleValue), //(1)
      75: Color(_lightBluePaleValue),
      100: Color(0xFFD3ECF6),
      200: Color(0xFFA6D9ED),
      300: Color(0xFF7AC6E4),
      375: Color(0xFF59B8DE),
      400: Color(0xFF4DB3DB),
      500: Color(_lightBluePrimaryValue),
      600: Color(0xFF1A80A8),
      700: Color(0xFF14607E),
      800: Color(0xFF0D4054),
      900: Color(0xFF000F1E),
    },
  );
  static const int _lightBluePrimaryValue = 0xFF21A0D2;
  static const int _lightBluePaleValue = 0xFFDEF1F8;

  ///BASF - Dark Blue Swatches
  static const Color darkBluePale = Color(_darkBluePaleValue);
  static const MaterialColor darkBlue = MaterialColor(
    _darkBluePrimaryValue,
    <int, Color>{
      50: Color(_darkBluePaleValue), //(1)
      75: Color(_darkBluePaleValue),
      100: Color(0xFFCCDBEA),
      200: Color(0xFF99B7D5),
      300: Color(0xFF6692C0),
      375: Color(0xFF336EAB),
      400: Color(0xFF2665A6),
      500: Color(_darkBluePrimaryValue),
      600: Color(0xFF003B78),
      700: Color(0xFF002C5A),
      800: Color(0xFF001E3C),
      900: Color(0xFF000F1E),
    },
  );
  static const int _darkBluePrimaryValue = 0xFF004A96;
  static const int _darkBluePaleValue = 0xFFD9E4EF;

  ///BASF - Light Green Swatches
  static const Color lightGreenPale = Color(_lightGreenPaleValue);
  static const MaterialColor lightGreen = MaterialColor(
    _lightGreenPrimaryValue,
    <int, Color>{
      50: Color(_lightGreenPaleValue), //(1)
      100: Color(_lightGreenPaleValue),
      200: Color(0xFFC1DEA5),
      300: Color(0xFFA3CD78),
      375: Color(0xFF8CC156),
      400: Color(0xFF84BD4B),
      500: Color(_lightGreenPrimaryValue),
      600: Color(0xFF518A18),
      700: Color(0xFF3D6712),
      800: Color(0xFF28450C),
      900: Color(0xFF142206),
    },
  );
  static const int _lightGreenPrimaryValue = 0xFF65AC1E;
  static const int _lightGreenPaleValue = 0xFFE0EED2;

  ///BASF - Dark Green Swatches
  static const Color darkGreenPale = Color(_darkGreenPaleValue);
  static const MaterialColor darkGreen = MaterialColor(
    _darkGreenPrimaryValue,
    <int, Color>{
      50: Color(_darkGreenPaleValue), //(1)
      75: Color(_darkGreenPaleValue),
      100: Color(0xFFCCE4D8),
      200: Color(0xFF99C9B0),
      300: Color(0xFF66AF89),
      375: Color(0xFF66AF89),
      400: Color(0xFF339461),
      500: Color(_darkGreenPrimaryValue),
      600: Color(0xFF00612E),
      700: Color(0xFF004923),
      800: Color(0xFF003017),
      900: Color(0xFF00180C),
    },
  );
  static const int _darkGreenPrimaryValue = 0xFF00793A;
  static const int _darkGreenPaleValue = 0xFFD9EBE1;

  ///BASF - Orange Swatches
  static const Color orangePale = Color(_orangePaleValue);
  static const MaterialColor orange = MaterialColor(
    _orangePrimaryValue,
    <int, Color>{
      50: Color(_orangePaleValue), //(1)
      75: Color(_orangePaleValue),
      100: Color(0xFFFDEACC),
      200: Color(0xFFFAD599),
      300: Color(0xFFF8BF66),
      375: Color(0xFFF6AF40),
      400: Color(0xFFF5AA33),
      500: Color(_orangePrimaryValue),
      600: Color(0xFFC27700),
      700: Color(0xFF925900),
      800: Color(0xFF613C00),
      900: Color(0xFF311E00),
    },
  );
  static const int _orangePrimaryValue = 0xFFF39500;
  static const int _orangePaleValue = 0xFFFDEFD9;

  ///BASF - Red Swatches
  static const Color redPale = Color(_redPaleValue);
  static const MaterialColor red = MaterialColor(
    _redPrimaryValue,
    <int, Color>{
      50: Color(_redPaleValue), //(1)
      75: Color(_redPaleValue),
      100: Color(0xFFF3CCD3),
      200: Color(0xFFE899A7),
      300: Color(0xFFDC667A),
      375: Color(0xFFD34059),
      400: Color(0xFFD1334E),
      500: Color(_redPrimaryValue),
      600: Color(0xFF9E001B),
      700: Color(0xFF760014),
      800: Color(0xFF4F000E),
      900: Color(0xFF270007),
    },
  );
  static const int _redPrimaryValue = 0xFFC50022;
  static const int _redPaleValue = 0xFFF6D9DE;

  ///Color Groups
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
  static const List<Color> all = <Color>[
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
