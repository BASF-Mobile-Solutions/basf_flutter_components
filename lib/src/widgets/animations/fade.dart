import 'package:flutter/material.dart';

/// {@template fade_widget}
/// Hides and shows child [Widget] with a beautiful [Curves.easeOut] animation
/// {@endtemplate}
class Fade extends StatefulWidget {
  /// {@macro fade_widget}
  const Fade({
    super.key,
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOut,
  });

  /// The Widget that wants to be hidden
  final Widget child;

  /// The current visibility of the widget
  final bool visible;

  /// The duration of the transition
  final Duration duration;

  /// The curve of the animation
  final Curve curve;

  @override
  State<Fade> createState() => _FadeState();
}

class _FadeState extends State<Fade> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      value: widget.visible ? 1.0 : 0.0,
      duration: widget.duration,
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Fade oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.visible && widget.visible) {
      _animationController.forward();
    } else if (oldWidget.visible && !widget.visible) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
      ),
      child: SizeTransition(
        axisAlignment: 1,
        sizeFactor: CurvedAnimation(
          parent: _animationController,
          curve: widget.curve,
        ),
        child: widget.child,
      ),
    );
  }
}
