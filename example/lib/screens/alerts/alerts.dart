import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class AlertsOverviewScreen extends StatelessWidget {
  const AlertsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BASF Alerts')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            const Text('App Snackbar (Click it)'),
            const Divider(),
            BasfTextButton.contained(
              text: 'Info',
              onPressed:
                  () =>
                      AppSnackBar.info(message: 'Button pressed').show(context),
            ),
            BasfTextButton.contained(
              text: 'Error',
              onPressed:
                  () => AppSnackBar.error(
                    message: 'Button pressed',
                  ).show(context),
            ),
          ].joinWithSeparator(VerticalSpacer.medium20()),
        ),
      ),
    );
  }
}
