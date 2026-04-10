import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

///
class LogisticsBoxAnimation extends StatefulWidget {
  ///
  const LogisticsBoxAnimation({
    this.size = const Size(500, 250),
    this.humanColor,
    this.boxesColor,
    super.key,
  });

  ///
  final Size size;

  ///
  final Color? humanColor;

  ///
  final Color? boxesColor;

  @override
  State<LogisticsBoxAnimation> createState() => _LogisticsBoxAnimationState();
}

class _LogisticsBoxAnimationState extends State<LogisticsBoxAnimation> {
  static final DataBind _dataBind = DataBind.auto();
  static const _stateMachineName = 'State Machine 1';
  static const _boxTriggerNames = <String>['box2', 'box3', 'box4'];
  static const _humanColorBind = 'humanColor';
  static const _boxesColorBind = 'boxesColor';

  final Map<String, ViewModelInstanceTrigger> _boxTriggers = {};
  ViewModelInstanceColor? _humanColor;
  ViewModelInstanceColor? _boxesColor;

  @override
  void didUpdateWidget(covariant LogisticsBoxAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.humanColor != widget.humanColor) {
      _applyHumanColor(widget.humanColor);
    }
    if (oldWidget.boxesColor != widget.boxesColor) {
      _applyBoxesColor(widget.boxesColor);
    }
  }

  Future<void> _onLoaded(RiveLoaded state) async {
    final viewModelInstance = state.viewModelInstance;
    if (viewModelInstance == null) {
      return;
    }

    _boxTriggers
      ..clear()
      ..addEntries(
        _boxTriggerNames.map(
          (name) => MapEntry(name, viewModelInstance.trigger(name)!),
        ),
      );
    _humanColor = viewModelInstance.color(_humanColorBind);
    _boxesColor = viewModelInstance.color(_boxesColorBind);
    _applyHumanColor(widget.humanColor);
    _applyBoxesColor(widget.boxesColor);

    for (final triggerName in _boxTriggerNames) {
      await Future<void>.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      _fireBoxAnimation(triggerName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: BasfRiveAnimationStateMachineAsset(
        asset: BasfAssets.rive.logisticsBox,
        animationNames: const ['Idle'],
        stateMachine: _stateMachineName,
        dataBind: _dataBind,
        onLoaded: _onLoaded,
      ),
    );
  }

  void _fireBoxAnimation(String triggerName) {
    _boxTriggers[triggerName]?.trigger();
  }

  void _applyHumanColor(Color? color) {
    if (color != null) {
      _humanColor?.value = color;
    }
  }

  void _applyBoxesColor(Color? color) {
    if (color != null) {
      _boxesColor?.value = color;
    }
  }
}
