import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';

class TextButtonsTransparentScreen extends StatelessWidget {
  const TextButtonsTransparentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      ///Only Text Button
      BasfTextButton.transparent(
        text: 'Only Text',
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
      ),

      ///Button with leading icon
      BasfTextButton.transparent(
        text: 'With Leading Icon',
        alignment: Alignment.center,
        leadingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Button with trailing icon
      BasfTextButton.transparent(
        text: 'With Trailing Icon',
        alignment: Alignment.center,
        trailingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Icon Only Button
      BasfTextButton.transparent(
        alignment: Alignment.center,
        leadingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Expanded Button
      BasfTextButton.transparent(
        text: 'Expanded Button',
        expanded: true,
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
      ),

      ///Sized Button
      BasfTextButton.transparent(
        text: 'Sized Button',
        size: const Size(250, 80),
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
      ),

      BasfTextButton.transparent(
        expanded: true,
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
        child: const SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            color: BasfColors.darkBlue,
          ),
        ),
      ),

      BasfTextButton.transparent(
        text: 'Styled Button',
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          primary: BasfColors.red,
        ),
      ),

      ///Disabled Button
      BasfTextButton.transparent(
        text: 'Disabled Button',
        alignment: Alignment.center,
      ),

      ///Hint Button
      BasfTextButton.hint(
        text: 'Hint Button',
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transparent Text Buttons'),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(Dimens.paddingMedium20),
          itemCount: buttons.length,
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (context, index) => VerticalSpacer.medium(),
          itemBuilder: (context, index) => buttons[index],
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) =>
      AppSnackBar.info(message: 'Button pressed').show(context);
}
