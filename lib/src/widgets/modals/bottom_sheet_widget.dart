import 'package:basf_flutter_components/src/theme/colors.dart' show BasfColors;
import 'package:basf_flutter_components/src/widgets/buttons/outlined_button.dart';
import 'package:basf_flutter_components/src/widgets/buttons/text_button.dart';
import 'package:basf_flutter_components/src/widgets/modals/modal_body.dart';
import 'package:basf_flutter_components/src/widgets/spacers.dart';
import 'package:flutter/material.dart';

/// Bottom sheet widget
class ModalBottomSheetWidget extends StatelessWidget {
  /// Bottom sheet widget
  const ModalBottomSheetWidget({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    required this.cancelText,
    this.buttonColor = BasfColors.red,
    this.withCancelButton = false,
    super.key,
  });

  ///
  final String title;

  ///
  final String description;

  ///
  final String buttonText;

  ///
  final Color buttonColor;

  ///
  final bool withCancelButton;

  ///
  final VoidCallback onPressed;

  ///
  final String cancelText;

  @override
  Widget build(BuildContext context) {
    return ModalBody(
      bodyWidgets: [
        VerticalSpacer.medium(),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        VerticalSpacer.medium(),
        Text(
          description,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        VerticalSpacer.large(),
        BasfOutlinedButton(
          style: withCancelButton ? cancelRedStyle : null,
          expanded: true,
          onPressed: () => Navigator.of(context).pop(),
          text: cancelText,
        ),
        VerticalSpacer.mediumSmall(),
        BasfTextButton.contained(
          style: withCancelButton
              ? null
              : TextButton.styleFrom(backgroundColor: buttonColor),
          expanded: true,
          onPressed: onPressed,
          text: buttonText,
        ),
      ],
    );
  }

  /// Cancel button style
  ButtonStyle get cancelRedStyle {
    return OutlinedButton.styleFrom(
      side: const BorderSide(color: BasfColors.red),
      foregroundColor: BasfColors.red,
    );
  }
}
