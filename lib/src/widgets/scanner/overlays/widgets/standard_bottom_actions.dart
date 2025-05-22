import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/scan_support_text.dart';
import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/toggle_direction_icon.dart';
import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/toggle_flash_icon_button.dart';
import 'package:flutter/material.dart';

/// Standard bottom actions
class StandardBottomActions extends StatelessWidget {
  ///
  const StandardBottomActions({required this.scanQRorBarcode, super.key});

  ///
  final String scanQRorBarcode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ToggleDirectionIconButton(),
        ScanSupportText(scanQRorBarcode: scanQRorBarcode),
        const ToggleFlashIconButton(),
      ],
    );
  }
}
