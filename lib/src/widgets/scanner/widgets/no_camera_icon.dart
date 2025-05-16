import 'package:flutter/material.dart';

/// No camera icon
class NoCameraIcon extends StatelessWidget {
  ///
  const NoCameraIcon({
    super.key,
    this.size = 30,
    this.color,
  });

  ///
  final double size;
  ///
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.no_photography_outlined,
      size: size,
      color: color ?? Theme.of(context).primaryColor,
    );
  }
}
