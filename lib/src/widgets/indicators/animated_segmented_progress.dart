import 'package:flutter/material.dart';

/// Animated Segmented Progress
class AnimatedSegmentedProgress extends StatefulWidget {
  ///
  AnimatedSegmentedProgress({
    required this.totalSegments,
    required this.completedSegments,
    required this.completedColor,
    this.segmentSpacing = 2,
    this.animationDuration = const Duration(milliseconds: 500),
    Color? remainingColor,
    super.key,
  }) : remainingColor = remainingColor ?? Colors.grey.shade300;

  /// List of integers representing the total segments.
  final List<int> totalSegments;

  /// List of integers representing the completed segments.
  final List<int> completedSegments;

  /// Spacing between segments.
  final double segmentSpacing;

  /// Color of the completed segments.
  final Color completedColor;

  /// Color of the remaining segments.
  final Color? remainingColor;

  /// Duration of the animation.
  final Duration animationDuration;

  @override
  State<AnimatedSegmentedProgress> createState()
  => _AnimatedSegmentedProgressState();
}

class _AnimatedSegmentedProgressState extends State<AnimatedSegmentedProgress> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: widget.segmentSpacing,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.totalSegments.map((segment) {
        final isCompleted = widget.completedSegments.contains(segment);
        return Expanded(
          child: AnimatedContainer(
            duration: widget.animationDuration,
            curve: Curves.easeInOut,
            height: 5,
            decoration: BoxDecoration(
              color: isCompleted
                  ? widget.completedColor
                  : widget.remainingColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}
