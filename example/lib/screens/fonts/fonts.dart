import 'package:flutter/material.dart';

enum ButtonType { outlined, elevated, text }

class FontsScreen extends StatelessWidget {
  const FontsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BASF demo'),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  Widget body() {
    return Builder(
      builder: (context) {
        return ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: allStylesTexts(context),
        );
      },
    );
  }

  Widget button(ButtonType buttonType) {
    return Builder(
      builder: (context) {
        switch (buttonType) {
          case ButtonType.outlined:
            return OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined button'),
            );
          case ButtonType.elevated:
            return ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated button'),
            );
          case ButtonType.text:
            return TextButton(
              onPressed: () {},
              child: const Text('Text button'),
            );
        }
      },
    );
  }

  Widget text({
    required TextStyle textStyle,
    String? text,
    String styleType = '',
  }) {
    return Text(text ?? styleType, style: textStyle);
  }

  List<Widget> allStylesTexts(BuildContext context) {
    return [
      text(
        textStyle: Theme.of(context).textTheme.displayLarge!,
        styleType: 'headline1',
      ),
      text(
        textStyle: Theme.of(context).textTheme.displayMedium!,
        styleType: 'headline2',
      ),
      text(
        textStyle: Theme.of(context).textTheme.displaySmall!,
        styleType: 'headline3',
      ),
      text(
        textStyle: Theme.of(context).textTheme.headlineMedium!,
        styleType: 'headline4',
      ),
      text(
        textStyle: Theme.of(context).textTheme.headlineSmall!,
        styleType: 'headline5',
      ),
      text(
        textStyle: Theme.of(context).textTheme.titleLarge!,
        styleType: 'headline6',
      ),
      text(
        textStyle: Theme.of(context).textTheme.bodyLarge!,
        styleType: 'bodyText1',
      ),
      text(
        textStyle: Theme.of(context).textTheme.bodyMedium!,
        styleType: 'bodyText2',
      ),
      text(
        textStyle: Theme.of(context).textTheme.titleMedium!,
        styleType: 'subtitle1',
      ),
      text(
        textStyle: Theme.of(context).textTheme.titleSmall!,
        styleType: 'subtitle2',
      ),
      text(
        textStyle: Theme.of(context).textTheme.bodySmall!,
        styleType: 'caption',
      ),
      text(
        textStyle: Theme.of(context).textTheme.labelLarge!,
        styleType: 'button',
      ),
      text(
        textStyle: Theme.of(context).textTheme.labelSmall!,
        styleType: 'overline',
      ),
    ];
  }
}
