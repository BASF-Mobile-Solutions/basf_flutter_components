import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class TextButtonsTransparentScreen extends StatelessWidget {
  const TextButtonsTransparentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[
      ///Only Text Button
      BasfTextButton.transparent(
        context: context,
        text: 'Only Text',
        onPressed: () => _onPressed(context),
      ),

      ///Button with leading icon
      BasfTextButton.transparent(
        context: context,
        text: 'With Leading Icon',
        leadingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Button with trailing icon
      BasfTextButton.transparent(
        context: context,
        text: 'With Trailing Icon',
        trailingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Icon Only Button
      BasfTextButton.transparent(
        context: context,
        leadingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Expanded Button
      BasfTextButton.transparent(
        context: context,
        text: 'Expanded Button',
        expanded: true,
        onPressed: () => _onPressed(context),
      ),

      ///Sized Button
      BasfTextButton.transparent(
        context: context,
        text: 'Sized Button',
        size: const Size(250, 80),
        onPressed: () => _onPressed(context),
      ),

      BasfTextButton.transparent(
        context: context,
        expanded: true,
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
        context: context,
        text: 'Styled Button',
        onPressed: () => _onPressed(context),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          primary: BasfColors.red,
        ),
      ),

      ///Disabled Button
      BasfTextButton.transparent(
        context: context,
        text: 'Disabled Button',
      ),

      ///Hint Button
      BasfTextButton.hint(
        context: context,
        text: 'Hint Button',
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
