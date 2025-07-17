import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/indicators/app_circular_progress.dart';
import 'package:flutter/material.dart';

/// A custom button widget that can display a loading indicator.
///
/// This widget can be used as a regular button or an outlined button.
/// When `isLoading` is true, the button displays a circular progress indicator
/// instead of the text and becomes disabled.
class ButtonWithLoader extends StatelessWidget {
  /// Creates a button with a loading indicator.
  const ButtonWithLoader({
    super.key,
    this.isLoading = false,
    this.text = '',
    this.onPressed,
    this.color = Colors.white,
    this.leadingIcon,
    this.isOutlined = false,
  });

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  /// The text to display on the button.
  final String text;

  /// Whether the button is currently in a loading state.
  final bool isLoading;

  /// The color of the button.
  final Color color;

  /// An optional icon to display before the text.
  final IconData? leadingIcon;

  /// Whether the button should be an outlined button.
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return BasfOutlinedButton(
        expanded: true,
        onPressed: isLoading ? null : onPressed,
        child: isLoading ? loader() : title(),
      );
    } else {
      return BasfTextButton.contained(
        expanded: true,
        onPressed: isLoading ? null : onPressed,
        child: isLoading ? loader() : title(),
      );
    }
  }

  /// title
  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (leadingIcon != null) Icon(leadingIcon),
        Text(text),
      ].joinWithSeparator(HorizontalSpacer.normal()),
    );
  }

  /// loader
  Widget loader() {
    return const Center(
      child: AppCircularProgress.button(size: 19),
    );
  }
}
