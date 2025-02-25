import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template app_snackbar}
/// Basf AppSnackBar
/// {@endtemplate}
class AppSnackBar extends StatelessWidget {
  /// {@macro app_snackbar}
  /// default
  const AppSnackBar({
    required this.message,
    super.key,
    this.prefixIcon,
    this.backgroundColor,
  });

  /// {@macro app_snackbar}
  /// info
  factory AppSnackBar.info({required String message}) =>
      AppSnackBar(message: message, prefixIcon: Icons.info);

  /// {@macro app_snackbar}
  /// error
  factory AppSnackBar.error({required String message}) {
    return AppSnackBar(
      message: message,
      prefixIcon: Icons.error,
      backgroundColor: BasfColors.red,
    );
  }

  /// Prefix icon of the snackbar
  final IconData? prefixIcon;

  /// Background color of the snackbar
  final Color? backgroundColor;

  /// Message of the snackbar
  final String message;

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  Widget _content() {
    return Row(children: [_leftIcon(), HorizontalSpacer.semi(), _text()]);
  }

  Widget _leftIcon() {
    return Builder(
      builder: (context) {
        return Icon(
          prefixIcon,
          size: 22,
          color: Theme.of(context).snackBarTheme.contentTextStyle?.color,
        );
      },
    );
  }

  Widget _text() {
    return Builder(
      builder: (context) {
        return Expanded(
          child: Text(
            message,
            maxLines: 4,
            style: Theme.of(context).snackBarTheme.contentTextStyle,
          ),
        );
      },
    );
  }
}
