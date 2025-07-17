import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Auto adjusts space
class AdaptiveSpacer extends StatefulWidget {
  /// Creates an [AdaptiveSpacer].
  const AdaptiveSpacer({
    required this.bottomWidgetKey,
    required this.listviewContentKey,
    required this.listViewHeight,
    required this.bottomPaddingCorrection,
    this.child,
    super.key,
  });

  /// The global key of the widget at the bottom of the screen.
  final GlobalKey bottomWidgetKey;

  /// The global key of the content within the ListView.
  final GlobalKey listviewContentKey;

  /// The height of the ListView.
  final double listViewHeight;

  /// A correction factor for the bottom padding.
  final double bottomPaddingCorrection;

  /// An optional child widget to display within the spacer.
  final Widget? child;

  @override
  State<AdaptiveSpacer> createState() => _AdaptiveSpacerState();
}

class _AdaptiveSpacerState extends State<AdaptiveSpacer> {
  double height = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        height = getSpacerHeight();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: widget.child,
    );
  }

  double getSpacerHeight() {
    final listHeight = widget.listviewContentKey.currentContext?.size?.height;
    final bottomBoxHeight = widget.bottomWidgetKey.currentContext?.size?.height;

    if (bottomBoxHeight != null && listHeight != null) {
      final difference =
          widget.listViewHeight - listHeight - widget.bottomPaddingCorrection;

      return difference > 0 ? difference : 0;
    } else {
      return 0;
    }
  }
}
