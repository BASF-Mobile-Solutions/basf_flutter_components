import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class BasfOption {
  String text;
  bool isSelected;
  String? subtitle;
  VoidCallback onChanged;

  BasfOption({
    required this.text,
    this.isSelected = false,
    this.subtitle,
    required this.onChanged,
  });
}

class _BasfRadioItem extends StatelessWidget {
  final BasfOption option;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final EdgeInsets margin;

  const _BasfRadioItem({
    Key? key,
    required this.option,
    required this.selectedColor,
    required this.unselectedColor,
    required this.backgroundColor,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          child: Text(
            option.text,
            textAlign: TextAlign.center,
          ),
          padding: const EdgeInsets.all(8),
          margin: margin,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 4.0,
                color: option.isSelected
                    ? selectedColor ?? BasfColors.darkBlue
                    : unselectedColor ?? Colors.grey,
              ),
            ),
          ),
        ),
        VerticalSpacer.semi(),
        Text(
          option.subtitle ?? '',
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

/// [BasfRadio]
/// required a list of [BasfOption] wich generates a list of [_BasfRadioItem]
///
/// Example:
/// ```dart
///  BasfCheckbox(
///    text: 'Default value',
///    value: _value,
///    onChanged: (value) {
///      _value = !value;
///      setState(() {});
///    },
///  ),
/// ```

class BasfRadio extends StatefulWidget {
  final List<BasfOption> options;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;

  const BasfRadio({
    Key? key,
    required this.options,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<BasfRadio> createState() => _BasfRadioState();
}

class _BasfRadioState extends State<BasfRadio> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        widget.options.length,
        (index) => Expanded(
          child: GestureDetector(
            child: _BasfRadioItem(
                option: widget.options[index],
                selectedColor: widget.selectedColor,
                unselectedColor: widget.unselectedColor,
                backgroundColor: widget.backgroundColor,
                margin: index == 0
                    ? const EdgeInsets.only(right: 5)
                    : index == widget.options.length - 1
                        ? const EdgeInsets.only(left: 5)
                        : const EdgeInsets.symmetric(horizontal: 5)),
            onTap: () {
              for (var option in widget.options) {
                option.isSelected = false;
              }
              widget.options[index].isSelected = true;
              widget.options[index].onChanged();

              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
