import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

part 'scanner_state.dart';

/// Camera cubit
class ScannerCubit extends HydratedCubit<ScannerState> {
  ///
  ScannerCubit({
    required this.id,
    bool enableOnStart = true,
  }) : super(enableOnStart ? const ScannerEnabled() : const ScannerDisabled()) {
    cameraController = MobileScannerController()
      ..addListener(_torchListener)
      ..addListener(_directionListener);
    flashlightNotifier = ValueNotifier(cameraController.value.torchState);
    directionNotifier = ValueNotifier(cameraController.value.cameraDirection);
  }

  @override
  final String id;

  /// Camera controller
  late final MobileScannerController cameraController;
  /// Flashlight controller
  late final ValueNotifier<TorchState> flashlightNotifier;
  /// Flashlight controller
  late final ValueNotifier<CameraFacing> directionNotifier;

  /// Enables/Shows scanner
  void enableCamera() => emit(const ScannerEnabled());

  /// Disables/Hides scanner
  void disableCamera() => emit(const ScannerDisabled());

  /// Requests camera permission
  Future<void> checkPermissionOrOpenSettings({bool isRecheck = false}) async {
    final initialStatus = await Permission.camera.status;
    final status = await Permission.camera.request();

    switch(status) {
      case PermissionStatus.granted:
        emit(const ScannerDisabled());
        emit(const ScannerEnabled());
      case PermissionStatus.permanentlyDenied
      when !isRecheck && initialStatus == status:
        unawaited(openAppSettings());
      default: break;
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
    switch(change.nextState) {
      case ScannerDisabled(): await cameraController.stop();
      default: break;
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
  Map<String, dynamic>? toJson(ScannerState state) => state.toJson();
}
