import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template basf_text_button}
/// A BASF-style text button
/// {@endtemplate}
class BasfTextButton extends BasfButton {
  /// {@macro basf_text_button}
  /// contained
  const BasfTextButton.contained({
    super.key,
    super.text,
    super.leadingIcon,
    super.trailingIcon,
    super.iconSize,
    super.child,
    super.onPressed,
    super.onLongPress,
    super.style,
    super.size,
    super.expanded,
  });

  /// {@macro basf_text_button}
  /// transparent
  BasfTextButton.transparent({
    super.key,
    super.text,
    super.leadingIcon,
    super.trailingIcon,
    super.iconSize,
    super.child,
    super.onPressed,
    super.onLongPress,
    ButtonStyle? style,
    super.size,
    super.expanded,
    required BuildContext context,
  }) : super(
          style: style == null
              ? ButtonStyles.transparentTextButtonStyle(
                  Theme.of(context).primaryColor,
                )
              : style.merge(
                  ButtonStyles.transparentTextButtonStyle(
                    Theme.of(context).primaryColor,
                  ),
                ),
        );

  /// {@macro basf_text_button}
  /// hint
  BasfTextButton.hint({
    super.key,
    super.text,
    super.child,
    super.onPressed,
    super.onLongPress,
    ButtonStyle? style,
    super.size,
    super.expanded,
    super.alignment,
    required BuildContext context,
  }) : super(
          style: style == null
              ? ButtonStyles.hintTextButtonStyle(Theme.of(context).primaryColor)
              : style.merge(
                  ButtonStyles.hintTextButtonStyle(
                    Theme.of(context).primaryColor,
                  ),
                ),
        );

  @override
  Widget build(BuildContext context) {
    return Align(alignment: alignment!, child: _button(context));
  }

  Widget _button(BuildContext context) {
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
