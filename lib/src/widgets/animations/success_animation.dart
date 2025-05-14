import 'package:basf_flutter_components/utils/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Rounded checkmark animation
class SuccessAnimation extends StatelessWidget {
  ///
  const SuccessAnimation({
    super.key,
    this.size = const Size(40, 40),
    this.color,
  });

  ///
  final Size size;
  ///
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: Assets.rive.successIcon.rive(
        animations: const ['show'],
        onInit: (artBoard) {
          artBoard.forEachComponent((shape) {
            if (shape is Shape && shape.fills.isNotEmpty) {
              shape.fills.first.paint
                  .color = color ?? Theme.of(context).primaryColor;
            }
          });
        },
      ),
    );
  }
}
