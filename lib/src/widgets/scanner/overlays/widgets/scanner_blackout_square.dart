import 'package:basf_flutter_components/src/widgets/scanner/overlays/widgets/camera_edge.dart';
import 'package:material_ui/material_ui.dart';

/// Black transparent overlay for scanner
class ScannerBlackoutSquare extends StatelessWidget {
  ///
  const ScannerBlackoutSquare({super.key, this.borderWidth = 50});

  /// Width of dark overlay
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth,
          color: Colors.black.withValues(alpha: 0.6),
        ),
      ),
      child: const CameraEdges(),
    );
  }
}
