import 'package:basf_flutter_components/src/widgets/indicators/dotted_line.dart';
import 'package:flutter/material.dart';

/// Dotted separator
class DottedSeparator extends StatelessWidget {
  /// Dotted separator
  const DottedSeparator({required this.padding, super.key});

  ///
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DottedLine(
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
