import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components_example/screens/buttons/outlined_buttons.dart';
import 'package:basf_flutter_components_example/screens/buttons/text_buttons_contained.dart';
import 'package:basf_flutter_components_example/screens/buttons/text_buttons_transparent.dart';
import 'package:flutter/material.dart';

class ButtonsOverviewScreen extends StatelessWidget {
  const ButtonsOverviewScreen({super.key});

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
              text: 'Text Contained Buttons',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const TextButtonsContainedScreen(),
                  ),
                );
              },
            ),
            BasfOutlinedButton(
              text: 'Outlined Buttons',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const OutlinedButtonsScreen(),
                  ),
                );
              },
            ),
            BasfTextButton.transparent(
              context: context,
              text: 'Transparent Buttons',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const TextButtonsTransparentScreen(),
                  ),
                );
              },
            ),
            SliderButton(
              text: 'Basf Slider button',
              onConfirmation: () {},
            ),
          ].joinWithSeparator(VerticalSpacer.medium20()),
        ),
      ),
    );
  }
}
