import 'package:basf_flutter_components_example/models/icon_data.dart';
import 'package:flutter/material.dart';

class IconsOverviewScreen extends StatelessWidget {
  const IconsOverviewScreen({super.key});

  static const int _from = 0xe800;
  static const int _to = 0xe84f;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basf Icons'),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 130,
        children: List.generate(
          _to - _from + 1,
          (index) {
            final code = index + _from;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
