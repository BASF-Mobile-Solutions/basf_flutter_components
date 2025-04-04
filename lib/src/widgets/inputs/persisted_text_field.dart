import 'dart:ui';

import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

/// [TextField] that prompts auto-filled values based on previous inputs, also
/// has favorite inputs.
class PersistedTextField extends StatefulWidget {
  /// Default constructor
  const PersistedTextField({
    required this.persistenceId,
    required this.controller,

    /// You provide a bool notifier, when it becomes true,
    /// save value is triggered
    required this.saveTriggerNotifier,
    this.labelText,
    this.onScanPressed,
    this.dropdownBackgroundColor = Colors.white,
    // this.formKey,//TODO: Remove unused?
    // this.initialValue,//TODO: Remove unused?
    this.decoration,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.prefillWithFavorite = true,
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
    // this.onFieldSubmitted,//TODO: Remove unused?
    // this.onSaved,//TODO: Remove unused?
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
    this.scribbleEnabled = true,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.spellCheckConfiguration,
    this.undoController,
    this.persistentCubit,
    this.cursorErrorColor,
    this.ignorePointers,
    this.onTapAlwaysCalled = false,
    this.onTapUpOutside,
    this.statesController,
    super.key,
  });

  /// Constructor to create a [PersistedTextField] from a [TextFieldData]
  /// With this constructor, the favorite value is not used by default,
  /// because it should already be requested by the TextFieldData.
  PersistedTextField.fromTextFieldData({
    required TextFieldData textFieldData,
    required this.saveTriggerNotifier,
    String? persistenceId,
    String? labelText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization? textCapitalization,
    this.prefillWithFavorite = false,
    this.onScanPressed,
    this.dropdownBackgroundColor = Colors.white,
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
    this.scribbleEnabled = true,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.spellCheckConfiguration,
    this.undoController,
    this.persistentCubit,
    this.cursorErrorColor,
    this.ignorePointers,
    this.onTapAlwaysCalled = false,
    this.onTapUpOutside,
    this.statesController,
    super.key,
  }) : persistenceId =
           persistenceId ??
           textFieldData.persistenceId ??
           labelText ??
           decoration?.labelText ??
           textFieldData.labelText,
       labelText = labelText ?? textFieldData.labelText,
       controller = controller ?? textFieldData.controller,
       validator = validator ?? textFieldData.validator,
       autovalidateMode = autovalidateMode ?? textFieldData.autovalidateMode,
       keyboardType = keyboardType ?? textFieldData.keyboardType,
       inputFormatters = inputFormatters ?? textFieldData.inputFormatters,
       textCapitalization =
           textCapitalization ?? textFieldData.textCapitalization;

  /// Label of the [BasfTextField]
  final String? labelText;

  /// Cubit to work with persistent state from outside,
  /// if not provided will be auto-created
  final PersistedInputCubit? persistentCubit;

  /// Color of suggestions dropdown
  final Color dropdownBackgroundColor;

  /// Id for unique bloc cache
  final String persistenceId;

  /// You provide a bool notifier, when it changes to true or false,
  /// save value is triggered
  final ValueNotifier<bool> saveTriggerNotifier;

  /// If provided, a scan icon is shown if the BasfTextField is empty
  final VoidCallback? onScanPressed;

  /// Text field controller
  final TextEditingController controller;

  /// Input decoration
  final InputDecoration? decoration;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text capitalization
  final TextCapitalization textCapitalization;

  /// Prefill controller text to favorite value
  /// This can be used to e.g. only to it at the initial state
  final bool prefillWithFavorite;

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

  /// Scribble enabled
  final bool scribbleEnabled;

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
  State<PersistedTextField> createState() => _PersistedTextFieldState();
}

class _PersistedTextFieldState extends State<PersistedTextField> {
  final GlobalKey _textFieldKey = GlobalKey();
  final GlobalKey _futureBuilderKey = GlobalKey();
  late final FocusNode _focusNode;
  late final Future<bool> _initStorage;
  final ValueNotifier<String> textNotifier = ValueNotifier('');
  final ValueNotifier<bool> overlayShownNotifier = ValueNotifier(false);

