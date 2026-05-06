import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class QrRiveAnimation extends StatefulWidget {
  const QrRiveAnimation({
    this.size,
    this.color,
    this.gradientStartColor,
    super.key,
  });

  final Size? size;
  final Color? color;
  final Color? gradientStartColor;

  @override
  State<QrRiveAnimation> createState() => _QrRiveAnimationState();
}

class _QrRiveAnimationState extends State<QrRiveAnimation> {
  static final DataBind _dataBind = DataBind.auto();
  static const _animationName = 'Timeline 1';
  static const _stateMachineName = 'State Machine 1';
  static const _primaryColorBind = 'primaryColor';
  static const _primaryColorGradientStartBind = 'primaryColorGradientStart';

  ViewModelInstanceColor? _primaryColor;
  ViewModelInstanceColor? _primaryColorGradientStart;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _applyColors();
  }

  @override
  void didUpdateWidget(covariant QrRiveAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color ||
        oldWidget.gradientStartColor != widget.gradientStartColor) {
      _applyColors();
    }
  }

  @override
  Widget build(BuildContext context) {
    final animation = BasfRiveAnimationStateMachineAsset(
      asset: BasfAssets.rive.qr,
      animationNames: const [_animationName],
      stateMachine: _stateMachineName,
      dataBind: _dataBind,
      onLoaded: (state) {
        final viewModelInstance = state.viewModelInstance;
        _primaryColor = viewModelInstance?.color(_primaryColorBind);
        _primaryColorGradientStart = viewModelInstance?.color(
          _primaryColorGradientStartBind,
        );
        _applyColors();
      },
    );

    final size = widget.size;
    if (size == null) {
      return animation;
    }

    return SizedBox.fromSize(size: size, child: animation);
  }

  void _applyColors() {
    final color = widget.color ?? Theme.of(context).primaryColor;
    _primaryColor?.value = color;
    _primaryColorGradientStart?.value = widget.gradientStartColor ?? color.withValues(alpha: 0.7);
  }
}
