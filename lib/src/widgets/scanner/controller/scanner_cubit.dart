import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

part 'scanner_state.dart';

/// Camera cubit
class ScannerCubit extends HydratedCubit<ScannerState> {
  ///
  ScannerCubit({required this.id}) : super(const ScannerEnabled()) {
    // If you need to init camera later, just make Scanner widget creation later
    init();
  }

  @override
  final String id;

  /// Camera controller
  late final MobileScannerController cameraController;

  /// Flashlight controller
  late final ValueNotifier<TorchState> flashlightNotifier;

  /// Flashlight controller
  late final ValueNotifier<CameraFacing> directionNotifier;

  /// For cases where scanner is disabled using route observer
  bool _scannerDisabledAutomatically = false;

  /// Initializes cubit
  void init() {
    cameraController = MobileScannerController()
      ..addListener(_torchListener)
      ..addListener(_directionListener);
    flashlightNotifier = ValueNotifier(cameraController.value.torchState);
    directionNotifier = ValueNotifier(cameraController.value.cameraDirection);
  }

  /// Enables/Shows scanner
  /// /// [automatic] - enabled camera automatically by router observer for example
  void enableCamera({bool automatic = false, bool save = true}) {
    switch (state) {
      case ScannerDisabled(saveState: final permanentlySaved):
        if (automatic && !_scannerDisabledAutomatically) {
          break;
        } else if (save) {
          emit(ScannerEnabled(saveState: save));
        } else if (!permanentlySaved) {
          emit(ScannerEnabled(saveState: save));
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
        emit(ScannerDisabled(saveState: save));
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
        emit(const ScannerDisabled());
        emit(const ScannerEnabled());
      case PermissionStatus.permanentlyDenied
          when !isRecheck && initialStatus == status:
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
        await cameraController.stop();
      case ScannerEnabled():
        _scannerDisabledAutomatically = false;
    }
  }

  @override
  Future<void> close() async {
    flashlightNotifier.dispose();
    directionNotifier.dispose();
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
