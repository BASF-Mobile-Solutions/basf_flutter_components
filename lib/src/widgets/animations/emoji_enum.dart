import 'package:basf_flutter_components/utils/gen/assets.gen.dart';

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
  surprise('Surprise');

  const RiveEmoji(this.artBoard);

  ///
  final String artBoard;

  ///
  String get path => BasfAssets.rive.emoji.path;
}
