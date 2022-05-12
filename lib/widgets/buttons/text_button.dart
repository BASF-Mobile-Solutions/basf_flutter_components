import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class BasfTextButton extends BasfButton {
  const BasfTextButton.contained({
    Key? key,
    String? text,
    IconData? leadingIcon,
    IconData? trailingIcon,
    double? iconSize,
    Widget? child,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    Size? size,
    bool expanded = false,
    AlignmentGeometry? alignment,
  }) : super(
          key: key,
          text: text,
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon,
          iconSize: iconSize,
          child: child,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: style,
          size: size,
          expanded: expanded,
          alignment: alignment,
        );

  BasfTextButton.transparent({
    Key? key,
    String? text,
    IconData? leadingIcon,
    IconData? trailingIcon,
    double? iconSize,
    Widget? child,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    Size? size,
    bool expanded = false,
    AlignmentGeometry? alignment,
  }) : super(
          key: key,
          text: text,
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon,
          iconSize: iconSize,
          child: child,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: style == null
              ? ButtonStyles.transparentTextButtonStyle
              : style.merge(ButtonStyles.transparentTextButtonStyle),
          size: size,
          expanded: expanded,
          alignment: alignment,
        );

  BasfTextButton.hint({
    Key? key,
    String? text,
    Widget? child,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    Size? size,
    bool expanded = false,
    AlignmentGeometry? alignment,
  }) : super(
          key: key,
          text: text,
          child: child,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: style == null
              ? ButtonStyles.hintTextButtonStyle
              : style.merge(ButtonStyles.hintTextButtonStyle),
          size: size,
          expanded: expanded,
          alignment: alignment,
        );

  @override
  Widget build(BuildContext context) {
    if (alignment == null) {
      return button(context);
    } else {
      return Align(alignment: alignment!, child: button(context));
    }
  }

  Widget button(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: getStyleWithAdjustments(
        context: context,
        buttonType: ButtonType.text,
      ),
      child: child != null ? buttonChildContent() : buttonStandardContent(),
    );
  }
}
