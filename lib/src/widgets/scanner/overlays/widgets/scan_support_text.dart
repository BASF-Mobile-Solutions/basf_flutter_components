import 'package:basf_flutter_components/l10n/localizations/basf_components_localizations.dart';
import 'package:flutter/material.dart';

/// Scan text
class ScanSupportText extends StatelessWidget {
  ///
  const ScanSupportText({
    this.scanQRorBarcode,
    super.key,
  });

  /// "Scan QR or Barcode"
  final String? scanQRorBarcode;

  @override
  Widget build(BuildContext context) {
    return Text(
      scanQRorBarcode ??
          BasfComponentsLocalizations.of(context).scanQRorBarcode,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
    );
  }
}
