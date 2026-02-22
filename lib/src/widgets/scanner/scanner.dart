import 'dart:async';

import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/enable_disable_camera_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// !!! Read this to setup camera access https://pub.dev/packages/mobile_scanner
/// !!! Requires [ScannerCubit] to be provided above this widget
/// [HydratedStorage] must also be initialized on app launch
/// Main launch logic for scanner
class Scanner extends StatefulWidget {
  ///
  const Scanner({
    required this.onScan,
    required this.routeObserver,
    this.cooldownSeconds,
    this.overlay = const StandardScannerOverlay(),
    this.offlinePlaceholder,
    super.key,
  });

  /// Scanner window size
  /// Callback for scanned barcode
  final void Function(String) onScan;

  /// Camera does not stop after scan, just pauses for a period
  final int? cooldownSeconds;

  /// Scanner design
  final Widget overlay;

  /// Shows when camera is off
  final Widget? offlinePlaceholder;

  /// Auto closes the scanner when it's not on the top screen in the stack
  final RouteObserver<ModalRoute<void>>? routeObserver;

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> with RouteAware {
  late final ScannerCubit scannerCubit;
  late final ValueNotifier<bool> codeScannedNotifier;
  late final ValueNotifier<bool> coolDownVisibilityNotifier;
  int _cameraStartRequestId = 0;
  Timer? _routeResumeTimer;
  int _routeTransitionRequestId = 0;

  /// To prevent disable/enable cooldown restart when it's active
  DateTime? coolDownEndTime;

  @override
  void initState() {
    super.initState();
    scannerCubit = context.read<ScannerCubit>();
    codeScannedNotifier = ValueNotifier(false);
    coolDownVisibilityNotifier = ValueNotifier(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final obs = widget.routeObserver;
    final route = ModalRoute.of(context);
    if (obs != null && route is PageRoute) obs.subscribe(this, route);
  }

  @override
  void dispose() {
    // only unsubscribe if we previously subscribed
    widget.routeObserver?.unsubscribe(this);
    _routeResumeTimer?.cancel();
    codeScannedNotifier.dispose();
    coolDownVisibilityNotifier.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    // we're covered by a new route
    _routeTransitionRequestId++;
    _routeResumeTimer?.cancel();
    scannerCubit.disableCamera(save: false, automatic: true);
  }

  @override
  void didPopNext() {
    // the covering route went away
    final requestId = ++_routeTransitionRequestId;
    _routeResumeTimer?.cancel();
    _routeResumeTimer = Timer(const Duration(milliseconds: 500), () {
      if (!mounted || requestId != _routeTransitionRequestId) return;
      if (ModalRoute.of(context)?.isCurrent != true) return;
      scannerCubit.enableCamera(save: false, automatic: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScannerCubit, ScannerState>(
      bloc: scannerCubit,
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        switch (state) {
          case ScannerEnabled():
            unawaited(
              _safeStartCamera(
                errorContext: 'while starting scanner after enabling',
              ),
            );
          case ScannerDisabled():
            unawaited(
              _safeStopCamera(
                errorContext: 'while stopping scanner after disabling',
              ),
            );
        }
      },
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: getWidth(constraints),
              height: getHeight(constraints),
              child: IndexedStack(
                index: state is ScannerEnabled ? 0 : 1,
                children: [
                  scanner(),
                  widget.offlinePlaceholder ?? basfLogo(context),
                ],
              ),
            );
          },
        );
      },
    );
  }

  double getWidth(BoxConstraints constraints) {
    return constraints.maxWidth.isFinite && constraints.maxWidth > 500
        ? constraints.maxWidth
        : 500.0;
  }

  double getHeight(BoxConstraints constraints) {
    return constraints.maxHeight.isFinite && constraints.maxHeight > 170
        ? constraints.maxHeight
        : 170.0;
  }

