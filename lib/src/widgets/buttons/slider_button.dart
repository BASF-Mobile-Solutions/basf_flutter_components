import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template basf_slider_button}
/// A BASF-styled slider button
/// {@endtemplate}
class SliderButton extends StatefulWidget {
  /// {@macro basf_slider_button}
  const SliderButton({
    required this.onConfirmation,
    super.key,
    this.height = 70,
    this.width = 300,
    this.backgroundColor = Colors.white,
    this.backgroundColorEnd,
    this.foregroundColor,
    this.iconColor = Colors.white,
    this.shadow,
    this.sliderButtonContent,
    this.text,
    this.textStyle,
    this.foregroundShape,
    this.backgroundShape,
    this.stickToEnd = false,
    this.animationCurve,
  }) : assert(
         height >= 25 && width >= 250,
         '''Height must be be greater or equal to 25, and width greater or equal to 250''',
       );

  /// Height of the slider
  final double height;

  /// Width of the slider
  final double width;

  /// Background color of the slider
  final Color backgroundColor;

  /// Background color of the slider on the end
  final Color? backgroundColorEnd;

  /// Background color of the slider on the foreground
  final Color? foregroundColor;

  /// Icon color of the icon in the slider
  final Color iconColor;

  /// An optional slider cuntent as a widget
  final Widget? sliderButtonContent;

  /// Slider shadows
  final BoxShadow? shadow;

  /// Slider text
  final String? text;

  /// Slider text style
  final TextStyle? textStyle;

  /// Action to be performed when the slider is fully slided
  final VoidCallback onConfirmation;

  /// Shape of the slider
  final BorderRadius? foregroundShape;

  /// Shape of the slider's background
  final BorderRadius? backgroundShape;

  /// Wheter or not the slider should stick to the end of the shape on drag
  final bool stickToEnd;

  /// Curve of the slider animation
  final Curve? animationCurve;

  @override
  State<StatefulWidget> createState() {
    return _SliderButtonState();
  }
}

class _SliderButtonState extends State<SliderButton> {
  double _position = 0;
  int _duration = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: _duration),
      curve: Curves.ease,
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: widget.backgroundShape ?? BasfThemes.defaultBorderRadius,
        color:
            widget.backgroundColorEnd != null
                ? _calculateBackground()
                : widget.backgroundColor,
        boxShadow: [
          widget.shadow ??
              const BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
        ],
      ),
      child: Stack(children: [_text(), _backgroundOverlay(), _sliderButton()]),
    );
  }

  Widget _text() {
    return Center(
      child: Text(
        widget.text ?? '',
        style:
            widget.textStyle ??
            const TextStyle(color: Colors.black26, fontWeight: FontWeight.bold),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _backgroundOverlay() {
    return Positioned(
      left: widget.height / 2,
      child: AnimatedContainer(
        height: widget.height - 10,
        width: _getPosition(),
        duration: Duration(milliseconds: _duration),
        curve: Curves.ease,
        decoration: BoxDecoration(
          borderRadius:
              widget.backgroundShape ??
              BorderRadius.all(Radius.circular(widget.height)),
          color:
              widget.backgroundColorEnd != null
                  ? _calculateBackground()
                  : widget.backgroundColor,
        ),
      ),
    );
  }

  Widget _sliderButton() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: _duration),
      curve: widget.animationCurve ?? Curves.easeOutCubic,
      left: _getPosition(),
      top: 0,
      child: GestureDetector(
        onPanUpdate: _updatePosition,
        onPanEnd: _sliderReleased,
        child: Container(
          height: widget.height - 10,
          width: widget.height - 10,
          decoration: BoxDecoration(
            borderRadius:
                widget.foregroundShape ?? BasfThemes.defaultBorderRadius,
            color: widget.foregroundColor ?? Theme.of(context).primaryColor,
          ),
          child:
              widget.sliderButtonContent ??
              Icon(Icons.navigate_next, color: widget.iconColor),
        ),
      ),
    );
  }

  double _getPosition() {
    if (_position < 0) {
      return 0;
    } else if (_position > widget.width - widget.height) {
      return widget.width - widget.height;
    } else {
      return _position;
    }
  }

  void _updatePosition(dynamic details) {
    if (details is DragEndDetails) {
      setState(() {
        _duration = 600;
        if (widget.stickToEnd && _position > widget.width - widget.height) {
          _position = widget.width - widget.height;
        } else {
          _position = 0;
        }
      });
    } else if (details is DragUpdateDetails) {
      setState(() {
        _duration = 0;
        _position = details.localPosition.dx - (widget.height / 2);
      });
    }
  }

  void _sliderReleased(DragEndDetails details) {
    if (_position > widget.width - widget.height) {
      widget.onConfirmation();
    }
    _updatePosition(details);
  }

  Color _calculateBackground() {
    // Calculate the percentage of the slider's position.
    final maxPosition = widget.width - widget.height;
    final percent = (_position / maxPosition).clamp(0.0, 1.0);

    // Safely handle backgroundColorEnd and extract RGB values.
    final red = widget.backgroundColorEnd?.r.round() ?? 0;
    final green = widget.backgroundColorEnd?.g.round() ?? 0;
    final blue = widget.backgroundColorEnd?.b.round() ?? 0;

    // Blend the colors based on the calculated percentage.
    return Color.alphaBlend(
      Color.fromRGBO(red, green, blue, percent),
      widget.backgroundColor,
    );
  }
}
