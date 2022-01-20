extension ScopeFunctionsExt<T extends Object> on T {
  /// Calls the [block] function with `this` value as its argument and returns value of another type.
  /// Used to invoke one or more functions on results of call chains or for executing a code block only with non-null values
  R let<R>(R Function(T it) block) => block(this);

  /// Calls the [block] function with `this` value as its argument and returns `this` value.
  T also(void Function(T) block) {
    block(this);
    return this;
  }

  /// When called on an object with a [block] predicate provided,
  /// returns this object if it matches the predicate. Otherwise, it returns null.
  T? takeIf(bool Function(T it) block) => block(this) ? this : null;

  /// When called on an object with a [block] predicate provided,
  /// returns the object if it doesn't match the predicate and null if it does.
  T? takeUnless(bool Function(T it) block) => !block(this) ? this : null;
}

/// Useful when expression is required and also need to call one or more functions.
///
/// ```dart
/// someNullable ?? run(() {
///   var defaultValue = ...;
///   // other statements...;
///   return defaultValue;
/// });
/// ```
R run<R>(R Function() block) => block();
