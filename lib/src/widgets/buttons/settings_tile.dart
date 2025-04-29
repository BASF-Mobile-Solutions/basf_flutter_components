import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Tile with icon and arrow
class SettingsTile extends StatelessWidget {
  /// Tile with icon and arrow
  const SettingsTile({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 30),
    super.key,
  });

  ///
  final String title;

  ///
  final IconData icon;

  ///
  final VoidCallback onPressed;

  ///
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        iconColor: BasfColors.darkGrey,
        padding: padding,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 19),
              HorizontalSpacer.xLarge(),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: BasfColors.darkGrey),
              ),
            ],
          ),
          Icon(
            BasfIcons.arrow_forward,
            size: 14,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
