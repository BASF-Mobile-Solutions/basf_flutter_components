import 'package:basf_flutter_components_example/screens/fonts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'screens/screens.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BASF Components',
      theme: BasfThemes.lightThemeDarkBlue(),
      home: const OverviewPage(),
    );
  }
}

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasfTextButton(
              text: 'Basf Fonts',
              color: BasfColors.darkBlue,
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
              color: BasfColors.darkBlue,
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
              color: BasfColors.darkBlue,
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
              color: BasfColors.darkBlue,
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
              color: BasfColors.darkBlue,
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
