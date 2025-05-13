import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/scanner/widgets/no_camera_icon.dart';
import 'package:flutter/material.dart';

/// Shown when no camera is available
class ScannerNoCameraLayout extends StatelessWidget {
  ///
  const ScannerNoCameraLayout({
    required this.cameraNotAvailableText,
    super.key,
  });

  /// "Camera is not available"
  final String cameraNotAvailableText;

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
            cameraNotAvailableText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
