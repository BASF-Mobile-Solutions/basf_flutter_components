import 'dart:ui';

import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template basf_text_field}
/// A BASF-styled text field input
/// {@endtemplate}
class BasfTextField extends StatefulWidget {
  /// {@macro basf_text_field}
  const BasfTextField({
    this.textFieldData,
    this.controller,
    this.formKey,
    // this.initialValue, //TODO: Remove unused?
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.contextMenuBuilder,
    this.mouseCursor,
    this.onTapOutside,
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
    // this.onFieldSubmitted, //TODO: Remove unused?
    // this.onSaved, //TODO: Remove unused?
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
    this.greyWhenDisabled = true,
    this.canRequestFocus = true,
    this.clipBehavior = Clip.hardEdge,
    this.contentInsertionConfiguration,
    this.cursorOpacityAnimates,
    this.dragStartBehavior = DragStartBehavior.start,
    this.magnifierConfiguration,
    this.onAppPrivateCommand,
    this.onSubmitted,
    this.stylusHandwritingEnabled = true,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.spellCheckConfiguration,
    this.undoController,
    this.cursorErrorColor,
    this.onTapAlwaysCalled = false,
    this.statesController,
    this.ignorePointers,
    this.onTapUpOutside,
    this.validatorForceErrorText,
    super.key,
    this.labelText,
  });

  /// Provide common text field data
  final TextFieldData? textFieldData;

  /// Label of the [BasfTextField]
  final String? labelText;

  /// Form key
  final GlobalKey<FormState>? formKey;

  /// Text field controller
  final TextEditingController? controller;

  /// Initial value
  // final String? initialValue; //TODO: Remove unused?

  /// Current focus node
  final FocusNode? focusNode;

  /// Input decoration
  final InputDecoration? decoration;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text capitalization
  final TextCapitalization? textCapitalization;

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

  /// Context menu builder
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Mouse cursor
  final MouseCursor? mouseCursor;

  /// OnTapOutside
  final TapRegionCallback? onTapOutside;

  /// Whether or not to show the cursor
  final bool? showCursor;

  /// Obscuring character
  final String obscuringCharacter;

  /// Whether or not to hide the text
  final bool obscureText;

  /// Whether or not to correct the text automatically
  final bool autocorrect;

  /// Smart dashes type
  final SmartDashesType? smartDashesType;

  /// Smart quotes type
  final SmartQuotesType? smartQuotesType;

  /// Whether or not to show suggestions
  final bool enableSuggestions;

  /// Max length setter
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Max lines for the input
  final int? maxLines;

  /// Min lines for the input
  final int? minLines;

  /// Whether or not it expands
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
  // final ValueChanged<String>? onFieldSubmitted; //TODO: Remove unused?

  /// Field submitted on saved
  // final FormFieldSetter<String>? onSaved; //TODO: Remove unused?

  /// Field validator
  final FormFieldValidator<String>? validator;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Whether or not it is enabled
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

  /// If the color should be changed to grey when disabled
  final bool greyWhenDisabled;

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

  /// Enable IMEPersonalized learning
  final bool enableIMEPersonalizedLearning;

  /// Request focus
  final bool canRequestFocus;

  /// Clip behavior
  final Clip clipBehavior;

  /// Content configuration
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// Cursor animation
  final bool? cursorOpacityAnimates;

  /// Drag behavior
  final DragStartBehavior dragStartBehavior;

  /// Magnifier config
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Primitive command
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// OnSubmitted callback
  final ValueChanged<String>? onSubmitted;

  /// Stylus handwriting enabled
  final bool stylusHandwritingEnabled;

  /// Controls how height the selection highlight boxes are computed to be.
  final BoxHeightStyle selectionHeightStyle;

  /// Controls how wide the selection highlight boxes are computed to be.
  final BoxWidthStyle selectionWidthStyle;

  /// Spell check
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// Undo controller
  final UndoHistoryController? undoController;

  /// cursor error color
  final Color? cursorErrorColor;

  /// on tap always called
  final bool onTapAlwaysCalled;

  /// states controller
  final WidgetStatesController? statesController;

  /// on tap outside callback
  final TapRegionUpCallback? onTapUpOutside;

  /// ignore pointers
  final bool? ignorePointers;

  /// Show error
  final String? validatorForceErrorText;

  @override
  State<BasfTextField> createState() => _BasfTextFieldState();
}

class _BasfTextFieldState extends State<BasfTextField> {
  GlobalKey<FormState>? _formKey;
  bool isFirstValidation = true;
  late final ValueNotifier<bool> deleteButtonNotifier;

  late final labelText = widget.labelText ?? widget.textFieldData?.labelText;
  late final hintText =
      widget.decoration?.hintText ?? widget.textFieldData?.hintText;

  late final controller =
      widget.controller ??
      widget.textFieldData?.controller ??
      TextEditingController();

  late final autovalidateMode =
      widget.autovalidateMode ?? widget.textFieldData?.autovalidateMode;

  late final validator = widget.validator ?? widget.textFieldData?.validator;

  @override
  void initState() {
    if (validator != null) {
      _formKey = widget.formKey ?? GlobalKey<FormState>();
      controller.addListener(redrawToChangeThemeBasedOnState);
      redrawToChangeThemeBasedOnState();
    }
    controller.addListener(checkDeleteButtonVisibility);
    deleteButtonNotifier = ValueNotifier(controller.text.isNotEmpty);
    super.initState();
  }

  @override
  void dispose() {
    controller
      ..removeListener(redrawToChangeThemeBasedOnState)
      ..removeListener(checkDeleteButtonVisibility);
    super.dispose();
  }

  void checkDeleteButtonVisibility() {
    deleteButtonNotifier.value = controller.text.isNotEmpty;
  }

