import 'package:flutter/material.dart';

/// Scan text
class ScanSupportText extends StatelessWidget {
  ///
  const ScanSupportText({
    this.scanQRorBarcode = 'Scan QR or Barcode',
    super.key,
  });

  /// "Scan QR or Barcode"
  final String scanQRorBarcode;

  @override
  Widget build(BuildContext context) {
    return Text(
      scanQRorBarcode,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
    );
  }
}
