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
      theme: ThemeData(
        primarySwatch: BasfColors.darkBlue,
        primaryColor: BasfColors.darkBlue,
        disabledColor: BasfColors.middleGrey,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          color: BasfColors.darkBlue,
        ),
      ),
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
            BasfContainedButton(
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
            VerticalSpacer.large(),
            BasfContainedButton(
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
            VerticalSpacer.large(),
            BasfContainedButton(
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
            VerticalSpacer.large(),
            BasfContainedButton(
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
            VerticalSpacer.large(),
            BasfContainedButton(
              text: 'Basf Icons',
              color: BasfColors.darkBlue,
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
