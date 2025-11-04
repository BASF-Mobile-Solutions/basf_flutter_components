import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Toggle flashlight icon button
class EnableDisableCameraIconButton extends StatefulWidget {
  ///
  const EnableDisableCameraIconButton({this.size = 27, super.key});

  ///
  final double size;

  @override
  State<EnableDisableCameraIconButton> createState() =>
      _EnableDisableCameraIconButtonState();
}

class _EnableDisableCameraIconButtonState
    extends State<EnableDisableCameraIconButton> {
  bool cameraIsActive = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        cameraIsActive
            ? Icons.no_photography_outlined
            : Icons.camera_alt_outlined,
      ),
      iconSize: widget.size,
      color: Colors.white.withValues(alpha: 0.4),
      onPressed: () async {
        cameraIsActive
            ? await context.read<ScannerCubit>().cameraController.stop()
            : await context.read<ScannerCubit>().cameraController.start();
        setState(() {
          cameraIsActive = !cameraIsActive;
        });
      },
    );
  }
}
