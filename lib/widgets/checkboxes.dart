import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// [BasfCheckbox]
///
/// Example:
/// ```dart
///  BasfCheckbox(
///    text: 'Default value',
///    value: _value,
///    onChanged: (value) {
///      _value = !value;
///      setState(() {});
///    },
///  ),
/// ```
class BasfCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final String? text;
  final bool reverse;
  final MainAxisAlignment alignment;
  final Color? color;
  final Color? inactiveColor;
  final Color? activeSplashColor;
  final Color? inactiveSplashColor;
  final IconData? icon;
  final Color? iconColor;

  const BasfCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.text,
    this.reverse = false,
    this.alignment = MainAxisAlignment.start,
    this.inactiveColor,
    this.color,
    this.activeSplashColor,
    this.inactiveSplashColor,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return checkBoxLayout();
  }

  Widget checkBoxLayout() {
    final Widget leading = reverse ? _text() : _checkbox();
    final Widget trailing = reverse ? _checkbox() : _text();
    return Row(
      mainAxisAlignment: alignment,
      children: [leading, trailing],
    );
  }

  Widget _checkbox() {
    return Builder(builder: (context) {
      return MaterialButton(
        minWidth: 0,
        splashColor: !value
            ? activeSplashColor ?? Theme.of(context).colorScheme.primary
            : inactiveSplashColor ?? BasfColors.middleGrey,
        shape: const CircleBorder(),
        onPressed: () => onChanged(value),
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: value
                ? color ?? Theme.of(context).colorScheme.primary
                : inactiveColor ?? BasfColors.middleGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon ?? Icons.check,
            color: iconColor ?? Colors.white,
          ),
        ),
      );
    });
  }

  Widget _text() {
    return Expanded(
      child: Text(text ?? ''),
    );
  }
}
