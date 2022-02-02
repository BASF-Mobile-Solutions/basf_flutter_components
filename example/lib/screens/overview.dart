import 'package:basf_flutter_components/widgets/buttons/text_button.dart';
import 'package:flutter/material.dart';

import 'screens.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basf Component Library'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BasfTextButton(
              text: 'Basf Fonts',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FontsScreen(),
                    ));
              },
            ),
            const SizedBox(height: 15),
            BasfTextButton(
              text: 'Basf Colors',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ColorsOverviewPage(),
                    ));
              },
            ),
            const SizedBox(height: 15),
            BasfTextButton(
              text: 'Basf Buttons',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ButtonsOverviewPage(),
                    ));
              },
            ),
            const SizedBox(height: 15),
            BasfTextButton(
              text: 'Basf Forms',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FormsOverviewPage(),
                    ));
              },
            ),
            const SizedBox(height: 15),
            BasfTextButton(
              text: 'Basf Dialogs',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DialogOverviewPage(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}