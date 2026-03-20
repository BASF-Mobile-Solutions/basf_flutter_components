import 'dart:async';

import 'package:flutter/material.dart';

/// Cooldown widget
class ScannerCoolDown extends StatefulWidget {
  ///
  const ScannerCoolDown({
    this.cooldownSeconds = 3,
    this.size = 50,
    this.endTime,
    super.key,
  });

  /// Time
  final int cooldownSeconds;

  /// Size
  final double size;

  /// Current time + cooldown seconds to prevent recreation bugs during cooldown
  final DateTime? endTime;

  @override
  State<ScannerCoolDown> createState() => _ScannerCoolDownState();
}

class _ScannerCoolDownState extends State<ScannerCoolDown>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _countdown;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _initialized = true);
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.cooldownSeconds),
    );

    _countdown = StepTween(
      begin: widget.cooldownSeconds,
      end: 0,
    ).animate(_controller);

    startCoolDown();

    Future.delayed(
      Duration(milliseconds: widget.cooldownSeconds * 1000 - 200),
      () {
        if (mounted) setState(() => _initialized = false);
      },
    );
  }

  void startCoolDown() {
    double from = 0;

    if (widget.endTime != null) {
      final diff = widget.endTime!.difference(DateTime.now()).inSeconds + 1;
      final progress = diff / widget.cooldownSeconds;

      from = 1 - progress.clamp(0.0, 1.0);
    }

    unawaited(_controller.forward(from: from));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: _initialized ? 1 : 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, _) => SizedBox(
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
              '${_countdown.value + 1}',
              style: TextStyle(
                color: Colors.white.withAlpha(230),
                fontWeight: FontWeight.bold,
                fontSize: widget.size / 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
