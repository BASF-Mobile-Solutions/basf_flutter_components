import 'package:basf_flutter_components/src/widgets/inputs/logic/persisted_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// Controller to save data from persisted input
class PersistedInputCubit extends HydratedCubit<PersistedInputData> {
  /// Default controller for persisted cubit
  PersistedInputCubit({required this.id}) : super(const PersistedInputData());

  @override
  final String id;

  /// Checks if values exist
  bool get valuesExist =>
      state.favoriteValue != null || state.lastValues.isNotEmpty;

  /// Adds new input value to the list
  void addValue(String value) {
    if (!state.lastValues.contains(value) && state.favoriteValue != value) {
      final newValues = [value, ...state.lastValues];

      if (newValues.length > 2) {
        newValues.removeRange(2, newValues.length - 1);
      }

      if (!isClosed) {
        emit(
          PersistedInputData(
            favoriteValue: state.favoriteValue,
            lastValues: newValues,
          ),
        );
      }
    }
  }

  /// Sets favorite value
  void setFavoriteValue(String value) {
    if (!isClosed) {
      emit(
        PersistedInputData(
          favoriteValue: value == state.favoriteValue ? null : value,
          lastValues:
              [
                if (state.favoriteValue != null) state.favoriteValue!,
                ...state.lastValues,
              ]..removeWhere((v) {
                if (value != state.favoriteValue) {
                  return v == value;
                } else {
                  return false;
                }
              }),
        ),
      );
    }
  }

  /// Deletes value from the list
  void deleteValue(String value) {
    emit(
      PersistedInputData(
        favoriteValue: state.favoriteValue,
        lastValues: List.from(state.lastValues)..remove(value),
      ),
    );
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
