import 'dart:ui';

/// Data for favorite button
class FavoriteData {
  /// Data for favorite button
  const FavoriteData({
    required this.isFavorite,
    required this.onPressed,
  });

  /// Switch state for favorite button
  final bool isFavorite;
  /// Switch action for favorite button
  final VoidCallback onPressed;
}
