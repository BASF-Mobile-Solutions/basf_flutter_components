import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Default placeholder shown when the scanner is disabled.
class ScannerOfflinePlaceholder extends StatelessWidget {
  const ScannerOfflinePlaceholder({
    required this.isOnOffOverlay,
    required this.onEnableCamera,
    super.key,
  });

  final bool isOnOffOverlay;
  final VoidCallback onEnableCamera;

  @override
  Widget build(BuildContext context) {
    if (!isOnOffOverlay) {
      return _buildLogoOnlyPlaceholder(context);
    }

    return _buildOnOffPlaceholder(context);
  }

  Widget _buildLogoOnlyPlaceholder(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 150, maxHeight: 150),
        child: _buildLogo(context),
      ),
    );
  }

  Widget _buildOnOffPlaceholder(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Center(
      child: InkWell(
        onTap: onEnableCamera,
        child: Container(
          width: 224,
          height: 70,
          decoration: _buildTileDecoration(primaryColor),
          child: Row(
            children: [
              _buildLogoSection(context),
              _buildActionSection(primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return BasfAssets.images.basfLogo.image(
      fit: BoxFit.contain,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget _buildLogoSection(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.paddingLarge,
          vertical: Dimens.paddingMedium,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 96,
            height: 44,
            child: _buildLogo(context),
          ),
        ),
      ),
    );
  }

  Widget _buildActionSection(Color primaryColor) {
    return Container(
      width: 64,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: primaryColor.withValues(alpha: 0.14),
          ),
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.camera_alt_outlined,
          size: 28,
        ),
      ),
    );
  }

  BoxDecoration _buildTileDecoration(Color primaryColor) {
    return BoxDecoration(
      color: primaryColor.withValues(alpha: 0.04),
      border: Border.all(
        color: primaryColor.withValues(alpha: 0.14),
      ),
    );
  }
}
