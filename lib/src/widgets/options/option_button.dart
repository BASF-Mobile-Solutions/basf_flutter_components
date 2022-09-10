import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template option_button}
/// Option button used on Radio
/// {@endtemplate}
class OptionButton extends StatelessWidget {
  /// {@macro option_button}
  const OptionButton({
    super.key,
    required this.labelText,
    this.onPressed,
    required this.isSelected,
    this.description,
  });

  /// Text for the button
  final String labelText;

  /// Action to be performed on pressed
  final VoidCallback? onPressed;

  /// Current state of the button
  final bool isSelected;

  /// Optional description of the button
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (description == null) {
      return _optionButton(theme);
    } else {
      return Column(
        children: [
          _optionButton(theme),
          VerticalSpacer.semi(),
          Text(
            description!,
            style: theme.textTheme.bodyText2?.copyWith(color: BasfColors.grey),
          ),
        ],
      );
    }
  }

  Widget _optionButton(ThemeData theme) {
    return DecoratedBox(
      decoration: const BoxDecoration(boxShadow: [BasfShadows.lightShadow]),
      child: BasfTextButton.contained(
        expanded: true,
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? null : BasfColors.white,
          elevation: 1,
          foregroundColor: theme.primaryColor,
        ),
        child: Text(
          labelText,
          style: TextStyle(
            color: isSelected ? BasfColors.backgroundGrey : theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
