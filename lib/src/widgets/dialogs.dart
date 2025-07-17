import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/l10n/localizations/basf_components_localizations.dart';
import 'package:flutter/material.dart';

/// {@template basf_alert_dialog}
/// A BASF-styled customized alert dialog
/// {@endtemplate}
class BasfAlertDialog extends StatelessWidget {
  /// {@macro basf_alert_dialog}
  const BasfAlertDialog({
    required this.description,
    super.key,
    this.onConfirmed,
    this.onDismissed,
    this.onlyConfirm = false,
    this.title,
  });

  ///
  final String? title;

  /// Alert description
  final String description;

  /// Action to be performed when its confirmed
  final Function? onConfirmed;

  /// Action to be performed when its dismissed
  final Function? onDismissed;

  /// Hides dismiss option
  final bool onlyConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BasfThemes.defaultBorderRadius,
      ),
      title: Text(
        title ?? BasfComponentsLocalizations.of(context).warning,
        textAlign: TextAlign.center,
        style: BasfThemes.mainTextTheme.titleLarge,
      ),
      content: Text(
        description,
        textAlign: TextAlign.center,
        style: BasfThemes.mainTextTheme.titleMedium,
      ),
      actions: <Widget>[
        if (!onlyConfirm) _dismissButton(),
        if (!onlyConfirm) VerticalSpacer.normal(),
        _confirmButton(),
      ],
    );
  }

  Widget _dismissButton() {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: Dimens.paddingMedium),
          child: BasfOutlinedButton(
            expanded: true,
            text: BasfComponentsLocalizations.of(context).generalAbort,
            style: OutlinedButton.styleFrom(
              foregroundColor: BasfColors.red,
              side: const BorderSide(color: BasfColors.red),
            ),
            onPressed: () {
              final dynamic result = onDismissed?.call();
              Navigator.of(context).pop(result);
            },
          ),
        );
      },
    );
  }

  Widget _confirmButton() {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: Dimens.paddingMedium),
          child: BasfTextButton.contained(
            text: BasfComponentsLocalizations.of(context).generalConfirm,
            expanded: true,
            onPressed: () {
              final dynamic result = onConfirmed?.call();
              Navigator.of(context).pop(result);
            },
          ),
        );
      },
    );
  }
}
