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
  static const _scannerMaxWidth = 500.0;
  static const _scannerMinHeight = 170.0;
  static const _routeResumeDelay = Duration(milliseconds: 500);
  static const _scanResultSwitchDuration = Duration(milliseconds: 500);
  static const _successIconFadeDuration = Duration(milliseconds: 200);
  static const _cooldownOverlayShowDelay = Duration(milliseconds: 500);
  static const _errorSnackDuration = Duration(milliseconds: 1700);
  static const _errorVibrationGap = Duration(milliseconds: 100);
  static const _cameraStartRetryDelay = Duration(milliseconds: 100);
  static const _cameraStartAttemptTimeout = Duration(seconds: 2);
  static const _cameraStartMaxAttempts = 20;
  static const _cameraControllerRecreateMaxAttempts = 1;

  late final ScannerCubit scannerCubit;
  late final ValueNotifier<bool> codeScannedNotifier;
  late final ValueNotifier<bool> coolDownVisibilityNotifier;

  int _cameraStartRequestId = 0;
  int _routeTransitionRequestId = 0;
  Timer? _routeResumeTimer;

  /// To prevent disable/enable cooldown restart when it's active
  DateTime? coolDownEndTime;

  @override
  void initState() {
    super.initState();
    scannerCubit = context.read<ScannerCubit>();
    codeScannedNotifier = ValueNotifier(false);
    coolDownVisibilityNotifier = ValueNotifier(false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      switch (scannerCubit.state) {
        case ScannerEnabled():
          unawaited(_safeStartCamera());
        case ScannerDisabled():
          unawaited(_safeStopCamera());
      }
    });
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
    unawaited(_safeStopCamera());
    codeScannedNotifier.dispose();
    coolDownVisibilityNotifier.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    // we're covered by a new route
    _invalidatePendingRouteResume();
    scannerCubit.disableCamera(save: false, automatic: true);
  }

  @override
  void didPopNext() {
    // the covering route went away
    int requestId = _resetRouteResumeTimer();
    _routeResumeTimer = Timer(_routeResumeDelay, () {
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
            unawaited(_safeStartCamera());
          case ScannerDisabled():
            unawaited(_safeStopCamera());
        }
      },
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: _scannerWidth(constraints),
              height: _scannerHeight(constraints),
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

  double _scannerWidth(BoxConstraints constraints) {
    bool exceedsMaxWidth = constraints.maxWidth > _scannerMaxWidth;
    return constraints.maxWidth.isFinite && exceedsMaxWidth
        ? constraints.maxWidth
        : _scannerMaxWidth;
  }

  double _scannerHeight(BoxConstraints constraints) {
    bool exceedsMaxHeight = constraints.maxHeight > _scannerMinHeight;
    return constraints.maxHeight.isFinite && exceedsMaxHeight
        ? constraints.maxHeight
        : _scannerMinHeight;
  }

  Widget scanner() {
    return ValueListenableBuilder(
      valueListenable: codeScannedNotifier,
      builder: (context, scanned, _) {
        return AnimatedSwitcher(
          duration: _scanResultSwitchDuration,
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
    return ValueListenableBuilder(
      valueListenable: scannerCubit.cameraControllerRevision,
      builder: (context, revision, _) {
        return ValueListenableBuilder<MobileScannerState>(
          valueListenable: scannerCubit.cameraController,
          builder: (context, controllerState, _) {
            return Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(
                  key: ValueKey(revision),
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
                      MobileScannerErrorCode.unsupported => const ScannerNoCameraLayout(),
                      MobileScannerErrorCode.permissionDenied => const ScannerNoPermissionLayout(),
                      MobileScannerErrorCode.controllerAlreadyInitialized ||
                      MobileScannerErrorCode.controllerInitializing ||
                      MobileScannerErrorCode.controllerNotAttached => cameraStartupPlaceholder(
                        context,
                        loading: true,
                      ),
                      _ => ScannerDefaultErrorLayout(
                        message: error.errorCode.message,
                      ),
                    };
                  },
                ),
                if (_shouldShowCameraStartupPlaceholder(controllerState))
                  Positioned.fill(
                    child: cameraStartupPlaceholder(
                      context,
                      loading: controllerState.isStarting,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  bool _shouldShowCameraStartupPlaceholder(MobileScannerState controllerState) {
    if (scannerCubit.state is! ScannerEnabled) return false;
    if (controllerState.error != null) return false;

    return controllerState.isStarting ||
        (!controllerState.isRunning && codeScannedNotifier.value == false);
  }

  Widget cameraStartupPlaceholder(BuildContext context, {required bool loading}) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Dimens.paddingMedium,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 120, maxHeight: 120),
              child: BasfAssets.images.basfLogo.image(
                fit: BoxFit.contain,
                color: Colors.white,
              ),
            ),
            if (loading)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              ),
          ],
        ),
      ),
    );
  }

  void onDetect(BuildContext context, BarcodeCapture capture) {
    if (capture.barcodes.isEmpty) return;

    String? rawValue = capture.barcodes.first.rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    unawaited(stopCameraAfterScan(context, rawValue));
  }

  Future<void> stopCameraAfterScan(BuildContext context, String barcode) async {
    // Continue only if camera is ready for next scan
    if (codeScannedNotifier.value || coolDownVisibilityNotifier.value) return;
    if (mounted) codeScannedNotifier.value = true;

    try {
      widget.onScan(barcode);
      await HapticFeedback.vibrate();
      if (widget.cooldownSeconds != null) await enableCooldown();
    } catch (e) {
      final msg = e.toString();
      for (var i = 0; i < 3; i++) {
        await HapticFeedback.vibrate();
        await Future<void>.delayed(_errorVibrationGap);
      }

      if (context.mounted) {
        AppSnackBar.error(
          message: msg,
        ).show(context, duration: _errorSnackDuration);
      }
      if (widget.cooldownSeconds != null) await enableCooldown();
    }
  }

  Future<void> enableCooldown() async {
    await Future<void>.delayed(_cooldownOverlayShowDelay);
    if (mounted) {
      coolDownVisibilityNotifier.value = true;
      coolDownEndTime ??= DateTime.now().add(
        Duration(seconds: widget.cooldownSeconds!),
      );
    }

    // Turn scanning back after cooldown
    await Future<void>.delayed(Duration(seconds: widget.cooldownSeconds!));
    if (mounted) {
      codeScannedNotifier.value = false;
      coolDownVisibilityNotifier.value = false;
      coolDownEndTime = null;
    }
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
              duration: _successIconFadeDuration,
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
    Widget image = BasfAssets.images.basfLogo.image(
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

  void _invalidatePendingRouteResume() {
    _routeTransitionRequestId++;
    _routeResumeTimer?.cancel();
    _routeResumeTimer = null;
  }

  int _resetRouteResumeTimer() {
    _invalidatePendingRouteResume();
    return _routeTransitionRequestId;
  }

  Future<void> _safeStopCamera() async {
    _cameraStartRequestId++;
    await scannerCubit.cameraController.stop().catchError((_) => null);
  }

  Future<void> _safeStartCamera({int recreateAttempt = 0}) async {
    final requestId = recreateAttempt == 0 ? ++_cameraStartRequestId : _cameraStartRequestId;

    for (int attempt = 0; attempt < _cameraStartMaxAttempts; attempt++) {
      if (!mounted || requestId != _cameraStartRequestId) return;
      if (scannerCubit.state is! ScannerEnabled) return;

      await scannerCubit.cameraController
          .start()
          .timeout(_cameraStartAttemptTimeout)
          .catchError((_) => null);

      if (!mounted || requestId != _cameraStartRequestId) return;

      MobileScannerState controllerState = scannerCubit.cameraController.value;
      MobileScannerErrorCode? errorCode = controllerState.error?.errorCode;

      if (controllerState.isRunning && errorCode == null) return;

      bool canRetry =
          controllerState.isStarting ||
          errorCode == MobileScannerErrorCode.controllerAlreadyInitialized ||
          errorCode == MobileScannerErrorCode.controllerInitializing ||
          errorCode == MobileScannerErrorCode.controllerNotAttached;

      if (!canRetry) break;

      await Future<void>.delayed(_cameraStartRetryDelay);
    }

    if (!mounted || requestId != _cameraStartRequestId) return;
    if (scannerCubit.state is! ScannerEnabled) return;
    if (recreateAttempt >= _cameraControllerRecreateMaxAttempts) return;

    await scannerCubit.recreateCameraController();

    if (!mounted || requestId != _cameraStartRequestId) return;

    await Future<void>.delayed(_cameraStartRetryDelay);
    return _safeStartCamera(recreateAttempt: recreateAttempt + 1);
  }
}
