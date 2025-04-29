import 'package:basf_flutter_components/basf_flutter_components.dart'
    show BasfColors;
import 'package:basf_flutter_components/src/dto/favorite_data.dart';
import 'package:flutter/material.dart';

/// Favorite button
class FavoriteButton extends StatelessWidget {
  /// Favorite button
  const FavoriteButton({required this.favoriteData, super.key});

  ///
  final FavoriteData favoriteData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.star,
        color:
            favoriteData.isFavorite
                ? Theme.of(context).primaryColor
                : BasfColors.boxGrey,
      ),
      iconSize: 20,
      onPressed: favoriteData.onPressed,
    );
  }
}
