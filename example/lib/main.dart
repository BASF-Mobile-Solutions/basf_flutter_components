import 'package:basf_flutter_components_example/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';

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
              text: 'Basf Colors',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ColorsOverviewPage(),
                    ));
              },
            ),
            VerticalSpacer.large(),
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
            VerticalSpacer.large(),
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
            VerticalSpacer.large(),
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
            VerticalSpacer.large(),
            BasfTextButton(
              text: 'Basf Icons',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IconsOverviewPage(),
                    ));
              },
            ),
            VerticalSpacer.large(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
