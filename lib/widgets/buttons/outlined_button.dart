import 'package:basf_flutter_components/widgets/buttons/basf_button.dart';
import 'package:flutter/material.dart';

class BasfOutlinedButton extends BasfButton {
  const BasfOutlinedButton({
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

  @override
  Widget build(BuildContext context) {
    if (alignment == null) {
      return button(context);
    } else {
      return Align(
        alignment: alignment!,
        child: button(context),
      );
    }
  }

  Widget button(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: getStyleWithAdjustments(
        context: context,
        buttonType: ButtonType.outlined,
      ),
      child: child != null ? buttonChildContent() : buttonStandardContent(),
    );
  }
}
