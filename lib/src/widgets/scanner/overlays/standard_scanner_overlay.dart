import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/scanner_blackout_square.dart';
import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/standard_bottom_actions.dart';
import 'package:flutter/material.dart';

/// Standard overlay for scanner
class StandardScannerOverlay extends StatelessWidget {
  ///
  const StandardScannerOverlay({
    super.key,
    this.scanQRorBarcode = 'Scan QR or Barcode',
  });

  /// "Scan QR or Barcode"
  final String scanQRorBarcode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ScannerBlackoutSquare(),
        Positioned(
          bottom: 5,
          left: 3,
          right: 3,
          child: StandardBottomActions(scanQRorBarcode: scanQRorBarcode),
        ),
      ],
    );
  }
}
