import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Default error layout
class ScannerDefaultErrorLayout extends StatelessWidget {
  ///
  const ScannerDefaultErrorLayout({
    required this.message,
    super.key,
  });

  ///
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.paddingMedium),
        child: Text(
          message,
          maxLines: 4,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
