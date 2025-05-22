import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/animations/success_animation.dart';
import 'package:flutter/material.dart';

/// Shown after scan if no cooldown
class ScannerSuccessLayout extends StatelessWidget {
  ///
  const ScannerSuccessLayout({
    required this.rescanText,
    required this.codeScanSuccessText,
    required this.onPressed,
    super.key,
  });

  /// "Rescan"
  final String rescanText;

  /// "Code scanned successfully"
  final String codeScanSuccessText;

  /// On pressed
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        successInfo(context),
        BasfTextButton.transparent(text: rescanText, onPressed: onPressed),
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
          codeScanSuccessText,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: BasfColors.copyTextGrey),
        ),
      ],
    );
  }
}
