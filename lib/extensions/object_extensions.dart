
/// Cast an [Object] if it's of a given [Type]
/// 
/// Example:
/// ```dart
///  state.asOrNull<AuthBlocStateSuccess>()?.progressIndicator
/// ```
extension ObjectExtension on Object {
  T? asOrNull<T>() {
    if (this is T) {
      return this as T;
    } else {
      return null;
    }
  }
}
