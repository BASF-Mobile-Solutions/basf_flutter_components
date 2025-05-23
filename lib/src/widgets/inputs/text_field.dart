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
    required this.controller,
    super.key,
    // this.formKey,//TODO: Remove unused?
    this.labelText,
    this.onScanPressed,
    this.multiScanEnabled = false,
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
    this.autovalidateMode = AutovalidateMode.always,
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
  });

  /// Constructor to create a [BasfTextField] from a [TextFieldData]
  BasfTextField.fromTextFieldData({
    required TextFieldData textFieldData,
    String? labelText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization? textCapitalization,
    this.onScanPressed,
    this.multiScanEnabled = false,
    this.focusNode,
    this.textInputAction,
    this.decoration,
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
    this.ignorePointers,
    this.onTapAlwaysCalled = false,
    this.onTapUpOutside,
    this.statesController,
    super.key,
  }) : labelText = labelText ?? textFieldData.labelText,
       controller = controller ?? textFieldData.controller,
       validator = validator ?? textFieldData.validator,
       autovalidateMode = autovalidateMode ?? textFieldData.autovalidateMode,
       keyboardType = keyboardType ?? textFieldData.keyboardType,
       inputFormatters = inputFormatters ?? textFieldData.inputFormatters,
       textCapitalization =
           textCapitalization ?? textFieldData.textCapitalization;

  /// Label of the [BasfTextField]
  /// Prefer this instead of the [decoration] property for the label
  final String? labelText;

  /// Form key
  // final GlobalKey<FormState>? formKey;//TODO: Remove unused?

  /// Text field controller
  final TextEditingController controller;

  /// If provided, a scan icon is shown if the BasfTextField is empty
  final VoidCallback? onScanPressed;

  /// If true, the scan icon is shown even if the BasfTextField is not empty if
  /// `onScanPressed` is provided
  final bool multiScanEnabled;

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

  /// If the color should be changed to grey when disabled
  final bool greyWhenDisabled;

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

  @override
  State<BasfTextField> createState() => _BasfTextFieldState();
}

class _BasfTextFieldState extends State<BasfTextField> {
  late final hasValidation = widget.validator != null;
  bool isFirstValidation = true;
  late final emptyTextFieldNotifier = ValueNotifier(
    widget.controller.text.isEmpty,
  );

  @override
  void initState() {
    if (hasValidation) {
      widget.controller.addListener(redrawToChangeThemeBasedOnState);
    }
    widget.controller.addListener(checkDeleteButtonVisibility);
    super.initState();
  }

  void checkDeleteButtonVisibility() {
    emptyTextFieldNotifier.value = widget.controller.text.isEmpty;
  }

  void redrawToChangeThemeBasedOnState() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    }
  }

  String? get errorText =>
      hasValidation ? widget.validator!(widget.controller.text) : null;

  bool get isEnabled => widget.enabled ?? widget.decoration?.enabled ?? true;

  @override
  Widget build(BuildContext context) {
    final theme = _getTheme(Theme.of(context));

    return LabeledWidget(
      labelText: widget.labelText ?? widget.decoration?.labelText,
      child: textField(theme),
    );
  }

  ThemeData _getTheme(ThemeData theme) {
    if (!isEnabled && widget.greyWhenDisabled) {
      return BasfInputThemes.disabledInputTheme(theme);
    }
    if (!hasValidation) return Theme.of(context);

    switch (widget.autovalidateMode) {
      case AutovalidateMode.always:
        if (errorText != null) {
          return BasfInputThemes.errorInputTheme(theme);
        }
      case AutovalidateMode.onUserInteraction:
        if (!isFirstValidation && errorText != null) {
          return BasfInputThemes.errorInputTheme(theme);
        }
      case AutovalidateMode.onUnfocus:
        if (widget.focusNode?.hasFocus == false && errorText != null) {
          return BasfInputThemes.errorInputTheme(theme);
        }
      default:
        break;
    }

    return Theme.of(context);
  }

  Widget actionIcon(ThemeData theme) {
    return ValueListenableBuilder(
      valueListenable: emptyTextFieldNotifier,
      builder: (context, emptyTextField, _) {
        if (isEnabled && widget.onScanPressed != null) {
          if (widget.multiScanEnabled) {
            return _scanIconButton(theme);
          }
          return emptyTextField
              ? _scanIconButton(theme)
              : _deleteIconButton(theme);
        }

        return Visibility(
          visible: isEnabled && !emptyTextField,
          child: _deleteIconButton(theme),
        );
      },
    );
  }

  Widget _scanIconButton(ThemeData theme) {
    return IconButton(
      icon: const Icon(Icons.qr_code_2_sharp),
      color: theme.iconTheme.color,
      splashRadius: 25,
      splashColor: Theme.of(context).dialogTheme.backgroundColor,
      highlightColor: Theme.of(context).dialogTheme.backgroundColor,
      onPressed: widget.onScanPressed,
    );
  }

  Widget _deleteIconButton(ThemeData theme) {
    return IconButton(
      icon: const Icon(Icons.delete_sweep_outlined),
      color: theme.iconTheme.color,
      splashRadius: 25,
      splashColor: Theme.of(context).dialogTheme.backgroundColor,
      highlightColor: Theme.of(context).dialogTheme.backgroundColor,
      onPressed: () {
        widget.controller.clear();
        widget.focusNode?.requestFocus();
        widget.onChanged?.call('');
        isFirstValidation = false;
        // redrawToChangeThemeBasedOnState();
      },
    );
  }

  TextStyle? _getTextStyle() {
    final currentTextStyle = widget.style ?? const TextStyle();

    return isEnabled
        ? currentTextStyle.copyWith(color: Theme.of(context).primaryColor)
        : currentTextStyle.copyWith(
            color: BasfColors.darkGrey,
            fontWeight: FontWeight.w600,
          );
  }

  Widget textField(ThemeData theme) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
        suffixIcon: widget.decoration?.suffixIcon ?? actionIcon(theme),
        prefixIcon: widget.decoration?.prefixIcon,
        prefixIconColor: theme.iconTheme.color,
        error: errorText == '' ? const SizedBox() : null,
        errorText: errorText.isNullOrEmpty ? null : errorText,
        hintText: widget.decoration?.hintText ?? widget.labelText,
        hintStyle: theme.inputDecorationTheme.hintStyle,
        labelStyle: theme.inputDecorationTheme.hintStyle,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: theme.inputDecorationTheme.fillColor,
        filled: theme.inputDecorationTheme.filled,
      ),
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
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
        widget.onChanged?.call(text);
        isFirstValidation = false;
      },
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

  @override
  void dispose() {
    widget.controller
      ..removeListener(redrawToChangeThemeBasedOnState)
      ..removeListener(checkDeleteButtonVisibility);
    super.dispose();
  }
}
