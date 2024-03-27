import 'package:basf_flutter_components/src/widgets/inputs/logic/persisted_input_cubit.dart';

/// Data model for [PersistedInputCubit]
class PersistedInputData {
  /// Default constructor
  const PersistedInputData({
    this.favoriteValue,
    this.lastValues = const [],
  });

  /// Json serialization
  PersistedInputData.fromJson(Map<String, dynamic> json)
      : favoriteValue = json['favorite_value'] as String?,
        lastValues = json['last_values'] as List<String>;

  /// Value that is saved to be default
  final String? favoriteValue;

  /// Values recently inputted
  final List<String> lastValues;

  /// Json serialization
  Map<String, dynamic> toJson() {
    return {
      'favorite_value': favoriteValue,
      'last_values': lastValues,
    };
  }
}
