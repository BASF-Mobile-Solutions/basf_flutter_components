import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class TextButtonsContainedScreen extends StatelessWidget {
  const TextButtonsContainedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[
      ///Only Text Button
      BasfTextButton.contained(
        text: 'Only Text',
        onPressed: () => _onPressed(context),
      ),

      ///Button with leading icon
      BasfTextButton.contained(
        text: 'With Leading Icon',
        leadingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Button with trailing icon
      BasfTextButton.contained(
        text: 'With Trailing Icon',
        trailingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Icon Only Button
      BasfTextButton.contained(
        leadingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Expanded Button
      BasfTextButton.contained(
        expanded: true,
        text: 'Expanded Button',
        onPressed: () => _onPressed(context),
      ),

      ///Sized Button
      BasfTextButton.contained(
        text: 'Sized Button',
        size: const Size(250, 80),
        onPressed: () => _onPressed(context),
      ),

      BasfTextButton.contained(
        expanded: true,
        onPressed: () => _onPressed(context),
        child: const SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            color: BasfColors.white,
          ),
        ),
      ),

      BasfTextButton.contained(
        text: 'Styled Button',
        onPressed: () => _onPressed(context),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: BasfColors.red,
        ),
      ),

      ///Disabled Button
      const BasfTextButton.contained(
        text: 'Disabled Button',
      ),

      ///Disabled Button
      BasfTextButton.hint(
        text: 'hint Button',
        context: context,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contained Text Buttons'),
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
