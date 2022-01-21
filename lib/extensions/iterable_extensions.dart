typedef IndexMapFunction<T, R> = R Function(int index, T value);

/// Iterate trough a [List] and pass 
/// a given [index], [value] to a function
/// 
/// Example:
/// ```dart
/// return Column(
///        children: users
///            .indexMap((index, user) => UserScoreWidget(user: user, index: index))
///            .toList(),
///      );
/// ```
extension ListExtension<T> on Iterable<T> {
  Iterable<R> indexMap<R>(IndexMapFunction<T, R> indexMapFunction) {
    return toList().asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;
      return indexMapFunction(index, value);
    });
  }
}
