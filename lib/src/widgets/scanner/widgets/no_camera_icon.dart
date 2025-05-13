import 'package:flutter/material.dart';

/// No camera icon
class NoCameraIcon extends StatelessWidget {
  ///
  const NoCameraIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.no_photography_outlined,
      size: 30,
      color: Theme.of(context).primaryColor,
    );
  }
}
