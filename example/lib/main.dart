// ignore_for_file: public_member_api_docs

import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components_example/screens/overview.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BASF Components',
      theme: BasfThemes.lightMainTheme(),
      home: const OverviewScreen(),
    );
  }
}
