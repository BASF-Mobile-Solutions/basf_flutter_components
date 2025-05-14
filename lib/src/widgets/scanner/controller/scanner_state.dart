part of 'scanner_cubit.dart';

/// Camera controller state
@immutable
sealed class ScannerState {
  const ScannerState();

  /// Deserialize based on the `type` field
  factory ScannerState.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    final saveState = json['saveState'] as bool? ?? true;
    switch (type) {
      case 'CameraEnabled':
        return ScannerEnabled(saveState: saveState);
      case 'CameraDisabled':
        return ScannerDisabled(saveState: saveState);
      default:
        throw UnsupportedError('Unknown ScanCameraState type: $type');
    }
  }

  /// Branches must override.
  Map<String, dynamic> toJson();
}

/// Enabled state
final class ScannerEnabled extends ScannerState {
  ///
  const ScannerEnabled({this.saveState = true});
  ///
  final bool saveState;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'CameraEnabled',
    'saveState': saveState,
  };
}

/// Disabled state
final class ScannerDisabled extends ScannerState {
  ///
  const ScannerDisabled({this.saveState = true});
  ///
  final bool saveState;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'CameraDisabled',
    'saveState': saveState,
  };
}
