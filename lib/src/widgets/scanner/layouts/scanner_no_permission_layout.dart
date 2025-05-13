import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Layout for no permission to use camera
class ScannerNoPermissionLayout extends StatelessWidget {
  ///
  const ScannerNoPermissionLayout({
    required this.provideCameraPermissionText,
    super.key,
  });

  /// "Provide camera permission"
  final String provideCameraPermissionText;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Dimens.paddingDefault,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        noCameraIcon(context),
        BasfTextButton.transparent(
          text: provideCameraPermissionText,
          onPressed: checkPermissionOrOpenSettings,
        ),
      ],
    );
  }

  ///
  Widget noCameraIcon(BuildContext context) {
    return Icon(
      Icons.no_photography_outlined,
      size: 30,
      color: Theme.of(context).primaryColor,
    );
  }

  ///
  Future<void> checkPermissionOrOpenSettings() async {
    if (!await Permission.camera.request().isGranted) await openAppSettings();
  }
}
