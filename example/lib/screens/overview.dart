import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components_example/screens/scanner/scanner_screen.dart';
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
          padding: const EdgeInsets.symmetric(vertical: Dimens.paddingMedium20),
          children: [
            BasfTextButton.contained(
              text: 'BASF Alerts',
              expanded: true,
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
              expanded: true,
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
              expanded: true,
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
              expanded: true,
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
              expanded: true,
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
              expanded: true,
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
              expanded: true,
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
              expanded: true,
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
              expanded: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const ThemesOverviewScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.contained(
              text: 'Scanner',
              expanded: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) {
                      return BlocProvider<ScannerCubit>(
                        create: (context) => ScannerCubit(id: 'scanner_1'),
                        child: const ScannerScreen(),
                      );
                    },
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
