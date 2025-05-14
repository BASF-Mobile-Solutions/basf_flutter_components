import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'scanner_state.dart';

/// Camera cubit
class ScannerCubit extends HydratedCubit<ScannerState> {
  ///
  ScannerCubit({
    required this.id,
    bool enableOnStart = true,
  }) : super(enableOnStart ? const ScannerEnabled() : const ScannerDisabled());

  @override
  final String id;

  /// Enables/Shows scanner
  void enable() => emit(const ScannerEnabled());

  /// Disables/Hides scanner
  void disable() => emit(const ScannerDisabled());

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

  @override
  ScannerState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) return ScannerState.fromJson(json);
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ScannerState state) => state.toJson();
}
