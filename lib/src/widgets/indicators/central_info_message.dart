import 'package:flutter/material.dart';

/// info message to show in the center
class CentralInfoMessage extends StatelessWidget {
  /// info message to show in the center
  const CentralInfoMessage({
    required this.message,
    this.iconData = Icons.info_outline,
    this.iconSize = 28,
    this.textStyle,
    super.key,
  });

  ///
  final IconData iconData;

  ///
  final double iconSize;

  ///
  final String message;

  ///
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Icon(iconData, size: iconSize),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
