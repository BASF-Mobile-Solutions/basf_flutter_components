import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template basf_checkbox}
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
/// {@endtemplate}
class BasfCheckbox extends StatelessWidget {
  /// {@macro basf_checkbox}
  const BasfCheckbox({
    super.key,
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
  });

  /// Value of the checkbox
  final bool value;

  /// What happens when this value changes
  final void Function(bool) onChanged;

  /// Text of the checkbox
  final String? text;

  /// Position of the text relative to the checkbox
  final bool reverse;

  /// Alignment
  final MainAxisAlignment alignment;

  /// Main color of the checkbox
  final Color? color;

  /// Inactive color of the checkbox
  final Color? inactiveColor;

  /// Splash color of the checkbox
  final Color? activeSplashColor;

  /// Inactive splash color of the checkbox
  final Color? inactiveSplashColor;

  /// IconData for the checkbox
  final IconData? icon;

  /// Color of the icon
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return _checkBoxLayout();
  }

  Widget _checkBoxLayout() {
    final leading = reverse ? _text() : _checkbox();
    final trailing = reverse ? _checkbox() : _text();
    return Row(
      mainAxisAlignment: alignment,
      children: [leading, trailing],
    );
  }

  Widget _checkbox() {
    return Builder(
      builder: (context) {
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
      },
    );
  }

  Widget _text() {
    return Expanded(
      child: Text(text ?? ''),
    );
  }
}
