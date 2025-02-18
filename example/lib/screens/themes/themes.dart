import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class ThemesOverviewScreen extends StatefulWidget {
  const ThemesOverviewScreen({super.key});

  @override
  State<ThemesOverviewScreen> createState() => _ThemesOverviewScreenState();
}

class _ThemesOverviewScreenState extends State<ThemesOverviewScreen> {
  BasfThemeType theme = BasfThemeType.darkBlue;
  bool state = true;
  List<String> values = ['Option1', 'Option2'];
  String selectedValue = 'Option1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BASF Themes')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: getThemeButtons(),
            ),
            const HorizontalSpacerWithText(
              text: 'Example Theme Output',
              color: Colors.grey,
            ),
            BasfTextButton.contained(text: 'Theme button', onPressed: () {}),
            BasfOutlinedButton(text: 'Outlined button', onPressed: () {}),
            BasfCheckbox(
              value: state,
              onChanged: (_) => setState(() => state = !state),
              text: 'Checkbox',
            ),
            RadioOptions(
              title: 'BASF Option',
              selectedValue: selectedValue,
              labelGenerator: (o) => o,
              values: values,
              onSelected: (value) {
                setState(() => selectedValue = value);
              },
            ),
          ].joinWithSeparator(VerticalSpacer.medium20()),
        ),
      ),
    );
  }

  List<Widget> getThemeButtons() {
    List<Widget> buttons;
    buttons = [];

    for (final element in BasfThemeType.values) {
      final button = TextButton(
        onPressed: () {
          setState(() => theme = element);
        },
        style: TextButton.styleFrom(backgroundColor: element.primaryColor),
        child: Text(element.name),
      );

      buttons.add(button);
    }

    return buttons;
  }
}
