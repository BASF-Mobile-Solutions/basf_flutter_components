extension StringCasingExtension on String {
  /// Capitalize first letter of a string
  /// 
  /// Example
  /// ```dart
  /// String myString = 'this is my string'.toCapitalized; // This is my string
  /// ```
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  /// Capitalize every first letter of a word on a string
  /// 
  /// Example
  /// ```dart
  /// String myString = 'this is my string'.toTitleCase; // This Is My String
  /// ```
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
