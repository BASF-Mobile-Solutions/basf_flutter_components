import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

part 'scanner_state.dart';

/// Camera cubit
class ScannerCubit extends HydratedCubit<ScannerState> {
  /// Relaunches scanner with delay
  void relaunchScanner({Duration duration = const Duration(milliseconds: 500)}) {
    if (state is! ScannerEnabled) return;

    disableCamera(save: false);
    Future.delayed(duration, () {
      if (!isClosed) enableCamera(save: false);
    });
  }

  ScannerCubit({required this.id}) : super(const ScannerEnabled()) {
    // If you need to init camera later, just make Scanner widget creation later
    init();
  }

  @override
  final String id;

  /// Camera controller
  late MobileScannerController _cameraController;

  /// Camera controller
  MobileScannerController get cameraController => _cameraController;

  /// Flashlight controller
  late final ValueNotifier<TorchState> flashlightNotifier;

  /// Flashlight controller
  late final ValueNotifier<CameraFacing> directionNotifier;

  /// Rebuilds MobileScanner when a controller has to be recreated.
  late final ValueNotifier<int> cameraControllerRevision;

  /// For cases where scanner is disabled using route observer
  bool _scannerDisabledAutomatically = false;

  /// Initializes cubit
  void init() {
    _cameraController = _createCameraController();
    flashlightNotifier = ValueNotifier(cameraController.value.torchState);
    directionNotifier = ValueNotifier(cameraController.value.cameraDirection);
    cameraControllerRevision = ValueNotifier(0);
  }

  MobileScannerController _createCameraController() {
    return MobileScannerController(autoStart: false)
      ..addListener(_torchListener)
      ..addListener(_directionListener);
  }

  /// Recreates controller when the platform gets stuck in a broken state.
  Future<void> recreateCameraController() async {
    final oldController = _cameraController;
    oldController
      ..removeListener(_torchListener)
      ..removeListener(_directionListener);

    _cameraController = _createCameraController();
    flashlightNotifier.value = cameraController.value.torchState;
    directionNotifier.value = cameraController.value.cameraDirection;
    cameraControllerRevision.value++;

    await oldController.dispose();
  }

  /// Enables/Shows scanner
  /// /// [automatic] - enabled camera automatically by router observer for example
  void enableCamera({bool automatic = false, bool save = true}) {
    switch (state) {
      case ScannerDisabled(saveState: final permanentlySaved):
        if (automatic && !_scannerDisabledAutomatically) {
          break;
        } else if (save) {
          if (!isClosed) emit(ScannerEnabled(saveState: save));
        } else if (!permanentlySaved) {
          if (!isClosed) emit(ScannerEnabled(saveState: save));
        }
      case ScannerEnabled():
        break;
    }
  }

  /// Disables/Hides scanner
  /// [automatic] - disabled camera automatically by router observer for example
  void disableCamera({bool automatic = false, bool save = true}) {
    switch (state) {
      case ScannerEnabled():
        if (automatic) _scannerDisabledAutomatically = true;
        if (!isClosed) emit(ScannerDisabled(saveState: save));
      case ScannerDisabled():
        break;
    }
  }

  /// Requests camera permission
  Future<void> checkPermissionOrOpenSettings({bool isRecheck = false}) async {
    final initialStatus = await Permission.camera.status;
    final status = await Permission.camera.request();

    switch (status) {
      case PermissionStatus.granted:
        if (isClosed) return;
        emit(const ScannerDisabled());
        emit(const ScannerEnabled());
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        unawaited(openAppSettings());
      case PermissionStatus.denied when !isRecheck && initialStatus == PermissionStatus.denied:
        unawaited(openAppSettings());
      default:
        break;
    }
  }

  void _torchListener() {
    flashlightNotifier.value = cameraController.value.torchState;
  }

  void _directionListener() {
    directionNotifier.value = cameraController.value.cameraDirection;
  }

  @override
  Future<void> onChange(Change<ScannerState> change) async {
    super.onChange(change);
    switch (change.nextState) {
      case ScannerDisabled():
        break;
      case ScannerEnabled():
        _scannerDisabledAutomatically = false;
    }
  }

  @override
  Future<void> close() async {
    _cameraController
      ..removeListener(_torchListener)
      ..removeListener(_directionListener);
    flashlightNotifier.dispose();
    directionNotifier.dispose();
    cameraControllerRevision.dispose();
    await cameraController.dispose();
    return super.close();
  }

  @override
  ScannerState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) return ScannerState.fromJson(json);
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ScannerState state) {
    return switch (state) {
      ScannerEnabled() when state.saveState => state.toJson(),
      ScannerDisabled() when state.saveState => state.toJson(),
      _ => null,
    };
  }
}
