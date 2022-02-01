import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Uses to generate IconData for BasfIcons
class BasfIconsData extends IconData {
  const BasfIconsData(int code)
      : super(
          code,
          fontFamily: 'BasfIcons',
          fontPackage: 'basf_flutter_components',
        );
}

class IconsOverviewPage extends StatelessWidget {
  const IconsOverviewPage({Key? key}) : super(key: key);

  static const _from = 0xe800;
  static const _to = 0xe84f;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basf Icons')),
      body: GridView.extent(
        maxCrossAxisExtent: 130,
        children: List.generate(
          _to - _from + 1,
          (index) {
            final code = index + _from;
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
