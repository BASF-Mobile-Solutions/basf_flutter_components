import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Toggle flashlight icon button
class ToggleDirectionIconButton extends StatefulWidget {
  ///
  const ToggleDirectionIconButton({
    this.size = 28,
    super.key,
  });

  ///
  final double size;

  @override
  State<ToggleDirectionIconButton> createState()
    => _ToggleDirectionIconButtonState();
}

class _ToggleDirectionIconButtonState extends State<ToggleDirectionIconButton> {
  bool _isBackCamera = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScannerCubit>();

    return ValueListenableBuilder<CameraFacing>(
      valueListenable: cubit.directionNotifier,
      builder: (context, facing, _) {
        return IconButton(
          onPressed: () {
            cubit.cameraController.switchCamera();
            _isBackCamera = !_isBackCamera;
          },
          color: Colors.white.withValues(alpha: 0.4),
          iconSize: widget.size,
          icon: AnimatedRotation(
            duration: const Duration(milliseconds: 200),
            turns: _isBackCamera ? 0 : -0.5,
            child: const Icon(Icons.cameraswitch),
          ),
        );
      },
    );
  }
}
