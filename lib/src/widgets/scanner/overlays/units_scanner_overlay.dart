import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/camera_edge.dart';
import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/scan_support_text.dart';
import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/toggle_flash_icon_button.dart';
import 'package:flutter/material.dart';

/// Overlay which shows next expected scan
class UnitsScannerOverlay extends StatelessWidget {
  ///
  const UnitsScannerOverlay({
    required this.nextScanText,
    this.topLayout,
    this.scanQRorBarcodeText = 'Scan QR or Barcode',
    super.key,
  });

  /// "Process order number"
  final Widget? topLayout;
  /// "Scan QR or Barcode"
  final String scanQRorBarcodeText;
  /// "SSCC"
  final String nextScanText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        horizontalBlackOut(
          child: topLayout != null ? topLayout! : const SizedBox(),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: CameraEdges(),
          ),
        ),
        horizontalBlackOut(child: bottomLayout()),
      ],
    );
  }

  /// Top part
  Widget bottomLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: nexScanInfo(),
        ),
        ScanSupportText(scanQRorBarcode: scanQRorBarcodeText),
        const ToggleFlashIconButton(),
      ],
    );
  }

  /// Next scan item text
  Widget nexScanInfo() {
    return Text(nextScanText,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.4),
      ),
    );
  }

  /// Blackout area
  Widget horizontalBlackOut({required Widget child}) {
    return Container(
      constraints: const BoxConstraints(minHeight: 30),
      color: Colors.black.withValues(alpha: 0.6),
      child: child,
    );
  }

}
