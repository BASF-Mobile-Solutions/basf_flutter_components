import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

///
class LogisticsBoxAnimation extends StatefulWidget {
  ///
  const LogisticsBoxAnimation({
    this.size = const Size(500, 250),
    super.key,
  });

  ///
  final Size size;

  @override
  State<LogisticsBoxAnimation> createState() => _LogisticsBoxAnimationState();
}

class _LogisticsBoxAnimationState extends State<LogisticsBoxAnimation> {
  static final DataBind _dataBind = DataBind.auto();
  static const _stateMachineName = 'State Machine 1';
  static const _boxTriggerNames = <String>['box2', 'box3', 'box4'];

  final Map<String, ViewModelInstanceTrigger> _boxTriggers = {};

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
      child: animation(context),
    );
  }

  Widget animation(BuildContext context) {
    return BasfRiveAnimationStateMachineAsset(
      asset: BasfAssets.rive.logisticsBox,
      animationNames: const ['Idle'],
      stateMachine: _stateMachineName,
      dataBind: _dataBind,
      onLoaded: _onLoaded,
    );
  }

  void _fireBoxAnimation(String triggerName) {
    _boxTriggers[triggerName]?.trigger();
  }
}
