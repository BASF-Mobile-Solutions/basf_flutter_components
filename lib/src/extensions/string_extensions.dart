import 'dart:convert';

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

  /// Turns a camelCase, snake_case or kebab-case identifier into words with
  /// only the first one capitalized
  ///
  /// Example:
  /// ```dart
  /// 'errorMessages'.toSentenceCase(); // Error messages
  /// 'send_by'.toSentenceCase(); // Send by
  /// ```
  String toSentenceCase() {
    final String words = replaceAllMapped(
      RegExp('([a-z0-9])([A-Z])'),
      (match) => '${match[1]} ${match[2]}',
    ).replaceAll(RegExp(r'[_\-\s]+'), ' ').trim();

    return words.toCapitalized();
  }
}

/// Formatting of a [String] that holds JSON
extension StringJsonExtension on String {
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  /// The JSON object or array the [String] holds, decoded, with JSON nested in
  /// string values decoded too — backends often send an envelope serialized
  /// into a field. `null` when the [String] holds no JSON object or array.
  ///
  /// Example:
  /// ```dart
  /// '{"detail": "{\\"code\\": 500}"}'.toJsonValue(); // {detail: {code: 500}}
  /// 'Not found'.toJsonValue(); // null
  /// ```
  Object? toJsonValue() {
    final Object? decoded = _decodedJson(this);

    return decoded is Map || decoded is List ? decoded : null;
  }

  /// Pretty prints the [String] with two space indents when it is a JSON
  /// object or array, nested JSON included, see [toJsonValue]. Anything else
  /// is returned as it is.
  ///
  /// Example:
  /// ```dart
  /// '{"detail": "{\\"code\\": 500}"}'.toPrettyJson();
  /// // {
  /// //   "detail": {
  /// //     "code": 500
  /// //   }
  /// // }
  /// ```
  String toPrettyJson() {
    final Object? value = toJsonValue();

    return value == null ? this : _encoder.convert(value);
  }
}

/// Decodes [value] when it is a JSON object or array, and every such JSON
/// string nested in it; anything else stays as it is.
Object? _decodedJson(Object? value) {
  if (value is Map) return value.map((key, nested) => MapEntry(key, _decodedJson(nested)));
  if (value is List) return value.map(_decodedJson).toList();
  if (value is! String) return value;

  final String trimmed = value.trim();
  if (!trimmed.startsWith('{') && !trimmed.startsWith('[')) return value;

  try {
    return _decodedJson(jsonDecode(trimmed));
  } on FormatException {
    return value;
  }
}

///
extension StringNullableExtensions on String? {
  ///
  String get unwrapString {
    return (this is String && this!.isEmpty) || this?.toString() == 'null'
        ? '-'
        : this?.toString() ?? '-';
  }
}
