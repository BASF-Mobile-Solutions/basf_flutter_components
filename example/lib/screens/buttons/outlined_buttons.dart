import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class OutlinedButtonsScreen extends StatelessWidget {
  const OutlinedButtonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      ///Only Text Button
      BasfOutlinedButton(
        text: 'Only Text',
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
      ),

      ///Button with leading icon
      BasfOutlinedButton(
        text: 'With Leading Icon',
        alignment: Alignment.center,
        leadingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Button with trailing icon
      BasfOutlinedButton(
        text: 'With Trailing Icon',
        alignment: Alignment.center,
        trailingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Icon Only Button
      BasfOutlinedButton(
        alignment: Alignment.center,
        leadingIcon: BasfIcons.arrow_forward,
        onPressed: () => _onPressed(context),
      ),

      ///Expanded Button
      BasfOutlinedButton(
        text: 'Expanded Button',
        expanded: true,
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
      ),

      ///Sized Button
      BasfOutlinedButton(
        text: 'Sized Button',
        size: const Size(250, 80),
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
      ),
      BasfOutlinedButton(
        expanded: true,
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
        child: const SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(),
        ),
      ),
      BasfOutlinedButton(
        text: 'Styled Button',
        alignment: Alignment.center,
        onPressed: () => _onPressed(context),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          side: const BorderSide(color: BasfColors.red),
          primary: BasfColors.red,
        ),
      ),

      ///Disabled Button
      const BasfOutlinedButton(
        text: 'Disabled Button',
        alignment: Alignment.center,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outlined Buttons'),
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
