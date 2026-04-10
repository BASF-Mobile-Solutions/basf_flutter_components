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
        _buildSuccessInfo(context),
        _buildRescanButton(context),
      ],
    );
  }

  Widget _buildRescanButton(BuildContext context) {
    return BasfTextButton.transparent(
      text: BasfComponentsLocalizations.of(context).rescan,
      onPressed: onPressed,
    );
  }

  Widget _buildSuccessInfo(BuildContext context) {
    return Column(
      children: [
        const SuccessAnimatedIcon(),
        VerticalSpacer.normal(),
        _buildSuccessMessage(context),
      ],
    );
  }

  Widget _buildSuccessMessage(BuildContext context) {
    return Text(
      BasfComponentsLocalizations.of(context).codeScanSuccessPhrase,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: BasfColors.copyTextGrey),
    );
  }
}
