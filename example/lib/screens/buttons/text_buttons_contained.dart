import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class TextButtonsContainedScreen extends StatelessWidget {
  const TextButtonsContainedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      ///Only Text Button
      BasfTextButton.contained(
        text: 'Only Text',
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
      ),

      ///Button with leading icon
      BasfTextButton.contained(
        text: 'With Leading Icon',
        alignment: Alignment.center,
        leadingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Button with trailing icon
      BasfTextButton.contained(
        text: 'With Trailing Icon',
        alignment: Alignment.center,
        trailingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Icon Only Button
      BasfTextButton.contained(
        alignment: Alignment.center,
        leadingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Expanded Button
      BasfTextButton.contained(
        expanded: true,
        alignment: Alignment.center,
        text: 'Expanded Button',
        onPressed: () => _onPressed(context),
      ),

      ///Sized Button
      BasfTextButton.contained(
        text: 'Sized Button',
        size: const Size(250, 80),
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
      ),

      BasfTextButton.contained(
        expanded: true,
        alignment: Alignment.center,
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
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: BasfColors.red,
        ),
      ),

      ///Disabled Button
      const BasfTextButton.contained(
        alignment: Alignment.center,
        text: 'Disabled Button',
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