  Widget scanner() {
    return ValueListenableBuilder(
      valueListenable: codeScannedNotifier,
      builder: (context, scanned, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: scanned && widget.cooldownSeconds == null
              ? successLayout(context)
              : scannerCamera(context),
        );
      },
    );
  }

  Widget successLayout(BuildContext context) {
    return ScannerSuccessLayout(
      onPressed: () => codeScannedNotifier.value = false,
    );
  }

  Widget scannerCamera(BuildContext context) {
    return MobileScanner(
      controller: scannerCubit.cameraController,
      onDetect: (capture) => onDetect(context, capture),
      overlayBuilder: (_, _) {
        return Stack(
          children: [
            widget.overlay,
            if (widget.cooldownSeconds != null) ...[
              Positioned.fill(child: successIcon()),
              Positioned.fill(child: cooldown()),
            ],
          ],
        );
      },
      errorBuilder: (_, error) {
        return switch (error.errorCode) {
          MobileScannerErrorCode.unsupported ||
          MobileScannerErrorCode.controllerAlreadyInitialized =>
            const ScannerNoCameraLayout(),
          MobileScannerErrorCode.permissionDenied =>
            const ScannerNoPermissionLayout(),
          _ => ScannerDefaultErrorLayout(message: error.errorCode.message),
        };
      },
    );
  }

  void onDetect(BuildContext context, BarcodeCapture capture) {
    final valueExists =
        capture.barcodes.isNotEmpty &&
        capture.barcodes.first.rawValue?.isNotEmpty != null;

    if (valueExists) {
      unawaited(stopCameraAfterScan(context, capture.barcodes.first.rawValue!));
    }
  }

  Future<void> stopCameraAfterScan(BuildContext context, String barcode) async {
    // Continue only if camera is ready for next scan
    if (codeScannedNotifier.value || coolDownVisibilityNotifier.value) return;
    if (mounted) codeScannedNotifier.value = true;

    try {
      widget.onScan(barcode);
      await HapticFeedback.vibrate();

      if (widget.cooldownSeconds == null) {
        // Camera is stopped by MobileScanner lifecycle
        // after scanner view switches.
      } else {
        await enableCooldown();
      }
    } catch (e) {
      final msg = e.toString();
      const duration = Duration(milliseconds: 1700);
      for (var i = 0; i < 3; i++) {
        await HapticFeedback.vibrate();
        await Future<void>.delayed(const Duration(milliseconds: 100));
      }

      if (context.mounted) {
        AppSnackBar.error(message: msg).show(context, duration: duration);
      }
      if (widget.cooldownSeconds != null) await enableCooldown();
    }
  }

  Future<void> enableCooldown() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        coolDownVisibilityNotifier.value = true;
        coolDownEndTime ??= DateTime.now().add(
          Duration(seconds: widget.cooldownSeconds!),
        );
      }
    });

    // Turn scanning back after cooldown
    await Future.delayed(Duration(seconds: widget.cooldownSeconds!), () {
      if (mounted) {
        codeScannedNotifier.value = false;
        coolDownVisibilityNotifier.value = false;
        coolDownEndTime = null;
      }
    });
  }

  Widget successIcon() {
    return ValueListenableBuilder(
      valueListenable: coolDownVisibilityNotifier,
      builder: (context, cooldownVisible, _) {
        return ValueListenableBuilder(
          valueListenable: codeScannedNotifier,
          builder: (context, scanned, _) {
            return AnimatedOpacity(
              opacity: scanned && !cooldownVisible ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.check,
                size: 60,
                color: BasfColors.white.withValues(alpha: 0.9),
              ),
            );
          },
        );
      },
    );
  }

  Widget cooldown() {
    return ValueListenableBuilder(
      valueListenable: coolDownVisibilityNotifier,
      builder: (context, visible, _) {
        if (visible) {
          return ScannerCoolDown(
            endTime: coolDownEndTime,
            cooldownSeconds: widget.cooldownSeconds ?? 3,
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget basfLogo(BuildContext context) {
    final image = BasfAssets.images.basfLogo.image(
      fit: BoxFit.contain,
      color: Theme.of(context).primaryColor,
    );

    if (widget.overlay is OnOffStandardScannerOverlay) {
      return Row(
        spacing: Dimens.paddingMedium,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 80, maxHeight: 150),
              child: image,
            ),
          ),
          const EnableDisableCameraIconButton(),
        ],
      );
    }
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 150, maxHeight: 150),
        child: image,
      ),
    );
  }

  Future<void> _safeStopCamera({required String errorContext}) async {
    _cameraStartRequestId++;
    await scannerCubit.cameraController.stop().catchError((_) => null);
  }

  Future<void> _safeStartCamera({required String errorContext}) async {
    final requestId = ++_cameraStartRequestId;
    const retryDelay = Duration(milliseconds: 100);
    const maxAttempts = 20;

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      if (!mounted || requestId != _cameraStartRequestId) return;
      if (scannerCubit.state is! ScannerEnabled) return;

      await scannerCubit.cameraController.start().catchError((_) => null);

      if (!mounted || requestId != _cameraStartRequestId) return;

      final controllerState = scannerCubit.cameraController.value;
      final errorCode = controllerState.error?.errorCode;

      if (controllerState.isRunning && errorCode == null) return;

      final canRetry =
          errorCode == MobileScannerErrorCode.controllerAlreadyInitialized ||
          errorCode == MobileScannerErrorCode.controllerInitializing ||
          errorCode == MobileScannerErrorCode.controllerNotAttached;

      if (!canRetry) return;

      await Future<void>.delayed(retryDelay);
    }
  }
}
