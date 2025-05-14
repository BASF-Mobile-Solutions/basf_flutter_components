import 'package:flutter/material.dart';

/// Black transparent overlay for scanner
class Blackout extends StatelessWidget {
  ///
  const Blackout({
    super.key,
    this.borderWidth = 50,
  });

  /// Width of dark overlay
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth,
          color: Colors.black.withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              edge(context),
              edge(context, quarterTurn: 3),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              edge(context, quarterTurn: 5),
              edge(context, quarterTurn: 2),
            ],
          ),
        ],
      ),
    );
  }

  /// Edge of scanner
  Widget edge(BuildContext context, {int quarterTurn = 0}) {
    final height = MediaQuery.sizeOf(context).height * 0.03;
    const color = Colors.white54;
    const length = 2.0;

    return RotatedBox(
      quarterTurns: quarterTurn,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: length, height: height, color: color),
          Container(width: height, height: length, color: color),
        ],
      ),
    );
  }
}
