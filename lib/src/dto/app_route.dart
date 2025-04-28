/// App Route for router
/// Just create a list of static routes in your app and you'll get
/// same behavior as with the enums
class AppRoute {
  /// App Route for router
  const AppRoute({
    required this.path,
    required this.name,
  });

  /// Path for the route
  final String path;
  /// Name of the route
  final String name;

  @override
  String toString() => 'Route: [$path][$name]';
}
