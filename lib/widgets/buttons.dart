import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

//Known issues:
// Color can not be changed with setState or hot reload
class BASFButton extends StatefulWidget {
  ///Use this to show text on the button directly.
  final String? text;

  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final IconData? iconOnly;

  ///If this function is not set, the appearance of the button might be bad.
  final VoidCallback? onPressed;

  ///The main color of the button.
  final Color color;

  ///The minimum width of the button.
  final double? width;

  ///Expand the Button in the width.
  final bool expand;

  ///The height of the button.
  final double? height;

  ///This is the padding around the child.
  final EdgeInsets? padding;

  ///This is the margin around the Button.
  final EdgeInsets? margin;

  ///Swap the colors of the button. For instance for more contrast.
  final bool negative;

  const BASFButton(
      {Key? key,
      this.text,
      required this.onPressed,
      required this.color,
      this.width = 48,
      this.expand = false,
      this.height = 48,
      this.padding,
      this.margin,
      this.leadingIcon,
      this.trailingIcon,
      this.iconOnly,
      this.negative = false})
      : assert(iconOnly != (text != null),
            'You need a text or the iconOnly with true, but only one.'),
        assert(
            (leadingIcon == null && trailingIcon == null) ||
                (((leadingIcon != null) || trailingIcon != null) &&
                    (text != null)),
            'You need a text to use leading or trailing icon'),
        assert(!((leadingIcon != null) && trailingIcon != null),
            'You can not use both leading and trailing icon'),
        super(key: key);

  @override
  State<BASFButton> createState() => _BASFButtonState();
}

class _BASFButtonState extends State<BASFButton> {
  late TextStyle textStyle;
  late TextStyle _textStyle;

  late Color buttonColor;
  late Color _buttonColor;

  @override
  void initState() {
    if (widget.negative) {
      textStyle = BasfTextStyles.containedButton.copyWith(color: widget.color);
      buttonColor = BASFColors.white;
    } else {
      textStyle = BasfTextStyles.containedButton;
      buttonColor = widget.negative ? BASFColors.white : widget.color;
    }

    _textStyle = textStyle;
    _buttonColor = buttonColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.negative && widget.onPressed == null) {
      _textStyle = BasfTextStyles.containedButtonDisabledNegative;
    }

    Icon _icon = Icon(
        widget.iconOnly ?? widget.leadingIcon ?? widget.trailingIcon,
        color: _textStyle.color,
        size: 25);

    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: MaterialButton(
        padding: widget.padding ??
            (widget.iconOnly != null
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 16)),
        color: _buttonColor,
        height: widget.height,
        minWidth: widget.expand ? double.infinity : widget.width,
        splashColor: BASFColors.transparent,
        elevation: 0,
        highlightElevation: 0,
        disabledColor:
            widget.negative ? BASFColors.lightGrey : BASFColors.middleGrey,
        highlightColor: BASFColors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.iconOnly != null) _icon,
            if (widget.leadingIcon != null) _icon,
            if (widget.leadingIcon != null) const SizedBox(width: 12),
            if (widget.text != null) Text(widget.text!, style: _textStyle),
            if (widget.trailingIcon != null) const SizedBox(width: 12),
            if (widget.trailingIcon != null) _icon,
          ],
        ),
        onPressed: widget.onPressed,
        onHighlightChanged: (value) {
          if (value) {
            _textStyle = BasfTextStyles.containedButton;
            _buttonColor = widget.color is MaterialColor
                ? (widget.color as MaterialColor)[400]!
                : Color.lerp(widget.color, BASFColors.white, 0.5)!;
          } else {
            _textStyle = textStyle;
            _buttonColor = buttonColor;
          }
          setState(() {});
        },
      ),
    );
  }
}
