part of 'scan_camera_cubit.dart';

/// Camera controller state
@immutable
sealed class ScanCameraState {
  const ScanCameraState();

  /// Deserialize based on the `type` field
  factory ScanCameraState.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    final saveState = json['saveState'] as bool? ?? true;
    switch (type) {
      case 'CameraEnabled':
        return CameraEnabled(saveState: saveState);
      case 'CameraDisabled':
        return CameraDisabled(saveState: saveState);
      default:
        throw UnsupportedError('Unknown ScanCameraState type: $type');
    }
  }

  /// Branches must override.
  Map<String, dynamic> toJson();
}

/// Enabled state
final class CameraEnabled extends ScanCameraState {
  ///
  const CameraEnabled({this.saveState = true});
  ///
  final bool saveState;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'CameraEnabled',
    'saveState': saveState,
  };
}

/// Disabled state
final class CameraDisabled extends ScanCameraState {
  ///
  const CameraDisabled({this.saveState = true});
  ///
  final bool saveState;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'CameraDisabled',
    'saveState': saveState,
  };
}
