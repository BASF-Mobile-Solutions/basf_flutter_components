import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Toggle flashlight icon button
class ToggleFlashIconButton extends StatelessWidget {
  ///
  const ToggleFlashIconButton({this.size = 28, super.key});

  ///
  final double size;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScannerCubit>();

    return ValueListenableBuilder<TorchState>(
      valueListenable: cubit.flashlightNotifier,
      builder: (context, torchState, _) {
        return IconButton(
          onPressed: cubit.cameraController.toggleTorch,
          color: torchState == TorchState.on
              ? Colors.white.withValues(alpha: 0.9)
              : Colors.white.withValues(alpha: 0.4),
          iconSize: size,
          icon: Icon(
            torchState == TorchState.on
                ? Icons.flash_on_rounded
                : Icons.flash_off_rounded,
          ),
        );
      },
    );
  }
}
