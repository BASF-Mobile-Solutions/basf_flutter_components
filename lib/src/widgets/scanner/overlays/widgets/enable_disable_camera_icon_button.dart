import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Toggle flashlight icon button
class EnableDisableCameraIconButton extends StatelessWidget {
  ///
  const EnableDisableCameraIconButton({this.size = 27, super.key});

  ///
  final double size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerCubit, ScannerState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            state is ScannerEnabled ? Icons.no_photography_outlined : Icons.camera_alt_outlined,
          ),
          iconSize: size,
          color: state is ScannerEnabled ? Colors.white.withValues(alpha: 0.4) : null,
          onPressed: () async {
            state is ScannerEnabled
                ? context.read<ScannerCubit>().disableCamera(save: true)
                : context.read<ScannerCubit>().enableCamera(save: true);
          },
        );
      },
    );
  }
}
