import 'dart:async';

import 'package:basf_flutter_components/basf_flutter_components.dart';
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
  static const _cameraPreviewFadeDuration = Duration(milliseconds: 320);
  static const _cameraPlaceholderFadeDuration = Duration(milliseconds: 220);
  static const _cameraLoaderFadeDuration = Duration(milliseconds: 180);
  static const _cameraLoaderShowDelay = Duration(milliseconds: 220);
  static const _cooldownOverlayShowDelay = Duration(milliseconds: 500);
  static const _errorSnackDuration = Duration(milliseconds: 1700);
  static const _errorVibrationGap = Duration(milliseconds: 100);
  static const _cameraStartRetryDelay = Duration(milliseconds: 100);
  static const _cameraStartMaxAttempts = 20;
  static const _cameraControllerRecreateMaxAttempts = 1;

  late final ScannerCubit scannerCubit;
  late final ValueNotifier<bool> codeScannedNotifier;
  late final ValueNotifier<bool> coolDownVisibilityNotifier;
  late final ValueNotifier<bool> cameraStartupOverlayVisibleNotifier;
  late final ValueNotifier<bool> cameraStartupLoaderVisibleNotifier;

  int _cameraStartRequestId = 0;
  int _routeTransitionRequestId = 0;
  Timer? _routeResumeTimer;
  Timer? _cameraLoaderTimer;
  MobileScannerController? _observedCameraController;

  /// To prevent disable/enable cooldown restart when it's active
  DateTime? coolDownEndTime;

  @override
  void initState() {
    super.initState();
    scannerCubit = context.read<ScannerCubit>();
    codeScannedNotifier = ValueNotifier(false);
    coolDownVisibilityNotifier = ValueNotifier(false);
    cameraStartupOverlayVisibleNotifier = ValueNotifier(
      scannerCubit.state is ScannerEnabled,
    );
    cameraStartupLoaderVisibleNotifier = ValueNotifier(false);
    scannerCubit.cameraControllerRevision.addListener(_handleControllerRevisionChanged);
    _attachCameraControllerListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      switch (scannerCubit.state) {
        case ScannerEnabled():
          _scheduleSafeStartCamera();
        case ScannerDisabled():
          _scheduleSafeStopCamera();
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
    _cameraLoaderTimer?.cancel();
    scannerCubit.cameraControllerRevision.removeListener(_handleControllerRevisionChanged);
    _observedCameraController?.removeListener(_updateCameraStartupUi);
    unawaited(_safeStopCamera());
    codeScannedNotifier.dispose();
    coolDownVisibilityNotifier.dispose();
    cameraStartupOverlayVisibleNotifier.dispose();
    cameraStartupLoaderVisibleNotifier.dispose();
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
        _updateCameraStartupUi();
        switch (state) {
          case ScannerEnabled():
            _scheduleSafeStartCamera();
          case ScannerDisabled():
            _scheduleSafeStopCamera();
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
    if (!constraints.maxWidth.isFinite) return _scannerMaxWidth;
    return constraints.maxWidth;
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
      onPressed: _onRescanPressed,
    );
  }

  void _onRescanPressed() {
    codeScannedNotifier.value = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || codeScannedNotifier.value) return;

      unawaited(_restartCameraAfterRescan());
    });
  }

  Future<void> _restartCameraAfterRescan() async {
    await _safeStopCamera();
    if (!mounted || codeScannedNotifier.value) return;
    if (scannerCubit.state is! ScannerEnabled) return;

    await _safeStartCamera();
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
                if (controllerState.error == null) const ColoredBox(color: Colors.black),
                AnimatedOpacity(
                  opacity: controllerState.isRunning || controllerState.error != null ? 1 : 0,
                  duration: _cameraPreviewFadeDuration,
                  curve: Curves.easeOutCubic,
                  child: MobileScanner(
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
                        MobileScannerErrorCode.permissionDenied =>
                          const ScannerNoPermissionLayout(),
                        MobileScannerErrorCode.controllerAlreadyInitialized ||
                        MobileScannerErrorCode.controllerInitializing ||
                        MobileScannerErrorCode.controllerNotAttached => const SizedBox.shrink(),
                        _ => ScannerDefaultErrorLayout(
                          message: error.errorCode.message,
                        ),
                      };
                    },
                  ),
                ),
                Positioned.fill(
                  child: ValueListenableBuilder(
                    valueListenable: cameraStartupOverlayVisibleNotifier,
                    builder: (context, overlayVisible, _) {
                      return IgnorePointer(
                        ignoring: !overlayVisible,
                        child: AnimatedOpacity(
                          opacity: overlayVisible ? 1 : 0,
                          duration: _cameraPlaceholderFadeDuration,
                          curve: Curves.easeOutCubic,
                          child: ValueListenableBuilder(
                            valueListenable: cameraStartupLoaderVisibleNotifier,
                            builder: (context, loaderVisible, _) {
                              return cameraStartupPlaceholder(
                                context,
                                showLoader: loaderVisible,
                              );
                            },
                          ),
                        ),
                      );
                    },
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

  Widget cameraStartupPlaceholder(
    BuildContext context, {
    required bool showLoader,
  }) {
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 120, maxHeight: 120),
              child: BasfAssets.images.basfLogo.image(
                fit: BoxFit.contain,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.72),
            child: AnimatedOpacity(
              opacity: showLoader ? 1 : 0,
              duration: _cameraLoaderFadeDuration,
              curve: Curves.easeOut,
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleControllerRevisionChanged() {
    _attachCameraControllerListener();
    _updateCameraStartupUi();
  }

  void _scheduleSafeStartCamera() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(_safeStartCamera());
    });
  }

  void _scheduleSafeStopCamera() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_safeStopCamera());
    });
  }

  void _attachCameraControllerListener() {
    final controller = scannerCubit.cameraController;
    if (identical(_observedCameraController, controller)) return;

    _observedCameraController?.removeListener(_updateCameraStartupUi);
    _observedCameraController = controller;
    controller.addListener(_updateCameraStartupUi);
  }

  void _updateCameraStartupUi() {
    if (!mounted) return;

    final controllerState = scannerCubit.cameraController.value;
    final showOverlay = _shouldShowCameraStartupPlaceholder(controllerState);

    if (cameraStartupOverlayVisibleNotifier.value != showOverlay) {
      cameraStartupOverlayVisibleNotifier.value = showOverlay;
    }

    _cameraLoaderTimer?.cancel();

    if (!showOverlay || !controllerState.isStarting) {
      if (cameraStartupLoaderVisibleNotifier.value) {
        cameraStartupLoaderVisibleNotifier.value = false;
      }
      return;
    }

    if (cameraStartupLoaderVisibleNotifier.value) return;

    _cameraLoaderTimer = Timer(_cameraLoaderShowDelay, () {
      if (!mounted) return;
      if (!_shouldShowCameraStartupPlaceholder(scannerCubit.cameraController.value)) {
        return;
      }

      if (scannerCubit.cameraController.value.isStarting) {
        cameraStartupLoaderVisibleNotifier.value = true;
      }
    });
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
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    Widget image = BasfAssets.images.basfLogo.image(
      fit: BoxFit.contain,
      color: primaryColor,
    );

    if (widget.overlay is OnOffStandardScannerOverlay) {
      return Center(
        child: InkWell(
          onTap: () => context.read<ScannerCubit>().enableCamera(save: true),
          child: Container(
            width: 224,
            height: 70,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.04),
              border: Border.all(
                color: primaryColor.withValues(alpha: 0.14),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.paddingLarge,
                      vertical: Dimens.paddingMedium,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 96,
                        height: 44,
                        child: image,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 64,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: primaryColor.withValues(alpha: 0.14),
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

      await scannerCubit.cameraController.start().catchError((_) => null);

      if (!mounted || requestId != _cameraStartRequestId) return;

      MobileScannerState controllerState = scannerCubit.cameraController.value;
      MobileScannerErrorCode? errorCode = controllerState.error?.errorCode;

      if (controllerState.isRunning && errorCode == null) return;

      bool canRetry = _canRetryCameraStart(controllerState);

      if (!canRetry) break;

      await Future<void>.delayed(_cameraStartRetryDelay);
    }

    if (!mounted || requestId != _cameraStartRequestId) return;
    if (scannerCubit.state is! ScannerEnabled) return;
    if (recreateAttempt >= _cameraControllerRecreateMaxAttempts) return;
    if (!_canRetryCameraStart(scannerCubit.cameraController.value)) return;

    await scannerCubit.recreateCameraController();

    if (!mounted || requestId != _cameraStartRequestId) return;

    await Future<void>.delayed(_cameraStartRetryDelay);
    return _safeStartCamera(recreateAttempt: recreateAttempt + 1);
  }

  bool _canRetryCameraStart(MobileScannerState controllerState) {
    final errorCode = controllerState.error?.errorCode;
    return controllerState.isStarting ||
        errorCode == MobileScannerErrorCode.controllerAlreadyInitialized ||
        errorCode == MobileScannerErrorCode.controllerInitializing ||
        errorCode == MobileScannerErrorCode.controllerNotAttached;
  }
}
