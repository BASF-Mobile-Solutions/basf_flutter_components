import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template radio}
/// Radio option row with BASF Style
/// {@radio}
class RadioOptions<T> extends StatelessWidget {
  /// {@macro radio}
  const RadioOptions({
    super.key,
    required this.values,
    required this.selectedValue,
    required this.title,
    required this.onSelected,
    required this.labelGenerator,
    this.descriptionGenerator,
    this.titleStyle,
    this.identityHelperFunction,
    this.separator,
  });

  /// List of values
  final List<T> values;

  /// Selected value
  final T selectedValue;

  /// Radio title
  final String title;

  /// Text style
  final TextStyle? titleStyle;

  /// Action to be performed on selection
  final ValueChanged<T> onSelected;

  /// Helper identity function
  final T Function(T)? identityHelperFunction;

  /// Label generator function
  final String Function(T value) labelGenerator;

  /// Description generator function
  final String Function(T value)? descriptionGenerator;

  /// Widget separation
  final Widget? separator;
  // typedef StringGetter<T> = String Function(T value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ?? theme.textTheme.bodyText2,
        ),
        VerticalSpacer.normal(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            values.length,
            (index) => Expanded(
              child: OptionButton(
                labelText: labelGenerator(values[index]),
                description: descriptionGenerator?.call(values[index]),
                isSelected: identityHelperFunction != null
                    ? identityHelperFunction?.call(selectedValue) ==
                        identityHelperFunction?.call(values[index])
                    : selectedValue == values[index],
                onPressed: () {
                  onSelected(values[index]);
                },
              ),
            ),
          ).joinWithSeparator(separator ?? HorizontalSpacer.semi()),
        ),
      ],
    );
  }
}
