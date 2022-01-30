import 'package:basf_flutter_components/theme/buttons.dart';
import 'package:flutter/material.dart';

class BasfTextButton extends StatelessWidget {
  ///Use this to show text on the button directly.
  final String? text;

  /// Icon on the left
  final IconData? leadingIcon;

  /// Icon on the right
  final IconData? trailingIcon;

  ///If this function is not set, the appearance of the button might be bad.
  final VoidCallback? onPressed;

  ///The minimum width of the button.
  final Size? size;

  ///The minimum width of the button.
  final bool expanded;

  ///Swap the colors of the button. For instance for more contrast.
  final bool isOutlined;

  const BasfTextButton({
    Key? key,
      this.text,
      required this.onPressed,
      this.size,
      this.leadingIcon,
      this.trailingIcon,
      this.isOutlined = false,
      this.expanded = false,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        child: buttonContent(),
        style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
          maximumSize: size != null
              ? MaterialStateProperty.all(size)
              : Theme.of(context).outlinedButtonTheme.style!.maximumSize,
          minimumSize: expanded
              ? MaterialStateProperty.all(const Size(double.infinity, ButtonThemes.buttonHeight))
              : Theme.of(context).outlinedButtonTheme.style!.minimumSize,
        ),
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        child: buttonContent(),
        style: Theme.of(context).textButtonTheme.style!.copyWith(
            maximumSize: getSize() ?? Theme.of(context).textButtonTheme.style!.maximumSize,
            minimumSize: getSize() ?? Theme.of(context).textButtonTheme.style!.minimumSize,
        ),
      );
    }
  }

  Widget buttonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) icon(leadingIcon!),
        if (leadingIcon != null && text != null) const SizedBox(width: 12),
        if (text != null) Text(text!),
        if (trailingIcon != null && text != null) const SizedBox(width: 12),
        if (trailingIcon != null) icon(trailingIcon!),
      ],
    );
  }

  Widget icon(IconData iconData) => Icon(iconData, size: 25);

  MaterialStateProperty<Size>? getSize() {
    if (expanded) {
      Size infiniteSize = const Size(double.infinity, ButtonThemes.buttonHeight);
      return MaterialStateProperty.all(infiniteSize);
    } else if (size != null) {
      return MaterialStateProperty.all(size!);
    }
  }

}
