import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'outlined_buttons.dart';
import 'text_buttons_contained.dart';
import 'text_buttons_transparent.dart';

class ButtonsOverviewScreen extends StatelessWidget {
  const ButtonsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BASF Buttons'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.paddingMedium20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasfTextButton.contained(
              alignment: Alignment.center,
              text: 'Text Contained Buttons',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TextButtonsContainedScreen(),
                    ));
              },
            ),
            const SizedBox(height: 20),
            BasfOutlinedButton(
              alignment: Alignment.center,
              text: 'Outlined Buttons',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OutlinedButtonsScreen(),
                    ));
              },
            ),
            const SizedBox(height: 20),
            BasfTextButton.transparent(
              alignment: Alignment.center,
              text: 'Transparent Buttons',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const TextButtonsTransparentScreen(),
                    ));
              },
            ),
            const SizedBox(height: 20),
            SliderButton(
              onConfirmation: () {},
            ),
          ],
        ),
      ),
    );
  }
}
