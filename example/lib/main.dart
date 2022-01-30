import 'package:basf_flutter_components_example/screens/overview.dart';
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
