import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class RiveOverviewScreen extends StatefulWidget {
  const RiveOverviewScreen({
    required this.currentTheme,
    required this.onThemeChanged,
    super.key,
  });

  final BasfThemeType currentTheme;
  final ValueChanged<BasfThemeType> onThemeChanged;

  @override
  State<RiveOverviewScreen> createState() => _RiveOverviewScreenState();
}

class _RiveOverviewScreenState extends State<RiveOverviewScreen> {
  bool _gearUsesThemeColor = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: const Text('BASF Rive'));
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(Dimens.paddingMedium20),
      children: [
        _buildThemeSection(),
        _buildStatusIconsSection(),
        _buildGearSection(),
        _buildSearchLoopSection(),
        _buildLogisticsBoxSection(),
        _buildEmojiSection(),
      ].joinWithSeparator(VerticalSpacer.medium20()),
    );
  }

  Widget _buildThemeSection() {
    return _buildSection(
      title: 'Theme',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          for (final theme in BasfThemeType.values)
            _buildThemeButton(theme),
        ],
      ),
    );
  }

  Widget _buildThemeButton(BasfThemeType theme) {
    final isSelected = theme == widget.currentTheme;

    return TextButton(
      onPressed: () {
        widget.onThemeChanged(theme);
        setState(() {});
      },
      style: TextButton.styleFrom(
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        side: isSelected
            ? const BorderSide(color: Colors.black, width: 2)
            : null,
      ),
      child: Text(theme.name),
    );
  }

  Widget _buildStatusIconsSection() {
    return _buildSection(
      title: 'Status Icons',
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SuccessAnimatedIcon(),
          ErrorAnimatedIcon(),
          WarningAnimatedIcon(),
        ],
      ),
    );
  }

  Widget _buildGearSection() {
    return _buildSection(
      title: 'Gear Icon',
      subtitle: 'Tap the gear to verify interaction and current theme color.',
      child: Center(
        child: AnimatedGearIcon(
          size: 72,
          onTap: () => setState(
            () => _gearUsesThemeColor = !_gearUsesThemeColor,
          ),
          color: _gearUsesThemeColor ? null : BasfColors.copyTextGrey,
        ),
      ),
    );
  }

  Widget _buildSearchLoopSection() {
    return _buildSection(
      title: 'Search Loop',
      subtitle: 'Tap or double tap the animation to test state machine triggers.',
      child: const Center(
        child: SearchLoopAnimation(),
      ),
    );
  }

  Widget _buildLogisticsBoxSection() {
    return _buildSection(
      title: 'Logistics Box',
      child: const Center(
        child: LogisticsBoxAnimation(),
      ),
    );
  }

  Widget _buildEmojiSection() {
    return _buildSection(
      title: 'Emoji Artboards',
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: RiveEmoji.values.map(_buildEmojiCard).toList(),
        ),
      ),
    );
  }

  Widget _buildEmojiCard(RiveEmoji emoji) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(Dimens.paddingMedium),
      decoration: BoxDecoration(
        color: BasfColors.backgroundGrey,
        borderRadius: BasfThemes.defaultBorderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: BasfRiveAnimationAsset(
              asset: BasfAssets.rive.emoji,
              artboard: emoji.artBoard,
              animationName: 'Animation 1',
            ),
          ),
          VerticalSpacer.small(),
          Text(
            emoji.name,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    String? subtitle,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        if (subtitle != null)
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: BasfColors.copyTextGrey,
            ),
          ),
        child,
      ].joinWithSeparator(VerticalSpacer.medium()),
    );
  }
}
