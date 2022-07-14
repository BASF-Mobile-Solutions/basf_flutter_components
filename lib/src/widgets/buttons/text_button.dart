import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template basf_text_button}
/// A BASF-style text button
/// {@endtemplate}

enum TextButtonConstructorType {
  /// contained constructor
  contained,

  /// transparent constructor
  transparent,

  /// hint constructor
  hint,
}

/// {@macro basf_text_button}
class BasfTextButton extends BasfButton with TextButtonHelper {
  /// {@macro basf_text_button}
  /// contained
  BasfTextButton.contained({
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
    super.expanded = false,
    super.alignment,
  }) {
    constructorType = TextButtonConstructorType.contained;
  }

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
    super.style,
    super.size,
    super.expanded = false,
    super.alignment,
  }) {
    constructorType = TextButtonConstructorType.transparent;
  }

  /// {@macro basf_text_button}
  /// hint
  BasfTextButton.hint({
    super.key,
    super.text,
    super.child,
    super.onPressed,
    super.onLongPress,
    super.style,
    super.size,
    super.expanded = false,
    super.alignment,
  }) {
    constructorType = TextButtonConstructorType.hint;
  }

  /// shows with which constructor the widget has been built
  late final TextButtonConstructorType constructorType;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment!,
      child: _button(context),
    );
  }

  Widget _button(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: getStyleWithAdjustments(
        context: context,
        buttonType: ButtonType.text,
        style: getTextButtonStyle(
          context: context,
          constructorType: constructorType,
          style: style,
        ),
      ),
      child: child != null ? buttonChildContent() : buttonStandardContent(),
    );
  }
}

/// mixing for text button
mixin TextButtonHelper {
  /// TextButton style
  ButtonStyle? getTextButtonStyle({
    required TextButtonConstructorType constructorType,
    required BuildContext context,
    required ButtonStyle? style,
  }) {
    switch (constructorType) {
      case TextButtonConstructorType.contained:
        return style;
      case TextButtonConstructorType.transparent:
        return getTransparentStyle(
          context: context,
          style: style,
        );
      case TextButtonConstructorType.hint:
        return getHintStyle(
          context: context,
          style: style,
        );
    }
  }

  /// get transparent style
  ButtonStyle? getTransparentStyle({
    required BuildContext context,
    required ButtonStyle? style,
  }) {
    if (style == null) {
      return ButtonStyles.transparentTextButtonStyle(
        Theme.of(context).primaryColor,
      );
    } else {
      return style.merge(
        ButtonStyles.transparentTextButtonStyle(
          Theme.of(context).primaryColor,
        ),
      );
    }
  }

  /// get hint style
  ButtonStyle? getHintStyle({
    required BuildContext context,
    required ButtonStyle? style,
  }) {
    if (style == null) {
      return ButtonStyles.hintTextButtonStyle(Theme.of(context).primaryColor);
    } else {
      return style.merge(
        ButtonStyles.hintTextButtonStyle(
          Theme.of(context).primaryColor,
        ),
      );
    }
  }
}
