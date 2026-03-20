import 'dart:async';

import 'package:basf_flutter_components/src/widgets/scanner/controller/scanner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Coordinates camera start/stop and recovery for [Scanner].
class ScannerCameraCoordinator {
  ScannerCameraCoordinator({
    required this.scannerCubit,
    required this.isMounted,
    required this.isScannerEnabled,
    required this.isActuallyVisible,
    required this.onStartupUiChanged,
  });

  final ScannerCubit scannerCubit;
  final bool Function() isMounted;
  final bool Function() isScannerEnabled;
  final bool Function() isActuallyVisible;
  final VoidCallback onStartupUiChanged;

  static const _cameraStartRetryDelay = Duration(milliseconds: 100);
  static const _cameraStartMaxAttempts = 20;
  static const _cameraControllerRecreateMaxAttempts = 1;

  int _cameraStartRequestId = 0;
  bool _startScheduled = false;
  bool _stopScheduled = false;
  Future<void>? _cameraStopOperation;
  MobileScannerController? _cameraStopController;

  void scheduleSafeStartCamera() {
    if (_startScheduled) return;

    _startScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScheduled = false;
      if (!isMounted()) return;
      unawaited(safeStartCamera());
    });
  }

  void scheduleSafeStopCamera() {
    if (_stopScheduled) return;

    _stopScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _stopScheduled = false;
      unawaited(safeStopCamera());
    });
  }

  void scheduleDetachedControllerStop(MobileScannerController controller) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scannerCubit.isClosed) return;
      if (!identical(scannerCubit.cameraController, controller)) return;
      unawaited(_stopCameraController(controller));
    });
  }

  Future<void> restartCameraAfterEnable() async {
    await WidgetsBinding.instance.endOfFrame;
    if (!isMounted()) return;
    if (!isScannerEnabled()) return;

    if (!isActuallyVisible()) {
      await safeStopCamera();
      return;
    }

    onStartupUiChanged();
    await safeStartCamera();
  }

  Future<void> safeStopCamera() async {
    await _stopCameraController(scannerCubit.cameraController);
  }

  Future<void> safeStartCamera({int recreateAttempt = 0}) async {
    final requestId = recreateAttempt == 0 ? ++_cameraStartRequestId : _cameraStartRequestId;
    final currentController = scannerCubit.cameraController;
    final pendingStop = identical(_cameraStopController, currentController)
        ? _cameraStopOperation
        : null;

    if (_hasTerminalCameraError(currentController.value)) return;

    if (pendingStop != null) {
      await pendingStop;
      if (!isMounted() || requestId != _cameraStartRequestId) return;
    }

    for (int attempt = 0; attempt < _cameraStartMaxAttempts; attempt++) {
      if (!isMounted() || requestId != _cameraStartRequestId) return;
      if (!isScannerEnabled()) return;

      await scannerCubit.cameraController.start().catchError((_) => null);

      if (!isMounted() || requestId != _cameraStartRequestId) return;

      final controllerState = scannerCubit.cameraController.value;
      final errorCode = controllerState.error?.errorCode;
      if (controllerState.isRunning && errorCode == null) return;
      if (_hasTerminalCameraError(controllerState)) return;
      if (!_canRetryCameraStart(controllerState)) break;

      await Future<void>.delayed(_cameraStartRetryDelay);
    }

    if (!isMounted() || requestId != _cameraStartRequestId) return;
    if (!isScannerEnabled()) return;
    if (recreateAttempt >= _cameraControllerRecreateMaxAttempts) return;
    if (!_canRetryCameraStart(scannerCubit.cameraController.value)) return;

    await scannerCubit.recreateCameraController();

    if (!isMounted() || requestId != _cameraStartRequestId) return;

    await Future<void>.delayed(_cameraStartRetryDelay);
    return safeStartCamera(recreateAttempt: recreateAttempt + 1);
  }

  bool _canRetryCameraStart(MobileScannerState controllerState) {
    final errorCode = controllerState.error?.errorCode;

    return controllerState.isStarting ||
        errorCode == MobileScannerErrorCode.controllerAlreadyInitialized ||
        errorCode == MobileScannerErrorCode.controllerInitializing ||
        errorCode == MobileScannerErrorCode.controllerNotAttached;
  }

  bool _hasTerminalCameraError(MobileScannerState controllerState) {
    final errorCode = controllerState.error?.errorCode;

    return errorCode == MobileScannerErrorCode.unsupported ||
        errorCode == MobileScannerErrorCode.permissionDenied;
  }

  Future<void> _stopCameraController(MobileScannerController controller) {
    _cameraStartRequestId++;

    final existingStop = _cameraStopOperation;
    if (existingStop != null && identical(_cameraStopController, controller)) {
      return existingStop;
    }

    _cameraStopController = controller;

    late final Future<void> stopFuture;
    stopFuture = controller.stop().catchError((_) => null).whenComplete(() {
      if (identical(_cameraStopOperation, stopFuture)) {
        _cameraStopOperation = null;
        _cameraStopController = null;
      }
    });

    _cameraStopOperation = stopFuture;
    return stopFuture;
  }
}
