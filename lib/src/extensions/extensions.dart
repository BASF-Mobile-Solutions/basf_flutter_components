import 'dart:developer' as devtools;

import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// A collection of usefull extensions on [String]
extension StringCasingExtension on String {
  /// Converts the first letter of a [String] into uppercase
  /// or returns '' if null
  ///
  /// Example:
  /// ```dart
  /// 'carlos gutiérrez'.toCapitalized(); // Carlos gutiérrez
  /// ```
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Converts all the first letters of each words of a given [String] into
  /// uppercase
  ///
  /// Example:
  /// ```dart
  /// 'carlos gutiérrez'.toTitleCase(); // Carlos Gutiérrez
  /// ```
  /// See also:
  ///
  ///  * [toCapitalized]
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

/// A collection of usefull extensions on [List<Widget>]
extension JoinedWidgets on List<Widget> {
  /// Adds a specific type of [Widget] in between a list of Widgets
  /// This can be usefull to add some height in between Widgets
  /// without the need of writing it multiple times
  ///
  /// Example:
  /// ```dart
  /// [
  ///  const Text('BASF'),
  ///  const Text('MOBILE SOLUTIONS'),
  /// ].joinWithSeparator(const SizedBox(height: 10));
  /// ```
  List<Widget> joinWithSeparator(Widget separator) {
    return length > 1
        ? (take(length - 1)
            .map((widget) => [widget, separator])
            .expand((widget) => widget)
            .toList()
          ..add(last))
        : this;
  }

  /// Adds the same ammount of padding to a list of Widgets
  /// This can be usefull if you need to have some of the widgets of a list
  /// spaced, and some don't
  ///
  /// Example:
  /// ```dart
  /// [
  ///   const Text('BASF'),
  ///   const Text('MOBILE SOLUTIONS'),
  /// ].spaced();
  /// // or
  /// ].spaced(padding: const EdgeInsets.all(10));
  /// ```
  List<Widget> spaced({EdgeInsetsGeometry? padding, bool excludeFlex = true}) {
    final spacedWidgets = <Widget>[];
    for (final w in this) {
      if (excludeFlex && (w is Expanded || w is Spacer || w is Flexible)) {
        spacedWidgets.add(w);
      } else {
        spacedWidgets.add(
          Padding(
            padding: padding ??
                const EdgeInsets.fromLTRB(
                  Dimens.paddingMediumLarge,
                  0,
                  Dimens.paddingMediumLarge,
                  0,
                ),
            child: w,
          ),
        );
      }
    }
    return spacedWidgets;
  }
}

/// {@template log_extension}
/// Emit a log event of the current object
/// {@endtemplate}
extension Log on Object {
  /// {@macro log_extension}
  int log() {
    final str = toString();
    devtools.log(str);

    // returns the length of the ouput
    return str.length;
  }
}

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
  Map<K, V> whereKey(bool Function(K key) f) =>
      {...where((key, value) => f(key))};

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
  Map<K, V> whereValue(bool Function(V value) f) =>
      {...where((key, value) => f(value))};
}

/// {@template show_app_snackbar}
/// Shows an [AppSnackBar]
/// {@endtemplate}
extension SnackbarActions on AppSnackBar {
  /// {@macro show_app_snackbar}
  void show(BuildContext context) {
    ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
      SnackBar(backgroundColor: backgroundColor, content: this),
    );
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
