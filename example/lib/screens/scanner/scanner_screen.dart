import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
}
