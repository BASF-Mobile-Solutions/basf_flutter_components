import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Settings gear icon animated
class AnimatedGearIcon extends StatelessWidget {
  /// Settings gear icon animated
  const AnimatedGearIcon({
    this.size = 25,
    this.onTap,
    this.color,
    super.key,
  });

  ///
  final double size;

  ///
  final VoidCallback? onTap;

  ///
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final currentColor = color ?? Theme.of(context).primaryColor;
    final animation = _GearsAnimation(
      size: size,
      color: currentColor,
    );

    if (onTap == null) {
      return animation;
    }

    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: animation,
      ),
    );
  }
}

class _GearsAnimation extends StatefulWidget {
  const _GearsAnimation({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  State<_GearsAnimation> createState() => _GearsAnimationState();
}

class _GearsAnimationState extends State<_GearsAnimation> {
  static final DataBind _dataBind = DataBind.auto();
  static const _animationName = 'spin1';
  static const _bottomGearColorBind = 'bottomGearColor';
  static const _middleGearColorBind = 'middleGearColor';
  static const _topGearColorBind = 'topGearColor';

  ViewModelInstanceColor? _bottomGearColor;
  ViewModelInstanceColor? _middleGearColor;
  ViewModelInstanceColor? _topGearColor;

  @override
  void didUpdateWidget(covariant _GearsAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      _applyColors(widget.color);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: BasfRiveAnimationStateMachineAsset(
        asset: BasfAssets.rive.gears,
        animationNames: const [_animationName],
        dataBind: _dataBind,
        onLoaded: (state) {
          _bottomGearColor = state.viewModelInstance?.color(_bottomGearColorBind);
          _middleGearColor = state.viewModelInstance?.color(_middleGearColorBind);
          _topGearColor = state.viewModelInstance?.color(_topGearColorBind);
          _applyColors(widget.color);
        },
      ),
    );
  }

  void _applyColors(Color color) {
    _bottomGearColor?.value = color.withValues(alpha: 0.8);
    _middleGearColor?.value = color.withValues(alpha: 0.9);
    _topGearColor?.value = color;
  }
}
