import 'package:basf_flutter_components/utils/gen/assets.gen.dart';
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
  StateMachineController? _controller;

  static const _stateMachineName = 'State Machine 1';
  static const _boxInputNames = <String>['Box_2', 'Box_3', 'Box_4'];

  Future<void> _onInit(Artboard art) async {
    final controller = StateMachineController.fromArtboard(
      art,
      _stateMachineName,
    );
    if (controller == null) {
      return;
    }

    art.addController(controller);
    _controller = controller;

    for (final inputName in _boxInputNames) {
      await Future<void>.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      await _fireBoxAnimation(inputName);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: animation(context),
    );
  }

  Widget animation(BuildContext context) {
    return BasfAssets.rive.logisticsBox.rive(
      animations: const ['Idle'],
      onInit: _onInit,
    );
  }

  Future<void> _fireBoxAnimation(String inputName) async {
    final input = _controller?.findSMI(inputName);

    if (input is SMITrigger) {
      input.fire();
      return;
    }

    if (input is! SMIBool) return;

    // Re-arm then set to true so repeated starts still work, but keep the value
    // latched because this state machine appears to depend on the bool staying on.
    input.value = false;
    await Future<void>.delayed(const Duration(milliseconds: 16));
    if (!mounted) return;

    input.value = true;
  }
}
