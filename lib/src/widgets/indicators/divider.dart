import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// App Divider enum type
enum AppDividerType {
  /// thin line
  thin,

  /// thick line
  thick,

  /// double line
  double,

  /// with arrow down
  withArrowDown,
}

/// Diving line
class AppDivider extends StatelessWidget {
  /// Thin
  const AppDivider.thin({super.key}) : _type = AppDividerType.thin;

  /// Thick
  const AppDivider.thick({super.key}) : _type = AppDividerType.thick;

  /// Double
  const AppDivider.double({super.key}) : _type = AppDividerType.double;

  /// Arrow down
  const AppDivider.withArrowDown({super.key})
    : _type = AppDividerType.withArrowDown;

  final AppDividerType _type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return switch (_type) {
      AppDividerType.thin => Divider(color: theme.primaryColor, thickness: 0.2),
      AppDividerType.thick => getThick(theme),
      AppDividerType.double => Column(
        children: [
          Divider(color: theme.primaryColor, thickness: 0.2, height: 1),
          Divider(color: theme.primaryColor, thickness: 0.2, height: 1),
        ].joinWithSeparator(VerticalSpacer.xSmall()),
      ),
      AppDividerType.withArrowDown => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: getThick(theme)),
          const Icon(Icons.keyboard_arrow_down, size: 30),
          Flexible(child: getThick(theme)),
        ].joinWithSeparator(HorizontalSpacer.normal()),
      ),
    };
  }

  /// thick reusable widget
  Widget getThick(ThemeData theme) {
    return Divider(color: theme.primaryColor, thickness: 1);
  }
}
