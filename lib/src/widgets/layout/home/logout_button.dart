import 'package:basf_flutter_components/src/widgets/modals/bottom_sheet.dart';
import 'package:basf_flutter_components/src/widgets/modals/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

/// Logout button
class LogoutButton extends StatelessWidget {
  /// Logout button
  const LogoutButton({
    required this.onPressed,
    required this.logoutTitle,
    required this.logoutDescription,
    required this.confirmText,
    required this.cancelText,
    this.leadingText,
    super.key,
  });

  /// on logout pressed
  final VoidCallback onPressed;

  /// logout text
  final String logoutTitle;

  /// Confirm logout
  final String logoutDescription;

  /// Confirm button text
  final String confirmText;

  /// Cancel button text
  final String cancelText;

  /// To show on the left
  final String? leadingText;

  @override
  Widget build(BuildContext context) {
    final iconButton = IconButton(
      onPressed: () => showBottomSheet(context),
      iconSize: 20,
      tooltip: logoutTitle,
      icon: const Icon(Icons.lock_open_outlined),
    );

    if (leadingText != null) {
      return GestureDetector(
        onTap: () => showBottomSheet(context),
        child: Row(children: [Text(leadingText!), iconButton]),
      );
    }

    return IconButton(
      onPressed: leadingText == null ? () => showBottomSheet(context) : null,
      iconSize: 20,
      tooltip: logoutTitle,
      icon: const Icon(Icons.lock_open_outlined),
    );
  }

  /// show logout confirmation
  void showBottomSheet(BuildContext context) {
    showCustomModalBottomSheet<void>(
      context: context,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
          Colors.white,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        maxWidth: 500,
      ),
      builder: (context) => ModalBottomSheetWidget(
        title: logoutTitle,
        description: logoutDescription,
        buttonText: confirmText,
        cancelText: cancelText,
        onPressed: onPressed,
      ),
    );
  }
}
