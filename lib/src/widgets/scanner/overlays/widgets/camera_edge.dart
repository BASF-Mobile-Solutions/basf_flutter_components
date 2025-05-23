import 'package:flutter/material.dart';

/// Camera edges
class CameraEdges extends StatelessWidget {
  ///
  const CameraEdges({this.color = Colors.white54, this.length = 20, super.key});

  /// Border color
  final Color color;

  ///
  final double length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            edge(Border(left: borderSide(), top: borderSide())),
            edge(Border(left: borderSide(), bottom: borderSide())),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            edge(Border(right: borderSide(), top: borderSide())),
            edge(Border(right: borderSide(), bottom: borderSide())),
          ],
        ),
      ],
    );
  }

  ///
  BorderSide borderSide() => BorderSide(color: color, width: 2);

  ///
  Widget edge(Border border) {
    return Container(
      height: length,
      width: length,
      decoration: BoxDecoration(border: border),
    );
  }
}
