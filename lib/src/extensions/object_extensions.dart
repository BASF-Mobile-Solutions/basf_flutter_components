import 'dart:developer' as devtools;

/// Extension on Objects
extension Checks on Object? {
  ///Checks if the object is null or empty, or if it is an empty list
  bool get isNullOrEmpty {
    return this == null ||
        this!.toString().isEmpty ||
        (this is Iterable && (this! as Iterable).isEmpty);
  }

  ///Checks if the object is not null or empty, or if it is not an empty list
  bool get isNotNullOrEmpty => !isNullOrEmpty;
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
