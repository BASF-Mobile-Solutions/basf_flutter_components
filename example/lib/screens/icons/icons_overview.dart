import 'package:flutter/material.dart';

import '../../models/icon_data.dart';

class IconsOverviewScreen extends StatelessWidget {
  const IconsOverviewScreen({Key? key}) : super(key: key);

  final int _from = 0xe800;
  final int _to = 0xe84f;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basf Icons')),
      body: GridView.extent(
        maxCrossAxisExtent: 130,
        children: List.generate(
          _to - _from + 1,
          (index) {
            int code = index + _from;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(BasfIconsData(code), size: 48),
                Text(code.toRadixString(16)),
              ],
            );
          },
        ),
      ),
    );
  }
}
