import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'text_field.dart';

class FormsOverviewScreen extends StatelessWidget {
  const FormsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BASF Forms')),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.paddingMedium20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasfTextButton.contained(
              alignment: Alignment.center,
              text: 'BASF Text Fields',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TextFieldScreen(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
