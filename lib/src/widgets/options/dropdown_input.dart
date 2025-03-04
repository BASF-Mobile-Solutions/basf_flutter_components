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
    this.isLoading = false,
    this.isDisabled = false,
    this.isMandatory = false,
    @Deprecated('Use controller value instead') this.initialValue,
    this.unselectedText = 'Select value',
    this.allowUnselected = false,
    this.itemColor,
    this.maxWidth,
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

  /// Whether or not the dropdown is loading
  final bool isLoading;

  /// Blocks dropdown and colors in grey
  final bool isDisabled;

  /// Whether or not the border is displayed in current theme's error color
  /// (e.g. red) if the field is empty
  final bool isMandatory;

  /// Initial value for the dropdown
  /// initial value should be provided by controller
  @Deprecated('Use controller value instead')
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

  /// Set the width constrains of the dropdown, especially useful when placed
  /// in Row
  final double? maxWidth;

  @override
  State<BasfDropDownInput> createState() => _BasfDropDownInputState();
}

class _BasfDropDownInputState extends State<BasfDropDownInput> {
  late String _selectedValue;
  Color? _selectedColor;
  late String _unselectedValue;

  @override
  void initState() {
    _unselectedValue = _generateUniqueUnselectedValue();
    _initializeSelectedValue();
    widget.controller.addListener(() {
      if (widget.controller.text.isEmpty) {
        _onChanged(widget.unselectedText);
      } else {
        if (widget.controller.text != _selectedValue &&
            widget.values.contains(widget.controller.text)) {
          _onChanged(widget.controller.text);
        }
      }
    });
    super.initState();
  }

  String _generateUniqueUnselectedValue() {
    var unselectedValue = widget.unselectedText;
    var counter = 0;
    while (widget.values.contains(unselectedValue)) {
      counter++;
      unselectedValue = '${widget.unselectedText}-$counter';
    }
    return unselectedValue;
  }

  void _initializeSelectedValue() {
    if (widget.values.length == 1) {
      _selectedValue = widget.values.first;
    } else {
      final initValue = widget.initialValue ?? widget.controller.text;
      if (widget.values.contains(initValue)) {
        _selectedValue = initValue;
      } else if (widget.allowUnselected) {
        _selectedValue = _unselectedValue;
      } else {
        _selectedValue =
            widget.values.isNotEmpty ? widget.values.first : _unselectedValue;
      }
    }
    _updateController();
    _updateSelectedColor();
  }

  void _updateController() {
    widget.controller.text =
        _selectedValue == _unselectedValue
            ? widget.unselectedText
            : _selectedValue;
  }

  void _updateSelectedColor() {
    _selectedColor =
        _selectedValue == _unselectedValue
            ? null
            : widget.itemColor?.call(_selectedValue);
  }

  void _onChanged(String? value) {
    widget.onChanged?.call(value == _unselectedValue ? null : value);

    setState(() {
      _selectedValue = value ?? '';
      _updateSelectedColor();
      _updateController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.maxWidth ?? double.infinity),
      child: IntrinsicWidth(
        child: LabeledWidget(
          labelText: widget.labelText,
          child: popupMenuButton(context),
        ),
      ),
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
        onSelected: _onChanged,
        itemBuilder: (context) {
          final items = <PopupMenuEntry<String>>[];

          if (widget.allowUnselected) {
            items.add(
              PopupMenuItem<String>(
                value: _unselectedValue,
                child: Text(
                  widget.unselectedText,
                  style: TextStyle(color: Theme.of(context).primaryColor),
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
                    color:
                        widget.itemColor?.call(value) ??
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

    final borderColor =
        isDisabled
            ? disabledTheme
                    .inputDecorationTheme
                    .disabledBorder
                    ?.borderSide
                    .color ??
                theme.disabledColor
            : widget.isMandatory && _selectedValue == _unselectedValue
            ? theme.colorScheme.error
            : _selectedColor ??
                theme.inputDecorationTheme.enabledBorder?.borderSide.color ??
                theme.primaryColor;

    final textColor =
        isDisabled ? theme.disabledColor : _selectedColor ?? theme.primaryColor;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BasfThemes.defaultBorderRadius,
        color:
            isDisabled
                ? BasfInputThemes.disabledInputTheme(
                  theme,
                ).inputDecorationTheme.fillColor
                : null,
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        mainAxisAlignment: widget.mainAxisAlignment,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: Dimens.paddingMedium),
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                _selectedValue == _unselectedValue
                    ? widget.unselectedText
                    : _selectedValue,
                style: BasfThemes.mainTextTheme.titleLarge?.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ),
          if (!widget.isLoading) menuButton(borderColor),
          if (widget.isLoading) loader(theme),
        ],
      ),
    );
  }

  Widget loader(ThemeData theme) {
    return Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.only(left: 18, right: 15),
      child: CircularProgressIndicator(
        color: theme.primaryColor,
        strokeWidth: 3,
      ),
    );
  }

  Widget menuButton(Color color) {
    return Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.only(left: 18, right: 15),
      child: Icon(BasfIcons.arrow_down, size: 16, color: color),
    );
  }

  bool get isDisabled {
    return (widget.values.isEmpty ||
            widget.values.length == 1 ||
            widget.isDisabled) &&
        !widget.isLoading;
  }
}
