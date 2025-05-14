import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  bool isBig = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          cameraSizeButton(),
          cameraIconButton(),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: MediaQuery.sizeOf(context).height * (isBig ? 0.4 : 0.2),
        child: Scanner(
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
            ScannerEnabled() => const Icon(Icons.camera_alt),
            ScannerDisabled() => const Icon(Icons.no_photography),
          },
        );
      },
    );
  }

  Widget cameraSizeButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          isBig = !isBig;
        });
      },
      icon: Icon(isBig
          ? Icons.photo_size_select_large
          : Icons.photo_size_select_small,
      ),
    );
  }
}
