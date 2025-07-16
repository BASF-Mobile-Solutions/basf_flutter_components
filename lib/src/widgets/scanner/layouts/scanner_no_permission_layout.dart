import 'dart:async';

import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/l10n/localizations/basf_components_localizations.dart';
import 'package:flutter/material.dart';

/// Layout for no permission to use camera
class ScannerNoPermissionLayout extends StatefulWidget {
  ///
  const ScannerNoPermissionLayout({
    super.key,
  });

  @override
  State<ScannerNoPermissionLayout> createState() =>
      _ScannerNoPermissionLayoutState();
}

class _ScannerNoPermissionLayoutState extends State<ScannerNoPermissionLayout>
    with WidgetsBindingObserver {
  bool recheckPermissionsAfterResume = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed when recheckPermissionsAfterResume:
        recheckPermissionsAfterResume = false;
        unawaited(
          context.read<ScannerCubit>().checkPermissionOrOpenSettings(
            isRecheck: true,
          ),
        );
      case AppLifecycleState.paused:
        recheckPermissionsAfterResume = true;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Dimens.paddingDefault,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        noCameraIcon(context),
        BasfTextButton.transparent(
          text: BasfComponentsLocalizations.of(context).provideCameraPermission,
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(
              context,
            ).primaryColor.withValues(alpha: 0.05),
          ),
          onPressed: context.read<ScannerCubit>().checkPermissionOrOpenSettings,
        ),
      ],
    );
  }

  ///
  Widget noCameraIcon(BuildContext context) {
    return Icon(
      Icons.no_photography_outlined,
      size: 30,
      color: Theme.of(context).primaryColor,
    );
  }
}
