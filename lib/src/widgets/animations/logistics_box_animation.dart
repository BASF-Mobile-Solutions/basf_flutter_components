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
  late final StateMachineController controller;

  Future<void> _onInit(Artboard art) async {
    controller = StateMachineController.fromArtboard(art, 'State Machine 1')!;

    art.addController(controller);

    final box2Incoming = controller.findInput('Box_2') as SMIInput<bool>?;
    final box3Incoming = controller.findInput('Box_3') as SMIInput<bool>?;
    final box4Incoming = controller.findInput('Box_4') as SMIInput<bool>?;

    final boxList = [box2Incoming, box3Incoming, box4Incoming];

    for (final boxAnimation in boxList) {
      await Future.delayed(const Duration(seconds: 3), () {
        boxAnimation?.value = true;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
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
}
