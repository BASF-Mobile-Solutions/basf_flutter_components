import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/scanner/layouts/scanner_default_error_layout.dart';
import 'package:basf_flutter_components/src/widgets/scanner/layouts/scanner_no_camera_layout.dart';
import 'package:basf_flutter_components/src/widgets/scanner/layouts/scanner_no_permission_layout.dart';
import 'package:basf_flutter_components/src/widgets/scanner/widgets/scanner_cool_down.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

/// !!! Read this to setup camera access https://pub.dev/packages/mobile_scanner
/// Main launch logic for scanner
class Scanner extends StatefulWidget {
  ///
  const Scanner({
    required this.onScan,
    this.cooldownSeconds,
    this.overlay,
    this.cameraNotAvailableText = 'Camera is not available',
    this.provideCameraPermissionText = 'Provide camera permission',
    super.key,
  });

  /// Scanner window size
  /// Callback for scanned barcode
  final void Function(String) onScan;
  /// Camera does not stop after scan, just pauses for a period
  final int? cooldownSeconds;
  /// Scanner design
  final Widget? overlay;

  /// < -- Translations
  ///
  final String cameraNotAvailableText;
  ///
  final String provideCameraPermissionText;
  /// Translations -- >

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  late final MobileScannerController cameraController;
  late final ValueNotifier<TorchState> torchController;

  late final ValueNotifier<bool> coolDownVisibilityNotifier;
  late final ValueNotifier<bool> codeScannedNotifier;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController()..addListener(_torchListener);
    torchController = ValueNotifier(cameraController.value.torchState);

    coolDownVisibilityNotifier = ValueNotifier(false);
    codeScannedNotifier = ValueNotifier(false);
  }

  void _torchListener() {
    torchController.value = cameraController.value.torchState;
  }

  @override
  Future<void> dispose() async {
    torchController.dispose();
    coolDownVisibilityNotifier.dispose();
    codeScannedNotifier.dispose();
    super.dispose();
    await cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return scanner(context);
  }

  Widget scanner(BuildContext context) {
    return MobileScanner(
      controller: cameraController,
      errorBuilder: (context, error) {
        return switch (error.errorCode) {
          MobileScannerErrorCode.unsupported ||
          MobileScannerErrorCode.controllerAlreadyInitialized
          => ScannerDefaultErrorLayout(
            message: error.errorCode.message,
          ),
          MobileScannerErrorCode.permissionDenied => ScannerNoPermissionLayout(
            provideCameraPermissionText: widget.provideCameraPermissionText,
          ),
          _ => ScannerDefaultErrorLayout(message: error.errorCode.message),
        };
      },
      overlayBuilder: (context, constrains) {
        return Stack(
          children: [
            if (widget.overlay != null) widget.overlay!,
            if (widget.cooldownSeconds != null) ScannerCoolDown(
              coolDownVisibilityNotifier: coolDownVisibilityNotifier,
              cooldownSeconds: widget.cooldownSeconds ?? 1,
            ),
          ],
        );
      },
      onDetect: (capture) => onDetect(context, capture),
    );
  }

  void onDetect(BuildContext context, BarcodeCapture capture) {
    final valueExists = capture.barcodes.isNotEmpty
        && capture.barcodes.first.rawValue?.isNotEmpty != null;

    if (valueExists) {
      stopCameraAfterScan(context, capture.barcodes.first.rawValue!);
    }
  }

  Future<void> stopCameraAfterScan(BuildContext context, String barcode) async {
    final cooldownIsVisible = coolDownVisibilityNotifier.value;
    final codeScanned = codeScannedNotifier.value;

    if (!cooldownIsVisible && !codeScanned) {
      try {
        widget.onScan(barcode);
        codeScannedNotifier.value = true;
        await vibrate(VibrationPreset.singleShortBuzz);

        if (widget.cooldownSeconds == null) {
          await cameraController.stop();
        } else {
          // TODO(Dima): check why delayed
          await Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              codeScannedNotifier.value = false;
              coolDownVisibilityNotifier.value = true;
            }
          });
        }
      } catch (e) {
        coolDownVisibilityNotifier.value = true;
        await vibrate(VibrationPreset.doubleBuzz);
        if (context.mounted) {
          AppSnackBar.error(message: e.toString())
              .show(context, duration: const Duration(milliseconds: 1700));
        }
      } finally {
        if (widget.cooldownSeconds != null) codeScannedNotifier.value = false;
      }
    }
  }

  Future<void> vibrate(VibrationPreset preset) async {
    if (await Vibration.hasVibrator()) await Vibration.vibrate(preset: preset);
  }
}
