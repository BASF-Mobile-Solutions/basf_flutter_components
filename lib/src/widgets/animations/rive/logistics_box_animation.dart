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
  RiveWidgetController? _controller;

  static const _stateMachineName = 'State Machine 1';
  static const _boxInputNames = <String>['Box_2', 'Box_3', 'Box_4'];

  Future<void> _onLoaded(RiveLoaded state) async {
    _controller = state.controller;
    for (final inputName in _boxInputNames) {
      await Future<void>.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      await _fireBoxAnimation(inputName);
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
      onLoaded: _onLoaded,
    );
  }

  Future<void> _fireBoxAnimation(String inputName) async {
    // ignore: deprecated_member_use
    final trigger = _controller?.stateMachine.trigger(inputName);
    if (trigger != null) {
      trigger.fire();
      return;
    }

    // ignore: deprecated_member_use
    final boolean = _controller?.stateMachine.boolean(inputName);
    if (boolean == null) return;

    // Re-arm then set to true so repeated starts still work, but keep the value
    // latched because this state machine appears to depend on the bool staying on.
    boolean.value = false;
    await Future<void>.delayed(const Duration(milliseconds: 16));
    if (!mounted) return;

    boolean.value = true;
  }
}
