import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Reports the visible fraction of [child] inside the current viewport.
class ViewportVisibilityListener extends StatefulWidget {
  const ViewportVisibilityListener({
    required this.child,
    required this.onVisibilityChanged,
    super.key,
    this.visibleThreshold = 0.01,
    this.reportDelta = 0.05,
  });

  final Widget child;
  final ValueChanged<double> onVisibilityChanged;
  final double visibleThreshold;
  final double reportDelta;

  @override
  State<ViewportVisibilityListener> createState() => _ViewportVisibilityListenerState();
}

class _ViewportVisibilityListenerState extends State<ViewportVisibilityListener>
    with WidgetsBindingObserver {
  static const _defaultBurstFrames = 24;
  static const _scrollBurstFrames = 2;

  double? _lastVisibleFraction;
  bool _measurementScheduled = false;
  bool _isInForeground = true;
  int _remainingBurstFrames = 0;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scheduleMeasurementBurst();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attachScrollPosition();
    _scheduleMeasurementBurst();
  }

  @override
  void didUpdateWidget(covariant ViewportVisibilityListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleMeasurementBurst();
  }

  @override
  void didChangeMetrics() {
    _scheduleMeasurementBurst();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isInForeground = switch (state) {
      AppLifecycleState.resumed => true,
      AppLifecycleState.inactive => true,
      AppLifecycleState.hidden || AppLifecycleState.paused || AppLifecycleState.detached => false,
    };

    if (_isInForeground == isInForeground) return;

    _isInForeground = isInForeground;
    if (!_isInForeground) {
      _notifyVisibilityChanged(0);
      return;
    }

    _scheduleMeasurementBurst();
  }

  @override
  void dispose() {
    _detachScrollPosition();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _scheduleMeasurement() {
    if (_measurementScheduled || !_isInForeground) return;

    _measurementScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measurementScheduled = false;
      if (!mounted || !_isInForeground) return;

      _notifyVisibilityChanged(_computeVisibleFraction());

      if (_remainingBurstFrames > 0) {
        _remainingBurstFrames--;
        _scheduleMeasurement();
      }
    });
  }

  void _scheduleMeasurementBurst([int frames = _defaultBurstFrames]) {
    if (_remainingBurstFrames < frames) {
      _remainingBurstFrames = frames;
    }
    _scheduleMeasurement();
  }

  void _attachScrollPosition() {
    final nextScrollPosition = Scrollable.maybeOf(context)?.position;
    if (identical(_scrollPosition, nextScrollPosition)) return;

    _detachScrollPosition();
    _scrollPosition = nextScrollPosition;
    _scrollPosition?.addListener(_handleScrollPositionChanged);
    _scrollPosition?.isScrollingNotifier.addListener(_handleScrollPositionChanged);
  }

  void _detachScrollPosition() {
    _scrollPosition?.removeListener(_handleScrollPositionChanged);
    _scrollPosition?.isScrollingNotifier.removeListener(_handleScrollPositionChanged);
    _scrollPosition = null;
  }

  void _handleScrollPositionChanged() {
    _scheduleMeasurementBurst(_scrollBurstFrames);
  }

  void _notifyVisibilityChanged(double visibleFraction) {
    final previousFraction = _lastVisibleFraction;
    final wasVisible = (previousFraction ?? 0) > widget.visibleThreshold;
    final isVisible = visibleFraction > widget.visibleThreshold;

    _lastVisibleFraction = visibleFraction;

    final shouldReport =
        previousFraction == null ||
        wasVisible != isVisible ||
        (visibleFraction - previousFraction).abs() >= widget.reportDelta;

    if (shouldReport) {
      widget.onVisibilityChanged(visibleFraction);
    }
  }

  double _computeVisibleFraction() {
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.attached) return 0;

    final size = renderObject.size;
    if (size.isEmpty) return 0;

    final topLeft = renderObject.localToGlobal(Offset.zero);
    final widgetRect = topLeft & size;
    final mediaSize = MediaQuery.maybeSizeOf(context);
    final viewportSize =
        mediaSize ?? View.of(context).physicalSize / View.of(context).devicePixelRatio;
    if (viewportSize.isEmpty) return 0;

    final viewportRect = Offset.zero & viewportSize;
    final visibleRect = widgetRect.intersect(viewportRect);
    if (visibleRect.isEmpty) return 0;

    final widgetArea = widgetRect.width * widgetRect.height;
    if (widgetArea <= 0) return 0;

    final visibleArea = visibleRect.width * visibleRect.height;
    return (visibleArea / widgetArea).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
