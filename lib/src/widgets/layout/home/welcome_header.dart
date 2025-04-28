import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Welcome header
class WelcomeHeader extends StatelessWidget {
  /// Welcome header
  const WelcomeHeader({
    required this.welcomeText,
    required this.name,
    super.key,
  });

  ///
  final String welcomeText;
  ///
  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          welcomeText,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.primaryColor,
          ),
        ),
        if (name.trim().isNotEmpty) Text(
          name.toTitleCase(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
