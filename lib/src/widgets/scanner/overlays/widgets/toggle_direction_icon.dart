import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Toggle flashlight icon button
class ToggleDirectionIconButton extends StatelessWidget {
  ///
  const ToggleDirectionIconButton({
    this.size = 28,
    super.key,
  });

  ///
  final double size;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScannerCubit>();

    return ValueListenableBuilder<CameraFacing>(
      valueListenable: cubit.directionNotifier,
      builder: (context, facing, _) {
        return IconButton(
          onPressed: () {
            cubit.cameraController.switchCamera();
          },
          color: Colors.white.withValues(alpha: 0.4),
          iconSize: size,
          icon: AnimatedRotation(
            duration: const Duration(milliseconds: 200),
            turns: switch(facing) {
              CameraFacing.front => -0.5,
              CameraFacing.external => -0.75,
              _ => 0,
            },
            child: const Icon(Icons.cameraswitch),
          ),
        );
      },
    );
  }
}
