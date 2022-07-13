import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class AnimationsOverviewScreen extends StatefulWidget {
  const AnimationsOverviewScreen({super.key});

  @override
  State<AnimationsOverviewScreen> createState() =>
      _AnimationsOverviewScreenState();
}

class _AnimationsOverviewScreenState extends State<AnimationsOverviewScreen> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BASF Alerts')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            BasfTextButton.contained(
              text: 'Click to hide',
              onPressed: () => setState(() => visible = !visible),
            ),
            Fade(
              visible: visible,
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  color: BasfColors.red,
                  alignment: Alignment.center,
                  child: const Text(
                    'SUP!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            ...widgetsExample()
          ].joinWithSeparator(VerticalSpacer.medium20()),
        ),
      ),
    );
  }

  List<Widget> widgetsExample() {
    List<Widget> cs;
    cs = [];

    for (final element in BasfThemeType.values) {
      final c = Fade(
        visible: element.index.isEven ? visible : !visible,
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            color: element.primaryColor,
            alignment: Alignment.center,
            child: const Text(
              'SUP!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      );

      cs.add(c);
    }

    return cs;
  }
}
