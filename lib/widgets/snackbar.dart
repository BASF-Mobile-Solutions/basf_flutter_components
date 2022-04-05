import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

extension SnackbarActions on AppSnackBar {
  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: backgroundColor, content: this),
    );
  }
}

class AppSnackBar extends StatelessWidget {
  final IconData? prefixIcon;
  final Color? backgroundColor;
  final String message;

  const AppSnackBar({
    Key? key,
    required this.message,
    this.prefixIcon,
    this.backgroundColor,
  }) : super(key: key);

  factory AppSnackBar.error({required String message}) {
    return AppSnackBar(
      message: message,
      prefixIcon: Icons.error,
      backgroundColor: BasfColors.red,
    );
  }

  factory AppSnackBar.info({required String message}) => AppSnackBar(
        message: message,
        prefixIcon: Icons.info,
      );

  @override
  Widget build(BuildContext context) {
    return content();
  }

  Widget content() {
    return Row(
      children: [
        leftIcon(),
        HorizontalSpacer.semi(),
        text(),
      ],
    );
  }

  Widget leftIcon() {
    return Builder(
      builder: (context) {
        return Icon(prefixIcon,
            size: 22,
            color: Theme.of(context).snackBarTheme.contentTextStyle?.color);
      },
    );
  }

  Widget text() {
    return Builder(builder: (context) {
      return Expanded(
        child: Text(message,
            maxLines: 4,
            style: Theme.of(context).snackBarTheme.contentTextStyle),
      );
    });
  }
}
