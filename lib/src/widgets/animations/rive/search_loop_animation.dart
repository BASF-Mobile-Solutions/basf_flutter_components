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
  static const _tapTriggerBind = 'onTap';
  static const _doubleTapTriggerBind = 'onDoubleTap';

  ViewModelInstanceColor? _primaryColor;
  ViewModelInstanceTrigger? _tapTrigger;
  ViewModelInstanceTrigger? _doubleTapTrigger;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _applyPrimaryColor(Theme.of(context).primaryColor);
  }

  void _onLoaded(RiveLoaded state) {
    final viewModelInstance = state.viewModelInstance;
    _primaryColor = viewModelInstance?.color(_primaryColorBind);
    _tapTrigger = viewModelInstance?.trigger(_tapTriggerBind);
    _doubleTapTrigger = viewModelInstance?.trigger(_doubleTapTriggerBind);
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

  void onTap() => _tapTrigger?.trigger();
  void onDoubleTap() => _doubleTapTrigger?.trigger();
  void _applyPrimaryColor(Color color) => _primaryColor?.value = color;
}
