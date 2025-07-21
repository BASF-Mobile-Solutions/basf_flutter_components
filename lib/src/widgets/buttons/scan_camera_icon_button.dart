import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Scanner camera icon button
class ScanCameraIconButton extends StatelessWidget {
  /// Scanner camera icon button
  const ScanCameraIconButton({
    required this.scannerCubit,
    required this.scanCameraVisNotifier,
    super.key,
  });

  /// Scanner cubit
  final ScannerCubit scannerCubit;

  /// Scanner camera visibility notifier
  final ValueNotifier<bool>? scanCameraVisNotifier;

  @override
  Widget build(BuildContext context) {
    return scanCameraButton();
  }

  /// Scanner camera icon button
  Widget scanCameraButton() {
    return BlocBuilder<ScannerCubit, ScannerState>(
      bloc: scannerCubit,
      builder: (context, state) {
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          crossFadeState: switch (state) {
            ScannerEnabled() => CrossFadeState.showFirst,
            ScannerDisabled() => CrossFadeState.showSecond,
          },
          firstChild: IconButton(
            onPressed: () {
              context.read<ScannerCubit>().disableCamera();
              if (scanCameraVisNotifier != null) {
                scanCameraVisNotifier!.value = false;
              }
            },
            icon: const Icon(Icons.camera_alt),
          ),
          secondChild: IconButton(
            onPressed: () {
              if (scanCameraVisNotifier != null) {
                scanCameraVisNotifier!.value = true;
              }
              context.read<ScannerCubit>().enableCamera();
            },
            iconSize: 22,
            icon: const Icon(Icons.no_photography),
          ),
        );
      },
    );
  }
}
