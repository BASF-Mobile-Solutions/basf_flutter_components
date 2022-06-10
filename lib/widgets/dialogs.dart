import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class BasfAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final String dismissText;
  final String confirmText;
  final Function? onConfirmed;
  final Function? onDismissed;
  final bool onlyConfirm;

  const BasfAlertDialog({
    Key? key,
    required this.description,
    this.title = 'Warning',
    this.dismissText = 'Cancel',
    this.confirmText = 'Confirm',
    this.onConfirmed,
    this.onDismissed,
    this.onlyConfirm = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: BasfThemes.defaultBorderRadius),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: BasfThemes.mainTextTheme.headline6,
      ),
      content: Text(description,
          textAlign: TextAlign.center,
          style: BasfThemes.mainTextTheme.subtitle1),
      actions: <Widget>[
        if (!onlyConfirm) dismissButton(),
        if (!onlyConfirm) VerticalSpacer.normal(),
        confirmButton(),
      ],
    );
  }

  Widget dismissButton() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(left: Dimens.paddingMedium),
        child: BasfOutlinedButton(
          expanded: true,
          text: dismissText,
          style: OutlinedButton.styleFrom(
              primary: BasfColors.red,
              side: const BorderSide(color: BasfColors.red)),
          onPressed: () {
            dynamic result = onDismissed?.call();
            Navigator.of(context).pop(result);
          },
        ),
      );
    });
  }

  Widget confirmButton() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(left: Dimens.paddingMedium),
        child: BasfTextButton.contained(
          text: confirmText,
          expanded: true,
          onPressed: () {
            dynamic result = onConfirmed?.call();
            Navigator.of(context).pop(result);
          },
        ),
      );
    });
  }
}
