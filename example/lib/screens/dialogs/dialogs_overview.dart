import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';

class DialogOverviewPage extends StatelessWidget {
  const DialogOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basf Dialogs')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasfTextButton(
              text: 'Only Confirm',
              color: BasfColors.darkBlue,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const BasfAlertDialog(
                        alertTitle: 'Info',
                        alertText: 'Only Confirm is default',
                      );
                    });
              },
            ),
            const SizedBox(height: 15),
            BasfTextButton(
              text: 'Changed Text',
              color: BasfColors.darkBlue,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const BasfAlertDialog(
                        alertTitle: 'Title',
                        alertText: 'Body Text',
                        confirmText: 'Confirm Text',
                        dismissText: 'Dismiss Text',
                        onlyConfirm: false,
                      );
                    });
              },
            ),
            const SizedBox(height: 15),
            BasfTextButton(
              text: 'Select functions',
              color: BasfColors.darkBlue,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return BasfAlertDialog(
                        alertText: 'Press Confirm',
                        onlyConfirm: false,
                        onConfirmed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 800),
                              content: Text(
                                'Confirm pressed',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
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
