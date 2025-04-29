import 'package:flutter/material.dart';

/// Standard basf gradient background
class GradientBackground extends StatelessWidget {
  /// Standard basf gradient background
  const GradientBackground({required this.child, super.key});

  /// Widget to show inside
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withValues(alpha: 0.3),
            Theme.of(context).primaryColor.withValues(alpha: 0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0, 0.2],
        ),
      ),
      child: child,
    );
  }
}
