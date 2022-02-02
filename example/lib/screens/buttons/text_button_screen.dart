import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';

class TextButtonScreen extends StatelessWidget {
  const TextButtonScreen({Key? key}) : super(key: key);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///Only Text Button
            BasfTextButton(
              text: 'Only Text',
              onPressed: _onPressed,
            ),

            ///Button with leading icon
            BasfTextButton(
              text: 'With Leading Icon',
              leadingIcon: BasfIcons.arrow_forward,
              onPressed: _onPressed,
            ),

            ///Button with trailing icon
            BasfTextButton(
              text: 'With Trailing Icon',
              trailingIcon: BasfIcons.arrow_forward,
              onPressed: _onPressed,
            ),

            ///Icon Only Button
            BasfTextButton(
              leadingIcon: BasfIcons.arrow_forward,
              onPressed: _onPressed,
            ),

            ///Expanded Button
            BasfTextButton(
              expanded: true,
              text: 'Expanded Button',
              onPressed: _onPressed,
            ),

            ///Sized Button
            BasfTextButton(
              size: const Size(250, 80),
              text: 'Sized Button',
              onPressed: _onPressed,
            ),

            ///Disabled Button
            const BasfTextButton(
              text: 'Disabled Button',
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
                    isOutlined: true,
                    trailingIcon: BasfIcons.arrow_forward,
                    onPressed: _onPressed,
                  ),

                  ///Negative Disabled Button
                  const BasfTextButton(
                    text: 'Negative Disabled',
                    isOutlined: true,
                    onPressed: null,
                  ),

                  ///Negative Icon Only Button
                  BasfTextButton(
                    leadingIcon: BasfIcons.arrow_forward,
                    isOutlined: true,
                    onPressed: _onPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
