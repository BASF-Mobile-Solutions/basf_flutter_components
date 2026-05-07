import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class MessageRiveAnimation extends StatelessWidget {
  const MessageRiveAnimation({
    this.size,
    super.key,
  });

  static const _animationName = 'Animation 1';

  final Size? size;

  @override
  Widget build(BuildContext context) {
    final animation = BasfRiveAnimationAsset(
      asset: BasfAssets.rive.messageIcon,
      animationName: _animationName,
    );

    final size = this.size;
    if (size == null) {
      return animation;
    }

    return SizedBox.fromSize(size: size, child: animation);
  }
}
