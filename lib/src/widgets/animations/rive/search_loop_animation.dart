import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
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
  static final DataBind _dataBind = DataBind.auto();
  static const _stateMachineName = 'State Machine';
  static const _primaryColorBind = 'primaryColor';
  static const _tapTriggerName = 'onTap';
  static const _doubleTapTriggerName = 'onDoubleTap';

  RiveWidgetController? _controller;
  ViewModelInstanceColor? _primaryColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _applyPrimaryColor(Theme.of(context).primaryColor);
  }

  void _onLoaded(RiveLoaded state) {
    _controller = state.controller;
    _primaryColor = state.viewModelInstance?.color(_primaryColorBind);
    _applyPrimaryColor(Theme.of(context).primaryColor);
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
    return BasfRiveAnimationStateMachineAsset(
      asset: BasfAssets.rive.searchLoop,
      animationNames: const ['Searching', 'Flipping'],
      stateMachine: _stateMachineName,
      dataBind: _dataBind,
      onLoaded: _onLoaded,
    );
  }

  void onTap() {
    // ignore: deprecated_member_use
    _controller?.stateMachine.trigger(_tapTriggerName)?.fire();
  }

  void onDoubleTap() {
    // ignore: deprecated_member_use
    _controller?.stateMachine.trigger(_doubleTapTriggerName)?.fire();
  }

  void _applyPrimaryColor(Color color) {
    _primaryColor?.value = color;
  }
}
