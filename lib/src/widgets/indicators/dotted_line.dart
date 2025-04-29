import 'package:flutter/material.dart';

/// Dotted line
class DottedLine extends StatelessWidget {
  /// Dotted line
  const DottedLine({
    required this.color,
    required this.backgroundColor,
    this.height = 1,
    this.dashWidth = 5,
    this.dashSpace = 5,
    super.key,
  });

  ///
  final double height;

  ///
  final Color color;

  ///
  final Color backgroundColor;

  ///
  final double dashWidth;

  ///
  final double dashSpace;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedLinePainter(
        color: color,
        backgroundColor: backgroundColor,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      size: Size(double.infinity, height),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  _DottedLinePainter({
    required this.color,
    required this.backgroundColor,
    this.dashWidth = 5,
    this.dashSpace = 5,
  });
  final Color color;
  final Color backgroundColor;
  final double dashWidth;
  final double dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint =
        Paint()
          ..color = backgroundColor
          ..strokeWidth = size.height
          ..style = PaintingStyle.fill;

    final paint =
        Paint()
          ..color = color
          ..strokeWidth = size.height
          ..style = PaintingStyle.stroke;

    // Draw the background line
    canvas.drawLine(Offset.zero, Offset(size.width, 0), backgroundPaint);

    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
