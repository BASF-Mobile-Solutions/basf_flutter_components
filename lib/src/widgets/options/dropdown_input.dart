import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template dropdown_input}
/// A BASF-styled dropdown input
/// {@endtemplate}
class BasfDropDownInput extends StatefulWidget {
  /// {@macro dropdown_input}
  const BasfDropDownInput({
    required this.controller,
    required this.values,
    super.key,
    this.labelText,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.isExpanded = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.isMandatory = false,
    this.onChanged,
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

  /// Whether or not the dropdown should expand itself
  final bool isExpanded;

  /// Whether or not the dropdown is loading
  final bool isLoading;

  /// Blocks dropdown and colors in grey
  final bool isDisabled;

  /// Whether or not the border is displayed in current theme's error color
  /// (e.g. red) if the field is empty
  final bool isMandatory;

  /// Callback for when the selected value changes
  final ValueChanged<String>? onChanged;

  @override
  State<BasfDropDownInput> createState() => _BasfDropDownInputState();
}

class _BasfDropDownInputState extends State<BasfDropDownInput> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    _initializeSelectedValue();
  }

  void _initializeSelectedValue() {
    if (widget.values.contains(widget.controller.text.trim())) {
      selectedValue =
          widget.values.firstWhere((e) => e == widget.controller.text.trim());
    } else {
      selectedValue = widget.values.isNotEmpty ? widget.values.first : '';
    }
    widget.controller.text = selectedValue;
  }

  void updateValue(String value) {
    setState(() {
      selectedValue = value;
      widget.controller.text = value;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          VerticalSpacer.semi(),
        ],
        popupMenuButton(context),
      ],
    );
  }

  Widget popupMenuButton(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.isLoading || isDisabled,
      child: PopupMenuButton<String>(
        initialValue: selectedValue,
        shape: RoundedRectangleBorder(
          borderRadius: BasfThemes.defaultBorderRadius,
        ),
        onSelected: updateValue,
        itemBuilder: (context) {
          return widget.values
              .map(
                (value) => PopupMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
              .toList();
        },
        child: layout(),
      ),
    );
  }

  Widget layout() {
    final theme = Theme.of(context);
    final disabledTheme = BasfInputThemes.disabledInputTheme(theme);

    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BasfThemes.defaultBorderRadius,
        color: isDisabled ? disabledTheme.inputDecorationTheme.fillColor : null,
        border: Border.all(
          color: isDisabled
              ? disabledTheme
                      .inputDecorationTheme.disabledBorder?.borderSide.color ??
                  theme.disabledColor
              : widget.isMandatory && selectedValue.isEmpty
                  ? theme.colorScheme.error
                  : theme.inputDecorationTheme.enabledBorder?.borderSide
                          .color ??
                      theme.primaryColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        mainAxisAlignment: widget.mainAxisAlignment,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: Dimens.paddingMedium),
              child: Text(
                selectedValue,
                style: BasfThemes.mainTextTheme.titleLarge
                    ?.copyWith(color: theme.primaryColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (!widget.isLoading) menuButton(),
          if (widget.isLoading) loader(theme),
        ],
      ),
    );
  }

  Widget loader(ThemeData theme) {
    return Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.only(
        left: 18,
        right: 15,
      ),
      child: CircularProgressIndicator(
        color: theme.primaryColor,
        strokeWidth: 3,
      ),
    );
  }

  Widget menuButton() {
    final theme = Theme.of(context);

    return Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.only(
        left: 18,
        right: 15,
      ),
      child: Icon(
        BasfIcons.arrow_down,
        size: 16,
        color: isDisabled
            ? BasfInputThemes.disabledInputTheme(theme)
                    .inputDecorationTheme
                    .disabledBorder
                    ?.borderSide
                    .color ??
                theme.disabledColor
            : widget.isMandatory && selectedValue.isEmpty
                ? theme.colorScheme.error
                : theme.primaryColor,
      ),
    );
  }

  bool get isDisabled {
    return (widget.values.length < 2 || widget.isDisabled) && !widget.isLoading;
  }
}
