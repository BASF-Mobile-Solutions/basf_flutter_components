/// Merge two maps givin a [value] key
///
/// Example:
/// ```dart
///  json = json.mergeWith(valueJson);
/// ```
extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> mergeWith(Map<String, dynamic> other) {
    return _mergeMaps(this, other);
  }

  Map<String, dynamic> _mergeMaps(
      Map<String, dynamic> mapA, Map<String, dynamic> mapB) {
    mapB.forEach((k, v) {
      if (!mapA.containsKey(k)) {
        mapA[k] = v;
      } else {
        if (mapA[k] is Map) {
          _mergeMaps(mapA[k], mapB[k]);
        } else {
          mapA[k] = mapB[k];
        }
      }
    });

    return mapA;
  }
}
