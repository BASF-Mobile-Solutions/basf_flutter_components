import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';

class ColorsOverviewScreen extends StatelessWidget {
  const ColorsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BasfColors.middleGrey,
      appBar: AppBar(title: const Text('BASF Colors')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            const Text('Colors with swatches (Click it)'),
            Wrap(
              spacing: 5,
              children: BasfColors.swatchColors
                  .map((color) => MaterialButton(
                        color: color,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ColorSwatchScreen(color: color),
                              ));
                        },
                      ))
                  .toList(),
            ),
            const Divider(),
            const Text('Primaries'),
            Row(
              children: BasfColors.primaries
                  .map((e) => Container(
                        height: MediaQuery.of(context).size.width / 6,
                        width: MediaQuery.of(context).size.width / 6,
                        color: e,
                      ))
                  .toList(),
            ),
            const Divider(),
            const Text('Pales'),
            Row(
              children: BasfColors.paleColors
                  .map((e) => Container(
                        height: MediaQuery.of(context).size.width / 6,
                        width: MediaQuery.of(context).size.width / 6,
                        color: e,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorSwatchScreen extends StatelessWidget {
  const ColorSwatchScreen({
    Key? key,
    required this.color,
  }) : super(key: key);
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: color),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _getSwatchWidgets(color),
      ),
    );
  }

  List<Widget> _getSwatchWidgets(MaterialColor color) {
    List<Widget> swatches = [];
    for (int i = 0; i <= 1000; i += 25) {
      if (color[i] != null) {
        swatches.add(Expanded(
          child: Container(
            color: color[i],
            alignment: Alignment.center,
            child: Text('Swatch [$i]'),
          ),
        ));
      }
    }
    return swatches;
  }
}
