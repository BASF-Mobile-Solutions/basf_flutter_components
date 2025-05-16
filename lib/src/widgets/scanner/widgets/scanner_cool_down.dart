import 'package:flutter/material.dart';

/// Cooldown widget
class ScannerCoolDown extends StatefulWidget {
  ///
  const ScannerCoolDown({
    required this.coolDownVisibilityNotifier,
    this.cooldownSeconds = 3,
    this.size = 50,
    super.key,
  });

  /// Notifier
  final ValueNotifier<bool> coolDownVisibilityNotifier;
  /// Time
  final int cooldownSeconds;
  /// Size
  final double size;

  @override
  State<ScannerCoolDown> createState() => _ScannerCoolDownState();
}

class _ScannerCoolDownState extends State<ScannerCoolDown>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<int> _countdown;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.cooldownSeconds),
    );

    _countdown = StepTween(
      begin: widget.cooldownSeconds,
      end: 0,
    ).animate(_controller);

    widget.coolDownVisibilityNotifier.addListener(startCoolDown);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.coolDownVisibilityNotifier.value = false;
      }
    });
  }

  void startCoolDown() {
    if (widget.coolDownVisibilityNotifier.value) {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.coolDownVisibilityNotifier,
      builder: (context, visible, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: visible ? cooldown() : const SizedBox.shrink(),
        );
      },
    );
  }

  Widget cooldown() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => SizedBox(
            height: widget.size,
            width: widget.size,
            child: CircularProgressIndicator(
              value: 1 - _controller.value,
              color: Colors.white.withAlpha(230),
              strokeWidth: 4,
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _countdown,
          builder: (context, child) => Text(
            '${_countdown.value}',
            style: TextStyle(
              color: Colors.white.withAlpha(230),
              fontWeight: FontWeight.bold,
              fontSize: widget.size / 1.7,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.coolDownVisibilityNotifier.removeListener(startCoolDown);
    _controller.dispose();
    super.dispose();
  }
}
