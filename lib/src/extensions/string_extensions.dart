import 'package:basf_flutter_components/basf_flutter_components.dart';

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
  String toTitleCase() => replaceAll(
    RegExp(' +'),
    ' ',
  ).split(' ').map((str) => str.toCapitalized()).join(' ');
}
