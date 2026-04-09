import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SuccessAnimatedIcon extends StatelessWidget {
  const SuccessAnimatedIcon({
    this.backgroundColor,
    this.size = 48,
    super.key,
  });

  final Color? backgroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return _StatusAnimatedIcon(
      artboard: _StatusArtboard.success,
      color: backgroundColor ?? Theme.of(context).primaryColor,
      size: size,
    );
  }
}

class ErrorAnimatedIcon extends StatelessWidget {
  const ErrorAnimatedIcon({
    this.size = 48,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return _StatusAnimatedIcon(
      artboard: _StatusArtboard.error,
      color: BasfColors.red,
      size: size,
    );
  }
}

class WarningAnimatedIcon extends StatelessWidget {
  const WarningAnimatedIcon({
    this.size = 48,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return _StatusAnimatedIcon(
      artboard: _StatusArtboard.warning,
      color: BasfColors.orange,
      size: size,
    );
  }
}

enum _StatusArtboard {
  success('success'),
  error('error'),
  warning('warning');

  const _StatusArtboard(this.name);

  final String name;
}

class _StatusAnimatedIcon extends StatefulWidget {
  const _StatusAnimatedIcon({
    required this.artboard,
    required this.color,
    required this.size,
  });

  final _StatusArtboard artboard;
  final Color color;
  final double size;

  @override
  State<_StatusAnimatedIcon> createState() => _StatusAnimatedIconState();
}

class _StatusAnimatedIconState extends State<_StatusAnimatedIcon> {
  static final DataBind _dataBind = DataBind.auto();
  static const _animationName = 'show';
  static const _stateMachineName = 'State Machine 1';
  static const _primaryColorBind = 'primaryColor';

  ViewModelInstanceColor? _primaryColor;

  @override
  void didUpdateWidget(covariant _StatusAnimatedIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      _applyPrimaryColor(widget.color);
    }
  }

  @override
  void dispose() {
    _primaryColor = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: BasfRiveAnimationStateMachineAsset(
        asset: BasfAssets.rive.successStatusIcon,
        artboard: widget.artboard.name,
        animationNames: const [_animationName],
        stateMachine: _stateMachineName,
        dataBind: _dataBind,
        onLoaded: (state) {
          _primaryColor = state.viewModelInstance?.color(_primaryColorBind);
          _applyPrimaryColor(widget.color);
        },
      ),
    );
  }

  void _applyPrimaryColor(Color color) {
    _primaryColor?.value = color;
  }
}
