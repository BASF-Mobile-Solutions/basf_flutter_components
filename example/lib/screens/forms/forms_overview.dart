import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components_example/screens/forms/options.dart';
import 'package:basf_flutter_components_example/screens/forms/text_field.dart';
import 'package:flutter/material.dart';

class FormsOverviewScreen extends StatelessWidget {
  const FormsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BASF Forms')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasfTextButton.contained(
              text: 'BASF Text Fields',
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const TextFieldScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.contained(
              text: 'BASF Options',
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const OptionsScreen(),
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
