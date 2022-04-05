import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

import '../../data/models/option.dart';

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
        radioItem(),
        VerticalSpacer.semi(),
        subTitle(),
      ],
    );
  }

  Widget radioItem() {
    return Builder(builder: (context) {
      return Container(
        margin: margin,
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 4.0,
              color: option.isSelected
                  ? selectedColor ?? Theme.of(context).colorScheme.primary
                  : unselectedColor ?? Colors.grey,
            ),
          ),
        ),
        child: content(),
      );
    });
  }

  Widget content() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        option.text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? BasfColors.boxGrey,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6), topRight: Radius.circular(6)),
      ),
    );
  }

  Widget subTitle() {
    return Text(
      option.subtitle ?? '',
      overflow: TextOverflow.ellipsis,
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
      children: optionsList(),
    );
  }

  List<Widget> optionsList() =>
      List.generate(widget.options.length, (index) => radioOption(index));

  Widget radioOption(int index) {
    return Expanded(
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
        onTap: () => selectRadio(index),
      ),
    );
  }

  void selectRadio(int index) {
    for (BasfOption option in widget.options) {
      option.isSelected = false;
    }
    widget.options[index].isSelected = true;
    widget.options[index].onChanged();

    setState(() {});
  }
}
