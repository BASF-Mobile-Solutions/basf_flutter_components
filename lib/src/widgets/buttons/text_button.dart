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
class BasfTextButton extends BasfButton {

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
    super.expanded,
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
    super.expanded,
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
    super.expanded,
    super.alignment,
  }) {
    constructorType = TextButtonConstructorType.hint;
  }

  /// shows with which constructor the widget has been built
  late final TextButtonConstructorType constructorType;

  @override
  State<BasfTextButton> createState() => _BasfTextButtonState();
}

class _BasfTextButtonState extends State<BasfTextButton> with TextButtonHelper {

  late final ButtonStyle? _buttonStyle;
  bool _styleSet = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_styleSet) {
      _buttonStyle = getTextButtonStyle(
        context: context,
        constructorType: widget.constructorType,
        style: widget.style,
      );
      _styleSet = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: widget.alignment!,
        child: _button(context),
    );
  }

  Widget _button(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      style: widget.getStyleWithAdjustments(
        context: context,
        buttonType: ButtonType.text,
        style: _buttonStyle,
      ),
      child: widget.child != null
          ? widget.buttonChildContent()
          : widget.buttonStandardContent(),
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
      case TextButtonConstructorType.contained: return style;
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
