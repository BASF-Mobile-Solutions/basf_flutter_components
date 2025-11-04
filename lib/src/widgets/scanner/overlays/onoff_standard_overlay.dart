import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/enable_disable_camera_icon_button.dart';
import 'package:flutter/material.dart';

/// Overlay which can disable camera
class OnOffStandardScannerOverlay extends StatelessWidget {
  ///
  const OnOffStandardScannerOverlay({
    super.key,
    this.scanQRorBarcode,
  });

  /// "Scan QR or Barcode"
  final String? scanQRorBarcode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ScannerBlackoutSquare(),
        Positioned(
          bottom: 5,
          left: 3,
          right: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const EnableDisableCameraIconButton(),
              ScanSupportText(
                scanQRorBarcode:
                    scanQRorBarcode ??
                    BasfComponentsLocalizations.of(context).scanQRorBarcode,
              ),
              const ToggleFlashIconButton(),
            ],
          ),
        ),
      ],
    );
  }
}
