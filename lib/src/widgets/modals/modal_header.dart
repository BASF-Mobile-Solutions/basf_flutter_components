import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Modal header
class ModalHeader extends StatelessWidget {
  /// Modal header
  const ModalHeader({
    required this.title,
    this.icon,
    this.actions,
    this.showCloseButton = true,
    super.key,
  });

  ///
  final String title;
  ///
  final bool showCloseButton;
  ///
  final Widget? icon;
  ///
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (icon != null) Expanded(child: titleWithIcon(context))
        else Expanded(child: sectionTitle(context)),
        if (actions != null) closeButtonWithActions(context)
        else if (showCloseButton) closeButton(context),
      ],
    );
  }

  /// Title
  Widget sectionTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  /// Title with icon
  Widget titleWithIcon(BuildContext context) {
    return Row(
      children: [
        Flexible(child: sectionTitle(context)),
        HorizontalSpacer.xSmall(),
        icon!,
      ],
    );
  }

  /// Close button with actions
  Widget closeButtonWithActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...actions!,
        if (showCloseButton) closeButton(context),
      ],
    );
  }

  /// Close button
  Widget closeButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(BasfIcons.close),
      iconSize: 16,
    );
  }
}
