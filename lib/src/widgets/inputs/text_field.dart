import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template basf_text_field}
/// A BASF-styled text field input
/// {@endtemplate}
class BasfTextField extends StatefulWidget {
  /// {@macro basf_text_field}
  const BasfTextField({
    super.key,
    required this.controller,
    this.formKey,
    this.initialValue,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(30),
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
  });

  /// Form key
  final GlobalKey<FormState>? formKey;

  /// Text field controller
  final TextEditingController? controller;

  /// Initial value
  final String? initialValue;

  /// Current focus node
  final FocusNode? focusNode;

  /// Input decoration
  final InputDecoration? decoration;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text capitalization
  final TextCapitalization textCapitalization;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Text style
  final TextStyle? style;

  /// Text strut style
  final StrutStyle? strutStyle;

  /// Text direction
  final TextDirection? textDirection;

  /// Text alignment
  final TextAlign textAlign;

  /// Text alignment vertical
  final TextAlignVertical? textAlignVertical;

  /// Autofocus
  final bool autofocus;

  /// Read-only
  final bool readOnly;

  /// Toolbar options
  final ToolbarOptions? toolbarOptions;

  /// Whether or not to show the cursor
  final bool? showCursor;

  /// Obscuring character
  final String obscuringCharacter;

  /// Wheter or not to hide the text
  final bool obscureText;

  /// Wheter or not to correct the text automatically
  final bool autocorrect;

  /// Smart dashes type
  final SmartDashesType? smartDashesType;

  /// Smart quotes type
  final SmartQuotesType? smartQuotesType;

  /// Wheter or not to show suggestions
  final bool enableSuggestions;

  /// Max length setter
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Max lines for the input
  final int? maxLines;

  /// Min lines for the input
  final int? minLines;

  /// Wheter or not it expands
  final bool expands;

  /// Max character length
  final int? maxLength;

  /// Action to be performed when the value changes
  final ValueChanged<String>? onChanged;

  /// On tap callback performed on tap
  final GestureTapCallback? onTap;

  /// Void callback when editing is completed
  final VoidCallback? onEditingComplete;

  /// Field submitted value
  final ValueChanged<String>? onFieldSubmitted;

  /// Field submitted on saved
  final FormFieldSetter<String>? onSaved;

  /// Field validator
  final FormFieldValidator<String>? validator;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Wheter or not it is enabled
  final bool? enabled;

  /// Cursor width
  final double cursorWidth;

  /// Cursor height
  final double? cursorHeight;

  /// Cursor radius
  final Radius? cursorRadius;

  /// Cursor color
  final Color? cursorColor;

  /// Keyboard appearance
  final Brightness? keyboardAppearance;

  /// Scroll padding
  final EdgeInsets scrollPadding;

  /// Enable interactive selection
  final bool enableInteractiveSelection;

  /// Controls
  final TextSelectionControls? selectionControls;

  /// Counter widget
  final InputCounterWidgetBuilder? buildCounter;

  /// Physics
  final ScrollPhysics? scrollPhysics;

  /// Auto fill hints
  final Iterable<String>? autofillHints;

  /// Auto validate
  final AutovalidateMode? autovalidateMode;

  /// Scroll controller
  final ScrollController? scrollController;

  /// Restoration ID
  final String? restorationId;

  /// Enable IMEPErsonalized learning
  final bool enableIMEPersonalizedLearning;

  @override
  State<BasfTextField> createState() => _BasfTextFieldState();
}

class _BasfTextFieldState extends State<BasfTextField> {
  @override
  void initState() {
    if (widget.validator != null) {
      widget.controller?.addListener(redrawToChangeThemeBasedOnState);
      redrawToChangeThemeBasedOnState();
    }
    super.initState();
  }

  void redrawToChangeThemeBasedOnState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: _getTheme(theme),
      child: widget.decoration?.labelText == null
          ? inputForm(theme)
          : inputFormWithTitle(theme),
    );
  }

  Widget inputFormWithTitle(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title(),
        VerticalSpacer.semi(),
        if (widget.validator != null)
          validationFormField(theme)
        else
          textField(theme), //verde
      ],
    );
  }

  Widget inputForm(ThemeData theme) {
    return widget.validator != null
        ? validationFormField(theme)
        : textField(theme);
  }

  Widget title() {
    return Text(
      widget.decoration?.labelText ?? '',
      maxLines: 2,
      style: Theme.of(context)
          .textTheme
          .overline!
          .copyWith(color: BasfColors.black),
    );
  }

  Widget? _getThemedPrefixIcon(ThemeData theme) {
    if (widget.decoration?.prefixIcon != null) {
      return Theme(
        data: _getTheme(theme),
        child: widget.decoration!.prefixIcon!,
      );
    } else {
      return null;
    }
  }

  ThemeData _getTheme(ThemeData theme) {
    if (widget.formKey?.currentState?.validate() == false) {
      return BasfInputThemes.errorInputTheme(theme);
    } else if (!isEnabled()) {
      return BasfInputThemes.disabledInputTheme(theme);
    } else {
      return Theme.of(context);
    }
  }

  Widget validationFormField(ThemeData theme) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: textFormField(theme),
    );
  }

  TextStyle _getTextStyle() {
    return widget.style?.copyWith(
          color: isEnabled() ? BasfColors.darkBlue : BasfColors.darkGrey,
        ) ??
        TextStyle(
          color: isEnabled() ? BasfColors.darkBlue : BasfColors.darkGrey,
        );
  }

  bool isEnabled() {
    return widget.enabled ?? widget.decoration?.enabled ?? true;
  }

  Widget textFormField(ThemeData theme) {
    return TextFormField(
      key: widget.key,
      focusNode: widget.focusNode,
      controller: widget.controller,
      initialValue: widget.initialValue,
      decoration: widget.decoration?.copyWith(
        prefixIcon: _getThemedPrefixIcon(theme),
        hintText: widget.decoration?.hintText,
        labelStyle: widget.decoration?.labelStyle ??
            BasfThemes.mainTextTheme.bodyText1
                ?.copyWith(color: BasfColors.darkGrey),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      style: _getTextStyle(),
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      toolbarOptions: widget.toolbarOptions,
      showCursor: widget.showCursor,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      buildCounter: widget.buildCounter,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      autovalidateMode: widget.autovalidateMode,
      scrollController: widget.scrollController,
      restorationId: widget.restorationId,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
    );
  }

  Widget textField(ThemeData theme) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      decoration: widget.decoration?.copyWith(
        prefixIcon: _getThemedPrefixIcon(theme),
        hintText: widget.decoration?.hintText,
        labelStyle: widget.decoration?.labelStyle ??
            BasfThemes.mainTextTheme.bodyText1
                ?.copyWith(color: BasfColors.darkGrey),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      style: _getTextStyle(),
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      toolbarOptions: widget.toolbarOptions,
      showCursor: widget.showCursor,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      buildCounter: widget.buildCounter,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      scrollController: widget.scrollController,
      restorationId: widget.restorationId,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
    );
  }
}
