import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class BasfDropDownInput extends StatefulWidget {
  const BasfDropDownInput({
    Key? key,
    required this.controller,
    required this.values,
    this.labelText,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.end,
  }) : super(key: key);

  final TextEditingController controller;
  final String? labelText;
  final List<String> values;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  @override
  State<BasfDropDownInput> createState() => _BasfDropDownInputState();
}

class _BasfDropDownInputState extends State<BasfDropDownInput> {
  @override
  void initState() {
    widget.controller.text = widget.values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BasfThemes.defaultBorderRadius,
        border: Border.all(
            color: BasfInputThemes
                .mainInputDecorationTheme.enabledBorder!.borderSide.color),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Dimens.paddingMedium),
            child: Text(
              widget.controller.text,
              style: BasfThemes.mainTextTheme.headline6
                  ?.copyWith(color: BasfThemes.primaryColor),
            ),
          ),
          menuButton(),
        ],
      ),
    );
  }

  Widget menuButton() {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: BasfColors.darkBlue.shade100,
      ),
      child: PopupMenuButton<String>(
        icon: const Icon(BasfIcons.arrow_down, size: 16),
        iconSize: 18,
        tooltip: 'menu',
        initialValue: widget.controller.text,
        shape: RoundedRectangleBorder(
          borderRadius: BasfThemes.defaultBorderRadius,
        ),
        onSelected: (String value) {
          setState(() {
            widget.controller.text = value;
          });
        },
        itemBuilder: (context) {
          return List.generate(widget.values.length, (index) {
            return PopupMenuItem<String>(
              value: widget.values[index],
              child: Text(widget.values[index]),
            );
          });
        },
      ),
    );
  }
}
