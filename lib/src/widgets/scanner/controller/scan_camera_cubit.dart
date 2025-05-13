import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'scan_camera_state.dart';

/// Camera cubit
class ScanCameraCubit extends HydratedCubit<ScanCameraState> {
  ///
  ScanCameraCubit({
    required this.id,
    bool enableOnStart = true,
  }) : super(enableOnStart ? const CameraEnabled() : const CameraDisabled());

  @override
  final String id;


  @override
  ScanCameraState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) return ScanCameraState.fromJson(json);
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ScanCameraState state) => state.toJson();
}
