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
    if (widget.labelText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(),
          VerticalSpacer.semi(),
          popupMenuButton(context),
        ],
      );
    } else {
      return popupMenuButton(context);
    }
  }

  Widget title() {
    return Text(
      widget.labelText!,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget popupMenuButton(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.isLoading || isDisabled,
      child: Theme(
        data: ThemeData(
          highlightColor: BasfThemes.getMaterialColor().shade50,
        ),
        child: PopupMenuButton<String>(
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
                child: Text(
                  widget.values[index],
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
              );
            });
          },
          child: layout(),
        ),
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
        color: isDisabled
            ? BasfInputThemes.disabledInputTheme(theme)
                .inputDecorationTheme
                .fillColor
            : null,
        border: Border.all(
          color: isDisabled
              ? disabledTheme
                      .inputDecorationTheme.disabledBorder?.borderSide.color ??
                  theme.disabledColor
              : widget.isMandatory && widget.controller.text.trim().isEmpty
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
          Padding(
            padding: const EdgeInsets.only(left: Dimens.paddingMedium),
            child: Text(
              widget.controller.text,
              style: BasfThemes.mainTextTheme.titleLarge
                  ?.copyWith(color: theme.primaryColor),
            ),
          ),
          if (widget.isExpanded) const Spacer(),
          if (!widget.isLoading) _menuButton(),
          if (widget.isLoading) _loader(theme),
        ],
      ),
    );
  }

  Widget _loader(ThemeData theme) {
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

  Widget _menuButton() {
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
            : widget.isMandatory && widget.controller.text.trim().isEmpty
                ? theme.colorScheme.error
                : theme.primaryColor,
      ),
    );
  }

  bool get isDisabled {
    return (widget.values.length < 2 || widget.isDisabled) && !widget.isLoading;
  }
}
