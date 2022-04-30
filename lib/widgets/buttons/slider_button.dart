import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class SliderButton extends StatefulWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final Color? backgroundColorEnd;
  final Color? foregroundColor;
  final Color iconColor;
  final Widget? sliderButtonContent;
  final BoxShadow? shadow;
  final String? text;
  final TextStyle? textStyle;
  final VoidCallback onConfirmation;
  final BorderRadius? foregroundShape;
  final BorderRadius? backgroundShape;
  final bool stickToEnd;
  final Curve? animationCurve;

  const SliderButton({
    Key? key,
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
    required this.onConfirmation,
    this.foregroundShape,
    this.backgroundShape,
    this.stickToEnd = false,
    this.animationCurve,
  })  : assert(height >= 25 && width >= 250),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SliderButtonState();
  }
}

class SliderButtonState extends State<SliderButton> {
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
        color: widget.backgroundColorEnd != null
            ? calculateBackground()
            : widget.backgroundColor,
        boxShadow: [
          widget.shadow ??
              const BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
        ],
      ),
      child: Stack(
        children: [
          _text(),
          _backgroundOverlay(),
          _sliderButton(),
        ],
      ),
    );
  }

  Widget _text() {
    return Center(
      child: Text(
        widget.text ?? '',
        style: widget.textStyle ??
            const TextStyle(
              color: Colors.black26,
              fontWeight: FontWeight.bold,
            ),
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
        width: getPosition(),
        duration: Duration(milliseconds: _duration),
        curve: Curves.ease,
        decoration: BoxDecoration(
          borderRadius: widget.backgroundShape ??
              BorderRadius.all(Radius.circular(widget.height)),
          color: widget.backgroundColorEnd != null
              ? calculateBackground()
              : widget.backgroundColor,
        ),
      ),
    );
  }

  Widget _sliderButton() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: _duration),
      curve: widget.animationCurve ?? Curves.easeOutCubic,
      left: getPosition(),
      top: 0,
      child: GestureDetector(
        onPanUpdate: (details) => updatePosition(details),
        onPanEnd: (details) => sliderReleased(details),
        child: Container(
          height: widget.height - 10,
          width: widget.height - 10,
          decoration: BoxDecoration(
            borderRadius: widget.foregroundShape ?? BasfThemes.defaultBorderRadius,
            color: widget.foregroundColor ?? Theme.of(context).primaryColor,
          ),
          child: widget.sliderButtonContent ??
              Icon(
                Icons.arrow_forward_ios,
                color: widget.iconColor,
              ),
        ),
      ),
    );
  }

  double getPosition() {
    if (_position < 0) {
      return 0;
    } else if (_position > widget.width - widget.height) {
      return widget.width - widget.height;
    } else {
      return _position;
    }
  }

  void updatePosition(details) {
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

  void sliderReleased(details) {
    if (_position > widget.width - widget.height) {
      widget.onConfirmation();
    }
    updatePosition(details);
  }

  Color calculateBackground() {
    if (widget.backgroundColorEnd != null) {
      double percent;

      // calculates the percentage of the position of the slider
      if (_position > widget.width - widget.height) {
        percent = 1.0;
      } else if (_position / (widget.width - widget.height) > 0) {
        percent = _position / (widget.width - widget.height);
      } else {
        percent = 0.0;
      }

      int red = widget.backgroundColorEnd!.red;
      int green = widget.backgroundColorEnd!.green;
      int blue = widget.backgroundColorEnd!.blue;

      return Color.alphaBlend(
        Color.fromRGBO(red, green, blue, percent),
        widget.backgroundColor,
      );
    } else {
      return widget.backgroundColor;
    }
  }
}
