import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'input_field.dart';

class FormsOverviewPage extends StatelessWidget {
  const FormsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basf Forms')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasfTextButton(
              text: 'Basf Input Fields',
              color: BasfColors.darkBlue,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InputFieldPage(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
