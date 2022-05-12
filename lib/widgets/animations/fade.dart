import 'package:flutter/material.dart';

/// Hides and shows child [Widget] with a beautiful [Curves.easeOut] animation
class Fade extends StatefulWidget {
  final Widget child;
  final bool visible;
  final Duration duration;

  const Fade({
    Key? key,
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  State<Fade> createState() => _FadeState();
}

class _FadeState extends State<Fade> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

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
        curve: Curves.easeOut,
      ),
      child: SizeTransition(
        axisAlignment: 1,
        sizeFactor: CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ),
        child: widget.child,
      ),
    );
  }
}
