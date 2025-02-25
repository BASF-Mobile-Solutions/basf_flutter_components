import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// A reusable widget to label text fields, dropdowns, etc.
class LabeledWidget extends StatelessWidget {
  /// A reusable widget to label text fields, dropdowns, etc.
  const LabeledWidget({
    required this.labelText,
    required this.child,
    this.maxLines = 1,
    this.style,
    super.key,
  });

  /// The label placed above the [child]
  final String? labelText;

  /// The max lines of the [labelText]
  final int? maxLines;

  /// The text style of the [labelText]
  final TextStyle? style;

  /// The child labeled by the [labelText]
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            style: style ?? Theme.of(context).textTheme.bodyMedium,
          ),
        child,
      ].joinWithSeparator(VerticalSpacer.normal()),
    );
  }
}
