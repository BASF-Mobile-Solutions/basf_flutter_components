import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'contained_button.dart';

class ButtonsOverviewPage extends StatelessWidget {
  const ButtonsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basf Buttons')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasfTextButton(
              text: 'Contained Button',
              color: BasfColors.darkBlue,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContainedButtonPage(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
