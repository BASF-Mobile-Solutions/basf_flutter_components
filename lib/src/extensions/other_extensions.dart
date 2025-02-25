import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template map_extension}
/// Allows us to find an entry
/// {@endtemplate}
extension DetailedWhere<K, V> on Map<K, V> {
  /// {@macro map_extension}
  /// based on key and value
  ///
  /// Example:
  /// ```dart
  /// people.where((key, value) => key.length > 4 && value > 20);
  /// // {Peter: 22}
  ///
  /// const Map<String, int> people = {'John': 20, 'Mary': 21, 'Peter':20};
  /// ```
  Map<K, V> where(bool Function(K key, V value) f) => Map<K, V>.fromEntries(
    entries.where((entry) => f(entry.key, entry.value)),
  );

  /// {@macro map_extension}
  /// based on key
  ///
  /// Example:
  /// ```dart
  /// people.whereKey((key) => key.length < 5);
  /// // {John: 20, Mary: 21}
  ///
  /// const Map<String, int> people = {'John': 20, 'Mary': 21, 'Peter':20};
  /// ```
  Map<K, V> whereKey(bool Function(K key) f) => {
    ...where((key, value) => f(key)),
  };

  /// {@macro map_extension}
  /// based on  value
  ///
  /// Example:
  /// ```dart
  /// people.whereValue((value) => value.isEven);
  /// // {John: 20, Peter: 22}
  ///
  /// const Map<String, int> people = {'John': 20, 'Mary': 21, 'Peter':20};
  /// ```
  Map<K, V> whereValue(bool Function(V value) f) => {
    ...where((key, value) => f(value)),
  };
}

/// {@template show_app_snackbar}
/// Shows an [AppSnackBar]
/// {@endtemplate}
extension SnackbarActions on AppSnackBar {
  /// {@macro show_app_snackbar}
  void show(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(backgroundColor: backgroundColor, content: this));
  }
}

/// {@template theme_extension}
/// Allows access to the current theme data
/// {@endtemplate}
extension ThemeExtension on BuildContext {
  /// {@macro theme_extension}
  /// Example:
  /// ```dart
  /// final theme = context.theme; // Access current theme data
  /// ```
  ThemeData get theme => Theme.of(this);
}
