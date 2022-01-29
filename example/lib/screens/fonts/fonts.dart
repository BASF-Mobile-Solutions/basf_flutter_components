import 'package:basf_flutter_components/widgets/icons.dart';
import 'package:basf_flutter_components/widgets/input_field.dart';
import 'package:flutter/material.dart';

enum ButtonType {outlined, elevated, text}

class FontsScreen extends StatelessWidget {
  const FontsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BASF demo'),
        centerTitle: true,
      ),
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(4, (index) => const BottomNavigationBarItem(
            icon: Icon(BasfIcons.heart),
            label: 'label'
        )),
      ),
    );
  }

  Widget body() {
    return Builder(
        builder: (context) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              ...allStylesTexts(context),
              const SizedBox(height: 20),
              ...buttonsList(),
              const BasfInputField(),
            ],
          );
        }
    );
  }

  Widget button(ButtonType buttonType) {
    return Builder(
        builder: (context) {
          switch (buttonType) {
            case ButtonType.outlined: return OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined button'),
            );
            case ButtonType.elevated: return ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated button'),
            );
            case ButtonType.text: return TextButton(
              onPressed: () {},
              child: const Text('Text button'),
            );
          }
        }
    );
  }

  Widget text({
    required TextStyle textStyle,
    String? text,
    String styleType = '',
  }) {
    return Text(text ?? styleType, style: textStyle);
  }

  List<Widget> buttonsList() {
    return List.generate(ButtonType.values.length, (index) {
      return button(ButtonType.values[index]);
    });
  }

  List<Widget> allStylesTexts(BuildContext context) {
    return [
      text(textStyle: Theme.of(context).textTheme.headline1!, styleType: 'headline1'),
      text(textStyle: Theme.of(context).textTheme.headline2!, styleType: 'headline2'),
      text(textStyle: Theme.of(context).textTheme.headline3!, styleType: 'headline3'),
      text(textStyle: Theme.of(context).textTheme.headline4!, styleType: 'headline4'),
      text(textStyle: Theme.of(context).textTheme.headline5!, styleType: 'headline5'),
      text(textStyle: Theme.of(context).textTheme.headline6!, styleType: 'headline6'),
      text(textStyle: Theme.of(context).textTheme.bodyText1!, styleType: 'bodyText1'),
      text(textStyle: Theme.of(context).textTheme.bodyText2!, styleType: 'bodyText2'),
      text(textStyle: Theme.of(context).textTheme.subtitle1!, styleType: 'subtitle1'),
      text(textStyle: Theme.of(context).textTheme.subtitle2!, styleType: 'subtitle2'),
      text(textStyle: Theme.of(context).textTheme.caption!, styleType: 'caption'),
      text(textStyle: Theme.of(context).textTheme.button!, styleType: 'button'),
      text(textStyle: Theme.of(context).textTheme.overline!, styleType: 'overline'),
    ];
  }
}
