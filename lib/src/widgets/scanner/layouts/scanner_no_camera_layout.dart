import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Shown when no camera is available
class ScannerNoCameraLayout extends StatelessWidget {
  ///
  const ScannerNoCameraLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: Dimens.paddingMediumSmall,
      children: [
        const NoCameraIcon(),
        Flexible(
          child: Text(
            BasfComponentsLocalizations.of(context).cameraNotAvailable,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
