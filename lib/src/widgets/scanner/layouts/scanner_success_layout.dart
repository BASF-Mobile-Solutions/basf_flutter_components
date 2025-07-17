import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Shown after scan if no cooldown
class ScannerSuccessLayout extends StatelessWidget {
  ///
  const ScannerSuccessLayout({
    required this.onPressed,
    super.key,
  });

  /// On pressed
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        successInfo(context),
        BasfTextButton.transparent(
          text: BasfComponentsLocalizations.of(context).rescan,
          onPressed: onPressed,
        ),
      ],
    );
  }

  /// Success animation and text
  Widget successInfo(BuildContext context) {
    return Column(
      children: [
        const SuccessAnimation(),
        VerticalSpacer.normal(),
        Text(
          BasfComponentsLocalizations.of(context).codeScanSuccessPhrase,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: BasfColors.copyTextGrey),
        ),
      ],
    );
  }
}