  @override
  void initState() {
    _initStorage = _initHydratedStorage();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.saveTriggerNotifier.addListener(saveValue);
    widget.controller.addListener(textControllerListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setFavoriteValueAsDefault();
    });
    super.initState();
  }

  void textControllerListener() => textNotifier.value = widget.controller.text;

  Future<void> setFavoriteValueAsDefault() async {
    if (!widget.prefillWithFavorite) return;
    await _initHydratedStorage().then((value) {
      final cubit =
          _futureBuilderKey.currentContext!.read<PersistedInputCubit>();

      if (cubit.state.favoriteValue != null && widget.controller.text.isEmpty) {
        widget.controller.text = cubit.state.favoriteValue!;
        textNotifier.value = widget.controller.text;
      }
    });
  }

  void saveValue() {
    if (widget.controller.text.trim().isNotEmpty) {
      _textFieldKey.currentContext?.read<PersistedInputCubit>().addValue(
        widget.controller.text,
      );
    }
    if (_focusNode.hasFocus) _focusNode.unfocus();
  }

  Future<bool> _initHydratedStorage() async {
    try {
      // if storage could have been accessed, then it is already initialized
      // and no action is needed
      HydratedBloc.storage.toString();
    } catch (e) {
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory:
            kIsWeb
                ? HydratedStorageDirectory.web
                : HydratedStorageDirectory(
                  (await getTemporaryDirectory()).path,
                ),
      );
    }

    return true;
  }

  void _handleFocusChange() {
    _focusNode.hasFocus ? _showOverlay() : _removeOverlay();
  }

  void _removeOverlay() => overlayShownNotifier.value = false;

  void _showOverlay() => overlayShownNotifier.value = true;

  @override
  Widget build(BuildContext context) {
    if (widget.persistentCubit != null) {
      return BlocProvider.value(value: widget.persistentCubit!, child: body());
    } else {
      return BlocProvider(
        create: (context) => PersistedInputCubit(id: widget.persistenceId),
        child: body(),
      );
    }
  }

  Widget body() {
    return FutureBuilder<bool>(
      key: _futureBuilderKey,
      future: _initStorage,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        return ValueListenableBuilder<bool>(
          valueListenable: overlayShownNotifier,
          builder: (context, overlayShown, _) {
            final cubit = context.read<PersistedInputCubit>();
            return Column(
              children: [
                textField(context),
                Fade(
                  duration: const Duration(milliseconds: 150),
                  visible: overlayShown && cubit.valuesExist,
                  child: completeBottomOverlay(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget completeBottomOverlay() {
    return FutureBuilder<({double width, double height})>(
      future: Future.delayed(Duration.zero, () {
        return (
          width: _textFieldKey.currentContext?.size?.width ?? double.infinity,
          height: _textFieldKey.currentContext?.size?.height ?? 50,
        );
      }),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        return overlayContainer(snapshot.data!.width, context);
      },
    );
  }

  Widget overlayContainer(double width, BuildContext context) {
    final cubit = context.read<PersistedInputCubit>();

    return ValueListenableBuilder(
      valueListenable: textNotifier,
      builder: (context, text, _) {
        final showFavorite =
            cubit.state.favoriteValue != null &&
            cubit.state.favoriteValue!.contains(text);

        final lastValues =
            cubit.state.lastValues
                .where((value) => value.contains(text))
                .toList();

        if (!showFavorite && lastValues.isEmpty) return const SizedBox();

        return Container(
          width: width,
          margin: const EdgeInsets.only(bottom: 10),
          child: Material(
            color: widget.dropdownBackgroundColor,
            elevation: 4,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                if (showFavorite)
                  favoriteItem(context, cubit.state.favoriteValue!),
                if (lastValues.isNotEmpty)
                  lastValuesList(
                    context: context,
                    favoriteExists: showFavorite,
                    lastValues: lastValues,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget favoriteItem(BuildContext context, String favoriteValue) {
    return item(context: context, value: favoriteValue, isFavorite: true);
  }

  Widget lastValuesList({
    required bool favoriteExists,
    required List<String> lastValues,
    required BuildContext context,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (favoriteExists) separator(context: context, isFavorite: true),
        ...List.generate(lastValues.length, (index) {
          return item(context: context, value: lastValues[index]);
        }).joinWithSeparator(separator(context: context, isFavorite: false)),
      ],
    );
  }

  Widget item({
    required BuildContext context,
    required String value,
    bool isFavorite = false,
  }) {
    return ListTile(
      title: Text(value),
      contentPadding: const EdgeInsets.only(left: 15),
      onLongPress: () {
        if (!isFavorite) {
          context.read<PersistedInputCubit>().deleteValue(value);
          _removeOverlay();
          _showOverlay();
        }
      },
      onTap: () => widget.controller.text = value,
      trailing: bookmarkIcon(
        context: context,
        value: value,
        isFavorite: isFavorite,
      ),
    );
  }

  Widget bookmarkIcon({
    required BuildContext context,
    required String value,
    required bool isFavorite,
  }) {
    return IconButton(
      icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_add_outlined),
      color: Theme.of(context).primaryColor,
      onPressed: () {
        if (!isFavorite) widget.controller.text = value;
        context.read<PersistedInputCubit>().setFavoriteValue(value);
        _removeOverlay();
        _showOverlay();
      },
    );
  }

  Widget separator({required BuildContext context, required bool isFavorite}) {
    return Container(
      height: 1,
      color:
          isFavorite
              ? Theme.of(context).primaryColor
              : Theme.of(context).splashColor,
    );
  }

  Widget textField(BuildContext context) {
    return BasfTextField(
      labelText: widget.labelText,
      key: _textFieldKey,
      focusNode: _focusNode,
      controller: widget.controller,
      onScanPressed: widget.onScanPressed,
      decoration: widget.decoration,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      contextMenuBuilder: widget.contextMenuBuilder,
      mouseCursor: widget.mouseCursor,
      onTapOutside: widget.onTapOutside,
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
        _showOverlay();
      },
      onTap: () {
        widget.onTap?.call();
        _showOverlay();
      },
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
      canRequestFocus: widget.canRequestFocus,
      clipBehavior: widget.clipBehavior,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
      cursorOpacityAnimates: widget.cursorOpacityAnimates,
      dragStartBehavior: widget.dragStartBehavior,
      magnifierConfiguration: widget.magnifierConfiguration,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      onSubmitted: widget.onSubmitted,
      stylusHandwritingEnabled: widget.scribbleEnabled,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      spellCheckConfiguration: widget.spellCheckConfiguration,
      undoController: widget.undoController,
      onEditingComplete: widget.onEditingComplete,
      cursorErrorColor: widget.cursorErrorColor,
      ignorePointers: widget.ignorePointers,
      onTapAlwaysCalled: widget.onTapAlwaysCalled,
      onTapUpOutside: widget.onTapUpOutside,
      statesController: widget.statesController,
    );
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    widget.saveTriggerNotifier.removeListener(saveValue);
    widget.controller.removeListener(textControllerListener);
    _removeOverlay();
    textNotifier.dispose();
    overlayShownNotifier.dispose();
    super.dispose();
  }
}
