import 'package:basf_flutter_components/src/theme/colors.dart';
import 'package:flutter/material.dart';

/// Circular progress
class AppCircularProgress extends StatelessWidget {

  /// Bigger for buttons
  const AppCircularProgress.button({
    super.key,
    this.color = BasfColors.white,
    this.size = 18,
    this.strokeWidth = 4,
  });

  /// Smaller for lines
  const AppCircularProgress.inline({
    super.key,
    this.color = BasfColors.grey,
    this.size = 14,
    this.strokeWidth = 3,
  });

  /// Color
  final Color color;

  /// Size
  final double size;

  /// Stroke Width
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