  void redrawToChangeThemeBasedOnState() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: _getTheme(theme),
      child: LabeledWidget(labelText: labelText, child: inputForm(theme)),
    );
  }

  Widget inputForm(ThemeData theme) {
    return validator != null
        ? validationFormField(theme)
        : textField(theme: theme);
  }

  Widget? _getThemedPrefixIcon(ThemeData theme) {
    if (widget.decoration?.prefixIcon == null) return null;

    return Theme(data: _getTheme(theme), child: widget.decoration!.prefixIcon!);
  }

  ThemeData _getTheme(ThemeData theme) {
    if (!isEnabled) {
      return BasfInputThemes.disabledInputTheme(theme);
    }
    switch (autovalidateMode) {
      case AutovalidateMode.always:
        if (_formKey?.currentState?.validate() == false) {
          return BasfInputThemes.errorInputTheme(theme);
        }
      case AutovalidateMode.onUserInteraction:
        if (!isFirstValidation && _formKey?.currentState?.validate() == false) {
          return BasfInputThemes.errorInputTheme(theme);
        }
      case AutovalidateMode.onUnfocus:
        if (widget.focusNode?.hasFocus == false &&
            _formKey?.currentState?.validate() == false) {
          return BasfInputThemes.errorInputTheme(theme);
        }
      default:
        break;
    }

    return Theme.of(context);
  }

  Widget validationFormField(ThemeData theme) {
    return FormField<String>(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      validator: validator,
      builder: (FormFieldState<String> state) {
        return textField(theme: theme, state: state);
      },
    );
  }

  TextStyle _getTextStyle() {
    return widget.greyWhenDisabled
        ? widget.style?.copyWith(
              color:
                  isEnabled
                      ? Theme.of(context).primaryColor
                      : BasfColors.darkGrey,
            ) ??
            TextStyle(
              color:
                  isEnabled
                      ? Theme.of(context).primaryColor
                      : BasfColors.darkGrey,
            )
        : widget.style ?? const TextStyle();
  }

  bool get isEnabled => widget.enabled ?? widget.decoration?.enabled ?? true;

  Widget deleteIconButton() {
    return ValueListenableBuilder(
      valueListenable: deleteButtonNotifier,
      builder: (context, visible, _) {
        return Visibility(
          visible: visible,
          child: IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            color: Theme.of(context).iconTheme.color,
            splashRadius: 25,
            splashColor: Theme.of(context).dialogTheme.backgroundColor,
            highlightColor: Theme.of(context).dialogTheme.backgroundColor,
            onPressed: () {
              controller.text = '';
              widget.focusNode?.requestFocus();
            },
          ),
        );
      },
    );
  }

  InputDecoration _getDefaultDecoration({
    required ThemeData theme,
    String? errorText,
  }) {
    return InputDecoration(
      suffixIcon: deleteIconButton(),
      prefixIcon: _getThemedPrefixIcon(theme),
      error: errorText != null && errorText.isEmpty ? const SizedBox() : null,
      errorText: errorText == null || errorText.isEmpty ? null : errorText,
      hintText: hintText,
      labelStyle:
          widget.decoration?.labelStyle ??
          BasfThemes.mainTextTheme.bodyLarge?.copyWith(
            color: BasfColors.darkGrey,
          ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }

  Widget textField({required ThemeData theme, FormFieldState<String>? state}) {
    final errorText = state?.errorText ?? widget.validatorForceErrorText;

    return TextField(
      focusNode: widget.focusNode,
      controller: controller,
      decoration:
          widget.decoration?.copyWith(
            suffixIcon: widget.decoration?.suffixIcon ?? deleteIconButton(),
            prefixIcon: _getThemedPrefixIcon(theme),
            error:
                errorText != null && errorText.isEmpty
                    ? const SizedBox()
                    : null,
            errorText:
                errorText == null || errorText.isEmpty ? null : errorText,
            hintText: hintText,
            labelStyle:
                widget.decoration?.labelStyle ??
                BasfThemes.mainTextTheme.bodyLarge?.copyWith(
                  color: BasfColors.darkGrey,
                ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ) ??
          _getDefaultDecoration(theme: theme, errorText: state?.errorText),
      keyboardType: widget.keyboardType ?? widget.textFieldData?.keyboardType,
      textCapitalization:
          widget.textCapitalization ??
          widget.textFieldData?.textCapitalization ??
          TextCapitalization.none,
      textInputAction: widget.textInputAction,
      style: _getTextStyle(),
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
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
      onChanged: (text) {
        state?.didChange(text);
        widget.onChanged?.call(text);
        isFirstValidation = false;
      },
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      inputFormatters:
          widget.inputFormatters ?? widget.textFieldData?.inputFormatters,
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
      contextMenuBuilder:
          widget.contextMenuBuilder ?? const TextField().contextMenuBuilder,
      onTapOutside: widget.onTapOutside,
      canRequestFocus: widget.canRequestFocus,
      clipBehavior: widget.clipBehavior,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
      cursorOpacityAnimates: widget.cursorOpacityAnimates,
      dragStartBehavior: widget.dragStartBehavior,
      magnifierConfiguration: widget.magnifierConfiguration,
      mouseCursor: widget.mouseCursor,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      onSubmitted: widget.onSubmitted,
      stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      spellCheckConfiguration: widget.spellCheckConfiguration,
      undoController: widget.undoController,
      cursorErrorColor: widget.cursorErrorColor,
      onTapAlwaysCalled: widget.onTapAlwaysCalled,
      statesController: widget.statesController,
      ignorePointers: widget.ignorePointers,
      onTapUpOutside: widget.onTapUpOutside,
    );
  }
}
