import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template dropdown_input}
/// A BASF-styled dropdown input
/// {@endtemplate}
class BasfDropDownInput extends StatefulWidget {
  /// {@macro dropdown_input}
  const BasfDropDownInput({
    super.key,
    required this.controller,
    required this.values,
    this.labelText,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.isExpanded = false,
    this.isLoading = false,
  });

  /// Controller
  final TextEditingController controller;

  /// Label for the dropdown
  final String? labelText;

  /// List of values
  final List<String> values;

  /// Cross alignment
  final CrossAxisAlignment crossAxisAlignment;

  /// Main alignment
  final MainAxisAlignment mainAxisAlignment;

  /// Wheter or not the dropdown should expand itself
  final bool isExpanded;

  /// Wheter or not the dropdown is loading
  final bool isLoading;

  @override
  State<BasfDropDownInput> createState() => _BasfDropDownInputState();
}

class _BasfDropDownInputState extends State<BasfDropDownInput> {
  @override
  void initState() {
    if (widget.values.contains(widget.controller.text.trim())) {
      widget.controller.text =
          widget.values.firstWhere((e) => e == widget.controller.text.trim());
    } else {
      widget.controller.text = widget.values.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BasfThemes.defaultBorderRadius,
        border: Border.all(
          color: theme.inputDecorationTheme
              .enabledBorder!
              .borderSide
              .color,
        ),
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: !widget.isLoading ? 1 : 0,
            child: Row(
              crossAxisAlignment: widget.crossAxisAlignment,
              mainAxisAlignment: widget.mainAxisAlignment,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: Dimens.paddingMedium),
                  child: Text(
                    widget.controller.text,
                    style: BasfThemes.mainTextTheme.headline6
                        ?.copyWith(color: theme.primaryColor),
                  ),
                ),
                if (widget.isExpanded) const Spacer(),
                _menuButton(),
              ],
            ),
          ),
          if (widget.isLoading)
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Center(child: _loader(theme)),
            ),
        ],
      ),
    );
  }

  Widget _loader(ThemeData theme) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.centerLeft,
      child: CircularProgressIndicator(
        color: theme.primaryColor,
        strokeWidth: 3,
      ),
    );
  }

  Widget _menuButton() {
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
