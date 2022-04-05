import 'package:flutter/material.dart';

enum ButtonType { text, outlined }

abstract class BasfButton extends StatelessWidget {
  /// Use this to show text on the button directly.
  final String? text;

  /// Icon on the left
  final IconData? leadingIcon;

  /// Icon on the right˜
  final IconData? trailingIcon;

  /// Size of default icons
  final double? iconSize;

  /// Overrides all widgets (For example to show loader)
  final Widget? child;

  /// If this function is not set, the appearance of the button might be bad.
  final VoidCallback? onPressed;

  /// If this function is not set, the appearance of the button might be bad.
  final VoidCallback? onLongPress;

  /// Custom style different from the theme
  final ButtonStyle? style;

  /// The minimum width of the button.
  final Size? size;

  /// Maximizes button size
  final bool expanded;

  /// Button alignment
  final AlignmentGeometry? alignment;

  const BasfButton({
    Key? key,
    this.text,
    this.leadingIcon,
    this.trailingIcon,
    this.iconSize,
    this.child,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.size,
    this.expanded = false,
    this.alignment = Alignment.center,
  }) : super(key: key);

  Widget buttonStandardContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (leadingIcon != null) icon(leadingIcon!),
        if (leadingIcon != null && text != null) const SizedBox(width: 12),
        if (text != null) buttonText(),
        if (trailingIcon != null && text != null) const SizedBox(width: 12),
        if (trailingIcon != null) icon(trailingIcon!),
      ],
    );
  }

  Widget buttonChildContent() {
    if (expanded) {
      return SizedBox(
        width: double.infinity,
        child: Align(child: child!),
      );
    } else {
      return child!;
    }
  }

  Widget buttonText() {
    return Flexible(
      child: Text(
        text!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget icon(IconData iconData) {
    return Center(
      child: Icon(iconData, size: iconSize ?? 19),
    );
  }

  ButtonStyle getStyleWithAdjustments({
    required BuildContext context,
    required ButtonType buttonType,
  }) {
    ButtonStyle getButtonStyle() {
      switch (buttonType) {
        case ButtonType.text:
          return Theme.of(context).textButtonTheme.style!;
        case ButtonType.outlined:
          return Theme.of(context).outlinedButtonTheme.style!;
      }
    }

    ButtonStyle buttonStyle = style ?? getButtonStyle();
    MaterialStateProperty<Size>? buttonSize =
        size == null ? null : MaterialStateProperty.all<Size>(size!);

    return buttonStyle.copyWith(
      maximumSize: buttonSize ?? buttonStyle.maximumSize,
      minimumSize: buttonSize ?? buttonStyle.minimumSize,
    );
  }
}
