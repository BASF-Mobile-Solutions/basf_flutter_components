import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';

class ContainedButtonPage extends StatelessWidget {
  const ContainedButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onPressed() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Button pressed'),
          duration: Duration(milliseconds: 500),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Basf Contained Buttons')),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ///Only Text Button
              BasfTextButton(
                text: 'Only Text',
                color: BasfColors.darkBlue,
                onPressed: _onPressed,
              ),

              ///Button with leading icon
              BasfTextButton(
                text: 'With Leading Icon',
                color: BasfColors.darkBlue,
                leadingIcon: BasfIcons.arrow_forward,
                onPressed: _onPressed,
              ),

              ///Button with trailing icon
              BasfTextButton(
                text: 'With Trailing Icon',
                color: BasfColors.darkBlue,
                trailingIcon: BasfIcons.arrow_forward,
                onPressed: _onPressed,
              ),

              ///Icon Only Button
              BasfTextButton(
                iconOnly: BasfIcons.arrow_forward,
                color: BasfColors.darkBlue,
                onPressed: _onPressed,
              ),

              ///Expanded Button
              BasfTextButton(
                expand: true,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                text: 'Expanded Button',
                color: BasfColors.darkBlue,
                onPressed: _onPressed,
              ),

              ///Sized Button
              BasfTextButton(
                width: 250,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                text: 'Sized Button',
                color: BasfColors.darkBlue,
                onPressed: _onPressed,
              ),

              ///Disabled Button
              const BasfTextButton(
                text: 'Disabled Button',
                color: BasfColors.darkBlue,
                onPressed: null,
              ),

              ///Negative Button
              Container(
                color: BasfColors.darkGrey,
                height: 200,
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BasfTextButton(
                      text: 'Negative Button',
                      color: BasfColors.darkBlue,
                      negative: true,
                      trailingIcon: BasfIcons.arrow_forward,
                      onPressed: _onPressed,
                    ),

                    ///Negative Disabled Button
                    const BasfTextButton(
                      text: 'Negative Disabled',
                      negative: true,
                      color: BasfColors.darkBlue,
                      onPressed: null,
                    ),

                    ///Negative Icon Only Button
                    BasfTextButton(
                      iconOnly: BasfIcons.arrow_forward,
                      color: BasfColors.darkBlue,
                      negative: true,
                      onPressed: _onPressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
