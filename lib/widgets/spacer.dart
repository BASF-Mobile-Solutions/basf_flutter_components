import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// [VerticalSpacer] creates a vertical separation between [Widgets]
/// the same way you would use a SizedBox, but with predefined values
/// from [Dimens]
///
/// Example:
/// ```dart
///    VerticalSpacer.xSmall(),
///    VerticalSpacer.small(),
///    VerticalSpacer.normal(),
///    VerticalSpacer.semi(),
///    VerticalSpacer.mediumSmall(),
///    VerticalSpacer.medium(),
///    VerticalSpacer.medium20(),
///    VerticalSpacer.mediumLarge(),
///    VerticalSpacer.large(),
///    VerticalSpacer.xLarge(),
///    VerticalSpacer.xxLarge(),
///    VerticalSpacer.xxxLarge(),
/// ```
///
/// See also:
///
///  * [Dimens]
///  * [HorizontalSpacer]
///  * [HorizontalSpacerWithText]
class VerticalSpacer extends SizedBox {
  const VerticalSpacer({Key? key, required double height})
      : super(key: key, height: height);

  /// [VerticalSpacer] with [2.0] as padding
  factory VerticalSpacer.xSmall() =>
      const VerticalSpacer(height: Dimens.paddingXSmall);

  /// [VerticalSpacer] with [4.0] as padding
  factory VerticalSpacer.small() =>
      const VerticalSpacer(height: Dimens.paddingSmall);

  /// [VerticalSpacer] with [8.0] as padding
  factory VerticalSpacer.normal() =>
      const VerticalSpacer(height: Dimens.paddingDefault);

  /// [VerticalSpacer] with [10.0] as padding
  factory VerticalSpacer.semi() =>
      const VerticalSpacer(height: Dimens.paddingSemi);

  /// [VerticalSpacer] with [12.0] as padding
  factory VerticalSpacer.mediumSmall() =>
      const VerticalSpacer(height: Dimens.paddingMediumSmall);

  /// [VerticalSpacer] with [16.0] as padding
  factory VerticalSpacer.medium() =>
      const VerticalSpacer(height: Dimens.paddingMedium);

  /// [VerticalSpacer] with [20.0] as padding
  factory VerticalSpacer.medium20() =>
      const VerticalSpacer(height: Dimens.paddingMedium20);

  /// [VerticalSpacer] with [24.0] as padding
  factory VerticalSpacer.mediumLarge() =>
      const VerticalSpacer(height: Dimens.paddingMediumLarge);

  /// [VerticalSpacer] with [32.0] as padding
  factory VerticalSpacer.large() =>
      const VerticalSpacer(height: Dimens.paddingLarge);

  /// [VerticalSpacer] with [36.0] as padding
  factory VerticalSpacer.xLarge() =>
      const VerticalSpacer(height: Dimens.paddingXLarge);

  /// [VerticalSpacer] with [48.0] as padding
  factory VerticalSpacer.xxLarge() =>
      const VerticalSpacer(height: Dimens.paddingXXLarge);

  /// [VerticalSpacer] with [64.0] as padding
  factory VerticalSpacer.xxxLarge() =>
      const VerticalSpacer(height: Dimens.paddingXXXLarge);
}

/// [HorizontalSpacer] creates a horizontal separation between [Widgets]
/// the same way you would use a SizedBox, but with predefined values
/// from [Dimens]
///
/// Example:
/// ```dart
///    HorizontalSpacer.small()
///    HorizontalSpacer.normal()
///    HorizontalSpacer.semi()
///    HorizontalSpacer.mediumSmall()
///    HorizontalSpacer.medium()
///    HorizontalSpacer.medium20()
///    HorizontalSpacer.mediumLarge()
///    HorizontalSpacer.large()
///    HorizontalSpacer.xLarge()
///    HorizontalSpacer.xxLarge()
/// ```
///
/// See also:
///
///  * [Dimens]
///  * [VerticalSpacer]
///  * [HorizontalSpacerWithText]
class HorizontalSpacer extends SizedBox {
  const HorizontalSpacer({Key? key, required double width})
      : super(key: key, width: width);

  /// [HorizontalSpacer] with [2.0] as padding
  factory HorizontalSpacer.xSmall() =>
      const HorizontalSpacer(width: Dimens.paddingXSmall);

  /// [HorizontalSpacer] with [4.0] as padding
  factory HorizontalSpacer.small() =>
      const HorizontalSpacer(width: Dimens.paddingSmall);

  /// [HorizontalSpacer] with [8.0] as padding
  factory HorizontalSpacer.normal() =>
      const HorizontalSpacer(width: Dimens.paddingDefault);

  /// [HorizontalSpacer] with [10.0] as padding
  factory HorizontalSpacer.semi() =>
      const HorizontalSpacer(width: Dimens.paddingSemi);

  /// [HorizontalSpacer] with [12.0] as padding
  factory HorizontalSpacer.mediumSmall() =>
      const HorizontalSpacer(width: Dimens.paddingMediumSmall);

  /// [HorizontalSpacer] with [16.0] as padding
  factory HorizontalSpacer.medium() =>
      const HorizontalSpacer(width: Dimens.paddingMedium);

  /// [HorizontalSpacer] with [20.0] as padding
  factory HorizontalSpacer.medium20() =>
      const HorizontalSpacer(width: Dimens.paddingMedium20);

  /// [HorizontalSpacer] with [24.0] as padding
  factory HorizontalSpacer.mediumLarge() =>
      const HorizontalSpacer(width: Dimens.paddingMediumLarge);

  /// [HorizontalSpacer] with [32.0] as padding
  factory HorizontalSpacer.large() =>
      const HorizontalSpacer(width: Dimens.paddingLarge);

  /// [HorizontalSpacer] with [36.0] as padding
  factory HorizontalSpacer.xLarge() =>
      const HorizontalSpacer(width: Dimens.paddingXLarge);

  /// [HorizontalSpacer] with [48.0] as padding
  factory HorizontalSpacer.xxLarge() =>
      const HorizontalSpacer(width: Dimens.paddingXXLarge);

  /// [HorizontalSpacer] with [64.0] as padding
  factory HorizontalSpacer.xxxLarge() =>
      const HorizontalSpacer(width: Dimens.paddingXXXLarge);
}

/// [HorizontalSpacerWithText] creates a horizontal separation between [Widgets]
/// with a text in between
///
/// Example:
/// ```dart
///    HorizontalSpacerWithText(
///      text: 'example text',
///      color: Colors.green,
///    );
/// ```
///
/// See also:
///
///  * [Dimens]
///  * [VerticalSpacer]
///  * [HorizontalSpacerWithText]
class HorizontalSpacerWithText extends StatelessWidget {
  /// Text that will be displayed in between widgets
  final String text;

  /// Style of the text in between dividers
  final TextStyle? textStyle;

  /// Color of the separation in between widgets
  final Color color;

  /// Height of the divider
  final double? height;

  /// Thickness of the divider
  final double? thickness;

  const HorizontalSpacerWithText({
    Key? key,
    required this.text,
    this.textStyle,
    required this.color,
    this.height = 36,
    this.thickness = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Divider(
              thickness: thickness,
              color: color,
              height: height,
            ),
          ),
        ),
        VerticalSpacer.small(),
        Text(
          text,
          style: textStyle,
        ),
        VerticalSpacer.small(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Divider(
              thickness: thickness,
              color: color,
              height: height,
            ),
          ),
        ),
      ],
    );
  }
}
