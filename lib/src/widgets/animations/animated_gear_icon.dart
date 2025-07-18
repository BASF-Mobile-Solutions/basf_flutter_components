import 'package:basf_flutter_components/utils/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Settings gear icon animated
class AnimatedGearIcon extends StatelessWidget {
  /// Settings gear icon animated
  const AnimatedGearIcon({
    this.size = 25,
    this.onTap,
    this.color,
    super.key,
  });

  ///
  final double size;

  ///
  final VoidCallback? onTap;

  ///
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final currentColor = color ?? Theme.of(context).primaryColor;

    if (onTap != null) {
      return InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: gearsAnimation(currentColor),
        ),
      );
    } else {
      return gearsAnimation(currentColor);
    }
  }

  /// animation
  Widget gearsAnimation(Color color) {
    return SizedBox(
      height: size,
      width: size,
      child: BasfAssets.rive.gears.rive(
        animations: const ['spin1'],
        onInit: (artBoard) {
          var fillComponent = 0;
          artBoard.forEachComponent((shape) {
            if (shape is Shape) {
              fillComponent++;
              switch (fillComponent) {
                case 1:
                  shape.fills.first.paint.color = color.withValues(alpha: 0.8);
                case 2:
                  shape.fills.first.paint.color = color.withValues(alpha: 0.9);
                case 3:
                  shape.fills.first.paint.color = color;
              }
            }
          });
        },
      ),
    );
  }
}
