import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template optional_dropdown_input}
/// A BASF-styled optional dropdown input
/// {@endtemplate}
class BasfOptionalDropDownInput extends StatefulWidget {
  /// {@macro optional_dropdown_input}
  const BasfOptionalDropDownInput({
    required this.controller,
    required this.values,
    super.key,
    this.labelText,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.isExpanded = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.emptyStateText = 'Select an option',
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

  /// Text to display when no value is selected
  final String emptyStateText;

  @override
  State<BasfOptionalDropDownInput> createState() =>
      _BasfOptionalDropDownInputState();
}

class _BasfOptionalDropDownInputState extends State<BasfOptionalDropDownInput> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.controller.text.isNotEmpty &&
            widget.values.contains(widget.controller.text.trim())
        ? widget.controller.text.trim()
        : null;
    widget.controller.text = _selectedValue ?? '';
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
      absorbing: widget.isLoading || widget.isDisabled,
      child: PopupMenuButton<String?>(
        initialValue: _selectedValue,
        shape: RoundedRectangleBorder(
          borderRadius: BasfThemes.defaultBorderRadius,
        ),
        onSelected: (String? value) {
          setState(() {
            _selectedValue = value;
            widget.controller.text = value ?? '';
          });
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem<String?>(
              child: Text(
                widget.emptyStateText,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).hintColor),
              ),
            ),
            ...widget.values.map(
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
            ),
          ];
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
        color: widget.isDisabled
            ? disabledTheme.inputDecorationTheme.fillColor
            : null,
        border: Border.all(
          color: widget.isDisabled
              ? disabledTheme
                      .inputDecorationTheme.disabledBorder?.borderSide.color ??
                  theme.disabledColor
              : theme.inputDecorationTheme.enabledBorder?.borderSide.color ??
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
                _selectedValue ?? widget.emptyStateText,
                style: _selectedValue == null
                    ? BasfThemes.mainTextTheme.titleLarge
                        ?.copyWith(color: theme.hintColor)
                    : BasfThemes.mainTextTheme.titleLarge
                        ?.copyWith(color: theme.primaryColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
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
        color: widget.isDisabled
            ? BasfInputThemes.disabledInputTheme(theme)
                    .inputDecorationTheme
                    .disabledBorder
                    ?.borderSide
                    .color ??
                theme.disabledColor
            : theme.primaryColor,
      ),
    );
  }
}
