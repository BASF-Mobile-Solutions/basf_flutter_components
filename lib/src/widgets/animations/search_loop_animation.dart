import 'package:basf_flutter_components/utils/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:rive/components.dart';
import 'package:rive/rive.dart';

///
class SearchLoopAnimation extends StatefulWidget {
  ///
  const SearchLoopAnimation({
    this.size = const Size(500, 160),
    super.key,
  });

  ///
  final Size size;

  @override
  State<SearchLoopAnimation> createState() => _SearchLoopAnimationState();
}

class _SearchLoopAnimationState extends State<SearchLoopAnimation> {
  late final StateMachineController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _onInit(Artboard art) async {
    controller = StateMachineController.fromArtboard(
      art,
      'State Machine',
    )!;

    art
      ..addController(controller)
      ..forEachComponent((shape) {
        final texts = <String>['Normal Text', 'Zoomed Text'];

        if (texts.contains(shape.name) && shape is Node) {
          for (final shape in shape.children.whereType<Shape>()) {
            shape.strokes.first.paint.color = Theme.of(context).primaryColor;
          }
        }

        final rings = ['Black Ring Top', 'Black Ring Bottom'];

        if (rings.contains(shape.name) && shape is Shape) {
          shape.fills.first.paint.color = Theme.of(context).primaryColor;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: SizedBox.fromSize(
        size: widget.size,
        child: animation(context),
      ),
    );
  }

  Widget animation(BuildContext context) {
    return RiveAnimation.asset(
      Assets.rive.searchLoop.path,
      animations: const ['Searching', 'Flipping'],
      onInit: _onInit,
    );
  }

  void onTap() => (controller.findSMI('onTap') as SMITrigger).fire();
  void onDoubleTap() =>
      (controller.findSMI('onDoubleTap') as SMITrigger).fire();
}
