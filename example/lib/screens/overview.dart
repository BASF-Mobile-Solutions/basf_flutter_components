import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components_example/screens/screens.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BASF Components')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium20),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: Dimens.paddingMedium),
          children: [
            BasfTextButton.contained(
              text: 'BASF Alerts',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const AlertsOverviewScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.contained(
              text: 'BASF Animations',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const AnimationsOverviewScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.contained(
              text: 'BASF Buttons',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const ButtonsOverviewScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.contained(
              text: 'BASF Colors',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const ColorsOverviewScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.contained(
              text: 'BASF Dialogs',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const DialogOverviewScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.contained(
              text: 'BASF Fonts',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const FontsScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.contained(
              text: 'BASF Forms',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const FormsOverviewScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.contained(
              text: 'BASF Icons',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const IconsOverviewScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.contained(
              text: 'BASF Themes',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const ThemesOverviewScreen(),
                  ),
                );
              },
            ),
          ].joinWithSeparator(VerticalSpacer.medium20()),
        ),
      ),
    );
  }
}
