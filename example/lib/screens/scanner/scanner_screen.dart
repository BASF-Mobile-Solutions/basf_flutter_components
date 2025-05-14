import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          cameraIconButton(),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: Scanner(
          cooldownSeconds: 2,
          onScan: (barcode) {
            AppSnackBar.info(message: barcode).show(context);
          },
        ),
      ),
    );
  }

  Widget cameraIconButton() {
    return BlocBuilder<ScannerCubit, ScannerState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            final cubit = context.read<ScannerCubit>();
            switch(state) {
              case ScannerEnabled(): cubit.disableCamera();
              case ScannerDisabled(): cubit.enableCamera();
            }
          },
          icon: switch(state) {
            ScannerEnabled() => const Icon(Icons.no_photography),
            ScannerDisabled() => const Icon(Icons.camera_alt),
          },
        );
      },
    );
  }
}
