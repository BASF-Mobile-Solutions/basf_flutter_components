import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/blackout.dart';
import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/scan_support_text.dart';
import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/toggle_direction_icon.dart';
import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/toggle_flash_icon_button.dart';
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
        const Blackout(),
        Positioned(
          bottom: 5,
          left: 3,
          right: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ToggleDirectionIconButton(),
              ScanSupportText(scanQRorBarcode: scanQRorBarcode),
              const ToggleFlashIconButton(),
            ],
          ),
        ),
      ],
    );
  }
}
