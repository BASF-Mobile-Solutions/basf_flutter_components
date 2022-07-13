import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class DialogOverviewScreen extends StatelessWidget {
  const DialogOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BASF Dialogs')),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.paddingMedium20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BasfTextButton.contained(
              text: 'Show datePicker',
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: BasfThemes.datePickerButtonTheme(
                        Theme.of(context),
                      ),
                      child: child!,
                    );
                  },
                );
              },
            ),
            BasfTextButton.contained(
              text: 'Only Confirm',
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return const BasfAlertDialog(
                      title: 'Info',
                      description: 'Only Confirm is default',
                      onlyConfirm: true,
                    );
                  },
                );
              },
            ),
            BasfTextButton.contained(
              text: 'Changed Text',
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return const BasfAlertDialog(
                      title: 'Title',
                      description: 'Body Text',
                      confirmText: 'Confirm Text',
                      dismissText: 'Dismiss Text',
                    );
                  },
                );
              },
            ),
            BasfTextButton.contained(
              text: 'Select functions',
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (_) {
                    return BasfAlertDialog(
                      description: 'Shows error or info snackbars '
                          'on different buttons',
                      onConfirmed: () {
                        AppSnackBar.info(message: 'Confirm pressed')
                            .show(context);
                      },
                      onDismissed: () {
                        AppSnackBar.error(message: 'Cancel pressed')
                            .show(context);
                      },
                    );
                  },
                );
              },
            ),
          ].joinWithSeparator(VerticalSpacer.medium20()),
        ),
      ),
    );
  }
}
