import 'package:basf_flutter_components/src/widgets/scanner/layouts/scanner_default_error_layout.dart';
import 'package:basf_flutter_components/src/widgets/scanner/layouts/scanner_no_camera_layout.dart';
import 'package:basf_flutter_components/src/widgets/scanner/layouts/scanner_no_permission_layout.dart';
import 'package:basf_flutter_components/src/widgets/scanner/widgets/scanner_startup_placeholder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Composes the preview, overlay, errors, and startup placeholder for scanner camera.
class ScannerCameraView extends StatelessWidget {
  const ScannerCameraView({
    required this.cameraControllerRevision,
    required this.cameraController,
    required this.overlay,
    required this.startupOverlayVisibleNotifier,
    required this.startupLoaderVisibleNotifier,
    required this.cameraPreviewFadeDuration,
    required this.cameraPlaceholderFadeDuration,
    required this.cameraLoaderFadeDuration,
    required this.onDetect,
    super.key,
    this.cameraFeedbackOverlay,
  });

  final ValueListenable<int> cameraControllerRevision;
  final MobileScannerController cameraController;
  final Widget overlay;
  final Widget? cameraFeedbackOverlay;
  final ValueListenable<bool> startupOverlayVisibleNotifier;
  final ValueListenable<bool> startupLoaderVisibleNotifier;
  final Duration cameraPreviewFadeDuration;
  final Duration cameraPlaceholderFadeDuration;
  final Duration cameraLoaderFadeDuration;
  final void Function(BarcodeCapture capture) onDetect;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: cameraControllerRevision,
      builder: (context, revision, _) {
        return _buildCameraState(revision);
      },
    );
  }

  Widget _buildCameraState(int revision) {
    return ValueListenableBuilder<MobileScannerState>(
      valueListenable: cameraController,
      builder: (context, controllerState, _) {
        return Stack(
          fit: StackFit.expand,
          children: [
            if (controllerState.error == null) const ColoredBox(color: Colors.black),
            _buildCameraPreview(revision, controllerState),
            _buildStartupOverlay(),
          ],
        );
      },
    );
  }

  Widget _buildCameraPreview(int revision, MobileScannerState controllerState) {
    return AnimatedOpacity(
      opacity: controllerState.isRunning || controllerState.error != null ? 1 : 0,
      duration: cameraPreviewFadeDuration,
      curve: Curves.easeOutCubic,
      child: MobileScanner(
        key: ValueKey(revision),
        controller: cameraController,
        onDetect: onDetect,
        overlayBuilder: (_, _) => _buildScannerOverlay(),
        errorBuilder: (_, error) => _buildErrorLayout(error),
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Stack(
      children: [
        overlay,
        if (cameraFeedbackOverlay case final feedback?) Positioned.fill(child: feedback),
      ],
    );
  }

  Widget _buildErrorLayout(MobileScannerException error) {
    return switch (error.errorCode) {
      MobileScannerErrorCode.unsupported => const ScannerNoCameraLayout(),
      MobileScannerErrorCode.permissionDenied => const ScannerNoPermissionLayout(),
      MobileScannerErrorCode.controllerAlreadyInitialized ||
      MobileScannerErrorCode.controllerInitializing ||
      MobileScannerErrorCode.controllerNotAttached => const SizedBox.shrink(),
      _ => ScannerDefaultErrorLayout(
        message: error.errorCode.message,
      ),
    };
  }

  Widget _buildStartupOverlay() {
    return Positioned.fill(
      child: ValueListenableBuilder<bool>(
        valueListenable: startupOverlayVisibleNotifier,
        builder: (context, overlayVisible, _) {
          return IgnorePointer(
            ignoring: !overlayVisible,
            child: AnimatedOpacity(
              opacity: overlayVisible ? 1 : 0,
              duration: cameraPlaceholderFadeDuration,
              curve: Curves.easeOutCubic,
              child: _buildStartupLoader(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStartupLoader() {
    return ValueListenableBuilder<bool>(
      valueListenable: startupLoaderVisibleNotifier,
      builder: (context, loaderVisible, _) {
        return ScannerStartupPlaceholder(
          showLoader: loaderVisible,
          loaderFadeDuration: cameraLoaderFadeDuration,
        );
      },
    );
  }
}
