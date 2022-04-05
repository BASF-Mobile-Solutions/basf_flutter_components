import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/theme/inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasfTextField extends StatefulWidget {
  const BasfTextField({
    Key? key,
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
    this.scrollPadding = const EdgeInsets.all(30.0),
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
  }) : super(key: key);

  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final ScrollController? scrollController;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;

  @override
  _BasfTextFieldState createState() => _BasfTextFieldState();
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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _getTheme(),
      child: widget.decoration?.labelText == null
          ? inputForm()
          : inputFormWithTitle(),
    );
  }

  Widget inputFormWithTitle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title(),
        VerticalSpacer.semi(),
        widget.validator != null ? validationFormField() : textField(),
      ],
    );
  }

  Widget inputForm() {
    return widget.validator != null ? validationFormField() : textField();
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

  Widget? _getThemedPrefixIcon() {
    if (widget.decoration?.prefixIcon != null) {
      return Theme(
        data: _getTheme(),
        child: widget.decoration!.prefixIcon!,
      );
    } else {
      return null;
    }
  }

  ThemeData _getTheme() {
    if (widget.formKey?.currentState?.validate() == false) {
      return BasfInputThemes.errorInputTheme;
    } else if (!isEnabled()) {
      return BasfInputThemes.disabledInputTheme;
    } else {
      return Theme.of(context);
    }
  }

  Widget validationFormField() {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: textFormField(),
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

  Widget textFormField() {
    return TextFormField(
      key: widget.key,
      focusNode: widget.focusNode,
      controller: widget.controller,
      initialValue: widget.initialValue,
      decoration: widget.decoration?.copyWith(
        prefixIcon: _getThemedPrefixIcon(),
        hintText: widget.decoration?.hintText,
        labelText: null,
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

  Widget textField() {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      decoration: widget.decoration?.copyWith(
        prefixIcon: _getThemedPrefixIcon(),
        hintText: widget.decoration?.hintText,
        labelText: null,
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
