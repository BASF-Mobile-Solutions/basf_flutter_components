import 'package:basf_flutter_components/utils/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import 'rive_asset_widgets.dart';

/// rive emoji animations
enum RiveEmoji {
  ///
  smiling('Smiling'),

  ///
  happy('Happy'),

  ///
  winking('Winking'),

  ///
  crying('Crying'),

  ///
  laughing('Laughing'),

  ///
  surprise('Surprise')
  ;

  const RiveEmoji(this.artBoard);

  ///
  final String artBoard;
}

class RiveEmojiIcon extends StatelessWidget {
  const RiveEmojiIcon({
    required this.emoji,
    this.size = 56,
    super.key,
  });

  static const animationName = 'Animation 1';

  final RiveEmoji emoji;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: BasfRiveAnimationAsset(
        asset: BasfAssets.rive.emoji,
        artboard: emoji.artBoard,
        animationName: animationName,
      ),
    );
  }
}
