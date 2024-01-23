
import 'package:hydrated_bloc/hydrated_bloc.dart';

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

/// Controller to save data from persisted input
class PersistedInputCubit extends HydratedCubit<PersistedInputData> {
  /// Default controller for persisted cubit
  PersistedInputCubit({required this.id}) : super(const PersistedInputData());

  @override
  final String id;

  /// Adds new input value to the list
  void addValue(String value) {
    if (!state.lastValues.contains(value) && state.favoriteValue != value) {
      final newValues = [value, ...state.lastValues];

      if (newValues.length > 3) {
        newValues.removeRange(3, newValues.length - 1);
      }

      if (!isClosed) {
        emit(PersistedInputData(
          favoriteValue: state.favoriteValue,
          lastValues: newValues,
        ),);
      }
    }
  }

  /// Sets favorite value
  void setFavoriteValue(String value) {
    if (!isClosed) {
      final savedDefaultValue = state.favoriteValue;

      if (savedDefaultValue != null && savedDefaultValue == value) {
        emit(PersistedInputData(lastValues: state.lastValues));
        addValue(savedDefaultValue);
      } else {
        emit(PersistedInputData(
          favoriteValue: value,
          lastValues: [...state.lastValues]..removeWhere((v) => v == value),
        ),);
      }
    }
  }

  @override
  PersistedInputData? fromJson(Map<String, dynamic> json) {
    return PersistedInputData.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PersistedInputData state) {
    return state.toJson();
  }
}
