import 'package:basf_flutter_components/utils/gen/assets.gen.dart';
import 'package:flutter/material.dart';

/// Temporary placeholder shown while the camera is starting.
class ScannerStartupPlaceholder extends StatelessWidget {
  const ScannerStartupPlaceholder({
    required this.showLoader,
    required this.loaderFadeDuration,
    super.key,
  });

  final bool showLoader;
  final Duration loaderFadeDuration;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildLogo(),
          _buildLoader(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 120, maxHeight: 120),
        child: BasfAssets.images.basfLogo.image(
          fit: BoxFit.contain,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Align(
      alignment: const Alignment(0, 0.72),
      child: AnimatedOpacity(
        opacity: showLoader ? 1 : 0,
        duration: loaderFadeDuration,
        curve: Curves.easeOut,
        child: _buildLoaderIndicator(),
      ),
    );
  }

  Widget _buildLoaderIndicator() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2.5,
      ),
    );
  }
}
