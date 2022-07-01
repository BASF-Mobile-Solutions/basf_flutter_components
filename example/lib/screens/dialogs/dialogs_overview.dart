import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';

class DialogOverviewScreen extends StatelessWidget {
  const DialogOverviewScreen({Key? key}) : super(key: key);

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
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                          data: BasfThemes.datePickerButtonTheme,
                          child: child!);
                    });
              },
            ),
            const SizedBox(height: 15),
            BasfTextButton.contained(
              text: 'Only Confirm',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const BasfAlertDialog(
                        title: 'Info',
                        description: 'Only Confirm is default',
                        onlyConfirm: true,
                      );
                    });
              },
            ),
            const SizedBox(height: 15),
            BasfTextButton.contained(
              text: 'Changed Text',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const BasfAlertDialog(
                        title: 'Title',
                        description: 'Body Text',
                        confirmText: 'Confirm Text',
                        dismissText: 'Dismiss Text',
                        onlyConfirm: false,
                      );
                    });
              },
            ),
            const SizedBox(height: 15),
            BasfTextButton.contained(
              text: 'Select functions',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return BasfAlertDialog(
                        description: 'Shows error or info snackbars '
                            'on different buttons',
                        onlyConfirm: false,
                        onConfirmed: () {
                          AppSnackBar.info(message: 'Confirm pressed')
                              .show(context);
                        },
                        onDismissed: () {
                          AppSnackBar.error(message: 'Cancel pressed')
                              .show(context);
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
