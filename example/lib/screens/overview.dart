import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components_example/screens/scanner/scanner_screen.dart';
import 'package:basf_flutter_components_example/screens/screens.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({
    required this.currentTheme,
    required this.onThemeChanged,
    super.key,
  });

  final BasfThemeType currentTheme;
  final ValueChanged<BasfThemeType> onThemeChanged;

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: const Text('BASF Components'));
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium20),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: Dimens.paddingMedium20),
        children: _buildSections().joinWithSeparator(
          VerticalSpacer.medium20(),
        ),
      ),
    );
  }

  List<Widget> _buildSections() {
    return [
      _buildSection(
        title: 'Motion & Interaction',
        subtitle: 'Animations, Rive assets and flows that need quick visual checks.',
        children: [
          _buildNavigationButton(
            context,
            text: 'BASF Animations',
            pageBuilder: (_) => const AnimationsOverviewScreen(),
          ),
          _buildNavigationButton(
            context,
            text: 'BASF Rive',
            pageBuilder: (_) => RiveOverviewScreen(
              currentTheme: widget.currentTheme,
              onThemeChanged: widget.onThemeChanged,
            ),
          ),
          _buildScannerButton(context),
        ],
      ),
      _buildSection(
        title: 'Core UI',
        subtitle: 'Reusable controls and feedback primitives.',
        children: [
          _buildNavigationButton(
            context,
            text: 'BASF Buttons',
            pageBuilder: (_) => const ButtonsOverviewScreen(),
          ),
          _buildNavigationButton(
            context,
            text: 'BASF Forms',
            pageBuilder: (_) => const FormsOverviewScreen(),
          ),
          _buildNavigationButton(
            context,
            text: 'BASF Dialogs',
            pageBuilder: (_) => const DialogOverviewScreen(),
          ),
          _buildNavigationButton(
            context,
            text: 'BASF Alerts',
            pageBuilder: (_) => const AlertsOverviewScreen(),
          ),
        ],
      ),
      _buildSection(
        title: 'Design System',
        subtitle: 'Foundations, tokens and theme-driven reference screens.',
        children: [
          _buildNavigationButton(
            context,
            text: 'BASF Colors',
            pageBuilder: (_) => const ColorsOverviewScreen(),
          ),
          _buildNavigationButton(
            context,
            text: 'BASF Fonts',
            pageBuilder: (_) => const FontsScreen(),
          ),
          _buildNavigationButton(
            context,
            text: 'BASF Icons',
            pageBuilder: (_) => const IconsOverviewScreen(),
          ),
          _buildNavigationButton(
            context,
            text: 'BASF Themes',
            pageBuilder: (_) => const ThemesOverviewScreen(),
          ),
        ],
      ),
    ];
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(Dimens.paddingMedium20),
      decoration: BoxDecoration(
        color: BasfColors.backgroundGrey,
        borderRadius: BasfThemes.defaultBorderRadius,
        border: Border.all(
          color: theme.primaryColor.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: BasfColors.copyTextGrey,
            ),
          ),
          ...children,
        ].joinWithSeparator(VerticalSpacer.medium()),
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context, {
    required String text,
    required WidgetBuilder pageBuilder,
  }) {
    return BasfTextButton.contained(
      text: text,
      expanded: true,
      onPressed: () => _push(context, pageBuilder),
    );
  }

  Widget _buildScannerButton(BuildContext context) {
    return BasfTextButton.contained(
      text: 'Scanner',
      expanded: true,
      onPressed: () => _push(
        context,
        (context) => BlocProvider<ScannerCubit>(
          create: (context) => ScannerCubit(id: 'scanner_1'),
          child: const ScannerScreen(),
        ),
      ),
    );
  }

  Future<void> _push(BuildContext context, WidgetBuilder pageBuilder) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: pageBuilder),
    );
  }
}
