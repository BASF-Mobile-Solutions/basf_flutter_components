import 'dart:async';

import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/scanner/controller/scanner_camera_coordinator.dart';
import 'package:basf_flutter_components/src/widgets/scanner/widgets/scanner_camera_view.dart';
import 'package:basf_flutter_components/src/widgets/scanner/widgets/scanner_offline_placeholder.dart';
import 'package:basf_flutter_components/src/widgets/scanner/widgets/viewport_visibility_listener.dart';
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
  static const _cameraVisibleFractionThreshold = 0.01;
  static const _scannerMaxWidth = 500.0;
  static const _scannerMinHeight = 170.0;

  static const _routeResumeDelay = Duration(milliseconds: 500);
  static const _cameraLoaderShowDelay = Duration(milliseconds: 220);
  static const _cooldownOverlayShowDelay = Duration(milliseconds: 500);

  static const _scanResultSwitchDuration = Duration(milliseconds: 500);
  static const _successIconFadeDuration = Duration(milliseconds: 200);
  static const _cameraPreviewFadeDuration = Duration(milliseconds: 320);
  static const _cameraPlaceholderFadeDuration = Duration(milliseconds: 220);
  static const _cameraLoaderFadeDuration = Duration(milliseconds: 180);

  static const _errorSnackDuration = Duration(milliseconds: 1700);
  static const _errorVibrationGap = Duration(milliseconds: 100);

  late final ScannerCubit scannerCubit;
  late final ScannerCameraCoordinator cameraCoordinator;
  late final ValueNotifier<bool> codeScannedNotifier;
  late final ValueNotifier<bool> coolDownVisibilityNotifier;
  late final ValueNotifier<bool> cameraStartupOverlayVisibleNotifier;
  late final ValueNotifier<bool> cameraStartupLoaderVisibleNotifier;

  int _routeTransitionRequestId = 0;
  bool _isActuallyVisible = true;
  bool _wasScannerEnabled = true;
  Timer? _routeResumeTimer;
  Timer? _cameraLoaderTimer;
  MobileScannerController? _observedCameraController;

  /// To prevent disable/enable cooldown restart when it's active
  DateTime? coolDownEndTime;

  @override
  void initState() {
    super.initState();
    scannerCubit = context.read<ScannerCubit>();
    cameraCoordinator = ScannerCameraCoordinator(
      scannerCubit: scannerCubit,
      isMounted: () => mounted,
      isScannerEnabled: () => scannerCubit.state is ScannerEnabled,
      isActuallyVisible: () => _isActuallyVisible,
      onStartupUiChanged: _updateCameraStartupUi,
    );
    codeScannedNotifier = ValueNotifier(false);
    coolDownVisibilityNotifier = ValueNotifier(false);
    cameraStartupOverlayVisibleNotifier = ValueNotifier(
      scannerCubit.state is ScannerEnabled,
    );
    cameraStartupLoaderVisibleNotifier = ValueNotifier(false);
    _wasScannerEnabled = scannerCubit.state is ScannerEnabled;
    scannerCubit.cameraControllerRevision.addListener(_handleControllerRevisionChanged);
    _attachCameraControllerListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      switch (scannerCubit.state) {
        case ScannerEnabled():
          cameraCoordinator.scheduleSafeStartCamera();
        case ScannerDisabled():
          cameraCoordinator.scheduleSafeStopCamera();
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
    final controller = scannerCubit.cameraController;
    // only unsubscribe if we previously subscribed
    widget.routeObserver?.unsubscribe(this);
    _routeResumeTimer?.cancel();
    _cameraLoaderTimer?.cancel();
    scannerCubit.cameraControllerRevision.removeListener(_handleControllerRevisionChanged);
    _observedCameraController?.removeListener(_updateCameraStartupUi);
    cameraCoordinator.scheduleDetachedControllerStop(controller);
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
    return _buildViewportAwareScanner();
  }

  Widget _buildViewportAwareScanner() {
    return ViewportVisibilityListener(
      onVisibilityChanged: _handleVisibilityFractionChanged,
      child: BlocConsumer<ScannerCubit, ScannerState>(
        bloc: scannerCubit,
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) => _handleScannerStateChanged(state),
        builder: (context, state) => _buildAnimatedScannerShell(state),
      ),
    );
  }

  void _handleScannerStateChanged(ScannerState state) {
    final isScannerEnabled = state is ScannerEnabled;
    final wasScannerEnabled = _wasScannerEnabled;
    _wasScannerEnabled = isScannerEnabled;

    _updateCameraStartupUi();
    if (!wasScannerEnabled && isScannerEnabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        unawaited(_restartCameraAfterEnable());
      });
      return;
    }

    switch (state) {
      case ScannerEnabled() when _isActuallyVisible:
        cameraCoordinator.scheduleSafeStartCamera();
      case ScannerEnabled():
        cameraCoordinator.scheduleSafeStopCamera();
      case ScannerDisabled():
        cameraCoordinator.scheduleSafeStopCamera();
    }
  }

  Widget _buildAnimatedScannerShell(ScannerState state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final content = _buildScannerStateContent(state);

        return SizedBox(
          width: _scannerWidth(constraints),
          height: _scannerHeight(constraints),
          child: AnimatedSwitcher(
            duration: _cameraPlaceholderFadeDuration,
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeOutCubic,
            layoutBuilder: _buildSwitchLayout,
            child: content,
          ),
        );
      },
    );
  }

  Widget _buildSwitchLayout(Widget? currentChild, List<Widget> previousChildren) {
    return currentChild ?? const SizedBox.shrink();
  }

  Widget _buildScannerStateContent(ScannerState state) {
    if (state is ScannerEnabled) {
      return _buildEnabledScannerContent();
    }

    return KeyedSubtree(
      key: const ValueKey('scanner-disabled'),
      child: widget.offlinePlaceholder ?? _buildDefaultOfflinePlaceholder(),
    );
  }

  Widget _buildDefaultOfflinePlaceholder() {
    return ScannerOfflinePlaceholder(
      isOnOffOverlay: widget.overlay is OnOffStandardScannerOverlay,
      onEnableCamera: _enableCamera,
    );
  }

  Widget _buildEnabledScannerContent() {
    return KeyedSubtree(
      key: const ValueKey('scanner-enabled'),
      child: _buildScannerContent(),
    );
  }

  void _enableCamera() {
    context.read<ScannerCubit>().enableCamera(save: true);
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

  Widget _buildScannerContent() {
    return ValueListenableBuilder(
      valueListenable: codeScannedNotifier,
      builder: (context, scanned, _) {
        return AnimatedSwitcher(
          duration: _scanResultSwitchDuration,
          child: scanned && widget.cooldownSeconds == null
              ? _buildSuccessLayout(context)
              : _buildCameraView(),
        );
      },
    );
  }

  Widget _buildSuccessLayout(BuildContext context) {
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
    await cameraCoordinator.safeStopCamera();
    if (!mounted || codeScannedNotifier.value) return;
    if (scannerCubit.state is! ScannerEnabled) return;

    await cameraCoordinator.safeStartCamera();
  }

  Future<void> _restartCameraAfterEnable() async {
    await cameraCoordinator.restartCameraAfterEnable();
  }

  Widget _buildCameraView() {
    return ScannerCameraView(
      cameraControllerRevision: scannerCubit.cameraControllerRevision,
      getCameraController: () => scannerCubit.cameraController,
      overlay: widget.overlay,
      cameraFeedbackOverlay: _buildCameraFeedbackOverlay(),
      startupOverlayVisibleNotifier: cameraStartupOverlayVisibleNotifier,
      startupLoaderVisibleNotifier: cameraStartupLoaderVisibleNotifier,
      cameraPreviewFadeDuration: _cameraPreviewFadeDuration,
      cameraPlaceholderFadeDuration: _cameraPlaceholderFadeDuration,
      cameraLoaderFadeDuration: _cameraLoaderFadeDuration,
      onDetect: (capture) => _handleDetect(context, capture),
    );
  }

  Widget? _buildCameraFeedbackOverlay() {
    if (widget.cooldownSeconds == null) return null;

    return Stack(
      children: [
        Positioned.fill(child: _buildSuccessIcon()),
        Positioned.fill(child: _buildCooldownOverlay()),
      ],
    );
  }

  bool _shouldShowCameraStartupPlaceholder(MobileScannerState controllerState) {
    if (!_isActuallyVisible) return false;
    if (scannerCubit.state is! ScannerEnabled) return false;
    if (controllerState.error != null) return false;

    return controllerState.isStarting ||
        (!controllerState.isRunning && codeScannedNotifier.value == false);
  }

  bool _hasTerminalCameraError(MobileScannerState controllerState) {
    final errorCode = controllerState.error?.errorCode;

    return errorCode == MobileScannerErrorCode.unsupported ||
        errorCode == MobileScannerErrorCode.permissionDenied;
  }

  void _handleControllerRevisionChanged() {
    _attachCameraControllerListener();
    _updateCameraStartupUi();
  }

  void _handleVisibilityFractionChanged(double visibleFraction) {
    final isVisible = visibleFraction > _cameraVisibleFractionThreshold;
    if (isVisible == _isActuallyVisible) return;

    _isActuallyVisible = isVisible;
    _updateCameraStartupUi();
    if (_hasTerminalCameraError(scannerCubit.cameraController.value)) return;

    if (_isActuallyVisible && scannerCubit.state is ScannerEnabled) {
      cameraCoordinator.scheduleSafeStartCamera();
      return;
    }

    cameraCoordinator.scheduleSafeStopCamera();
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

  void _handleDetect(BuildContext context, BarcodeCapture capture) {
    if (capture.barcodes.isEmpty) return;

    String? rawValue = capture.barcodes.first.rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    unawaited(_handleScanResult(context, rawValue));
  }

  Future<void> _handleScanResult(BuildContext context, String barcode) async {
    // Continue only if camera is ready for next scan
    if (codeScannedNotifier.value || coolDownVisibilityNotifier.value) return;
    if (mounted) codeScannedNotifier.value = true;

    try {
      widget.onScan(barcode);
      await HapticFeedback.vibrate();
      if (widget.cooldownSeconds != null) await _runCooldown();
    } catch (e) {
      final msg = e.toString();
      for (int i = 0; i < 3; i++) {
        await HapticFeedback.vibrate();
        await Future<void>.delayed(_errorVibrationGap);
      }

      if (context.mounted) {
        AppSnackBar.error(
          message: msg,
        ).show(context, duration: _errorSnackDuration);
      }
      if (widget.cooldownSeconds != null) await _runCooldown();
    }
  }

  Future<void> _runCooldown() async {
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

  Widget _buildSuccessIcon() {
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

  Widget _buildCooldownOverlay() {
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

  void _invalidatePendingRouteResume() {
    _routeTransitionRequestId++;
    _routeResumeTimer?.cancel();
    _routeResumeTimer = null;
  }

  int _resetRouteResumeTimer() {
    _invalidatePendingRouteResume();
    return _routeTransitionRequestId;
  }
}
