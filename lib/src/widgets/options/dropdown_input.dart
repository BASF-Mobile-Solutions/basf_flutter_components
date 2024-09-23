import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// {@template dropdown_input}
/// A BASF-styled dropdown input with support for unselected values
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
    this.initialValue,
    this.unselectedText = 'Select value',
    this.allowUnselected = false,
    this.itemColor,
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

  /// Initial value for the dropdown
  final String? initialValue;

  /// Text to display for the unselected option
  final String unselectedText;

  /// Whether to allow unselected state
  final bool allowUnselected;

  /// Callback for when the value changes
  final void Function(String?)? onChanged;

  /// A function that allows us to change the color of the dropdown's items
  /// based on the value of the item
  final Color? Function(String)? itemColor;

  /// Special value to represent the unselected state
  static const String unselectedValue = '____UNSELECTED____';

  @override
  State<BasfDropDownInput> createState() => _BasfDropDownInputState();
}

class _BasfDropDownInputState extends State<BasfDropDownInput> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _initializeSelectedValue();
  }

  void _initializeSelectedValue() {
    if (widget.initialValue != null &&
        widget.values.contains(widget.initialValue)) {
      _selectedValue = widget.initialValue!;
    } else if (widget.allowUnselected) {
      _selectedValue = BasfDropDownInput.unselectedValue;
    } else {
      _selectedValue = widget.values.isNotEmpty
          ? widget.values.first
          : BasfDropDownInput.unselectedValue;
    }
    _updateController();
  }

  void _updateController() {
    widget.controller.text = _selectedValue == BasfDropDownInput.unselectedValue
        ? widget.unselectedText
        : _selectedValue;
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
      child: PopupMenuButton<String>(
        initialValue: _selectedValue,
        shape: RoundedRectangleBorder(
          borderRadius: BasfThemes.defaultBorderRadius,
        ),
        onSelected: (String value) {
          widget.onChanged?.call(
            value == BasfDropDownInput.unselectedValue ? null : value,
          );

          setState(() {
            _selectedValue = value;
            _updateController();
          });
        },
        itemBuilder: (context) {
          final items = <PopupMenuEntry<String>>[];

          if (widget.allowUnselected) {
            items.add(
              PopupMenuItem<String>(
                value: BasfDropDownInput.unselectedValue,
                child: Text(
                  widget.unselectedText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            );
          }

          items.addAll(
            widget.values.map(
              (value) => PopupMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: widget.itemColor?.call(value) ??
                            Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ),
          );

          return items;
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
              : widget.isMandatory &&
                      _selectedValue == BasfDropDownInput.unselectedValue
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
              _selectedValue == BasfDropDownInput.unselectedValue
                  ? widget.unselectedText
                  : _selectedValue,
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
            : widget.isMandatory &&
                    _selectedValue == BasfDropDownInput.unselectedValue
                ? theme.colorScheme.error
                : theme.primaryColor,
      ),
    );
  }

  bool get isDisabled {
    return (widget.values.isEmpty || widget.isDisabled) && !widget.isLoading;
  }
}
