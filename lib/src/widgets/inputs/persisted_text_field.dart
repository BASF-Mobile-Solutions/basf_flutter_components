import 'dart:ui';

import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/inputs/logic/persisted_input_cubit.dart';
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
    required this.uniqueId,
    required this.controller,
    /// You provide a bool notifier, when it becomes true,
    /// save value is triggered
    required this.saveTriggerNotifier,
    this.dropdownBackgroundColor = Colors.white,
    this.formKey,
    this.initialValue,
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
    super.key,
  });

  /// Color of suggestions dropdown
  final Color dropdownBackgroundColor;

  /// Id for unique bloc cache
  final String uniqueId;

  /// You provide a bool notifier, when it changes to true or false,
  /// save value is triggered
  final ValueNotifier<bool> saveTriggerNotifier;

  /// Form key
  final GlobalKey<FormState>? formKey;

  /// Text field controller
  final TextEditingController controller;

  /// Initial value
  final String? initialValue;

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

  void textControllerListener() {
    textNotifier.value = widget.controller.text;
    _showOverlay();
  }

  Future<void> setFavoriteValueAsDefault() async {
    await _initHydratedStorage().then((value) {
      final cubit = _futureBuilderKey
          .currentContext!.read<PersistedInputCubit>();

      if (cubit.state.favoriteValue != null) {
        widget.controller.text = cubit.state.favoriteValue!;
        textNotifier.value = widget.controller.text;
      }
    });
  }

  void saveValue() {
    if (widget.controller.text.trim().isNotEmpty) {
      _textFieldKey.currentContext
          ?.read<PersistedInputCubit>().addValue(widget.controller.text);
    }
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  Future<bool> _initHydratedStorage() async {
    try {
      // if storage could have been accessed, then it is already initialized
      // and no action is needed
      HydratedBloc.storage.toString();
    } catch (e) {
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getApplicationDocumentsDirectory(),
      );
    }

    return true;
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    overlayShownNotifier.value = false;
  }

  void _showOverlay() {
    overlayShownNotifier.value = true;
  }

  void _selectItem(String value) {
    widget.controller.text = value;
    _removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersistedInputCubit(id: widget.uniqueId),
      child: FutureBuilder<bool>(
        key: _futureBuilderKey,
        future: _initStorage,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }

          return ValueListenableBuilder<bool>(
            valueListenable: overlayShownNotifier,
            builder: (context, overlayShown, _) {
              final cubit = context.read<PersistedInputCubit>();
              return Stack(
                children: [
                  textField(context),
                  if (overlayShown && cubit.valuesExist)
                    completeBottomOverlay(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget completeBottomOverlay() {
    return FutureBuilder<({double width, double height})>(
      future: Future.delayed(Duration.zero, () {
        return (
          width:
            _textFieldKey.currentContext?.size?.width ?? double.infinity,
          height: _textFieldKey.currentContext?.size?.height ?? 50,
        );
      }),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        return overlayContainer(
            snapshot.data!.width,
            snapshot.data!.height,
            context,
        );
      },
    );
  }

  Widget overlayContainer(double width, double height, BuildContext context) {
    final cubit = context.read<PersistedInputCubit>();

    return ValueListenableBuilder(
      valueListenable: textNotifier,
      builder: (context, text, _) {
        final showFavorite = cubit.state.favoriteValue != null
          && cubit.state.favoriteValue!.contains(text);

        final lastValues = cubit.state.lastValues
            .where((value) => value.contains(text),
        ).toList();

        if (!showFavorite && lastValues.isEmpty) {
          return const SizedBox();
        }

        return Container(
          width: width,
          margin: EdgeInsets.only(
            top: height,
          ),
          padding: const EdgeInsets.only(bottom: 10),
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
    return item(
      context: context,
      value: favoriteValue,
      isFavorite: true,
    );
  }

  Widget lastValuesList({
    required bool favoriteExists,
    required List<String> lastValues,
    required BuildContext context,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (favoriteExists)
          separator(context: context, isFavorite: true),
        ...List.generate(lastValues.length, (index) {
          return item(
            context: context,
            value: lastValues[index],
          );
        }).joinWithSeparator(
          separator(
            context: context,
            isFavorite: false,
          ),
        ),
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
      onTap: () {
        _selectItem(value);
      },
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
      icon: Icon(
        isFavorite ? Icons.bookmark : Icons.bookmark_add_outlined,
      ),
      color: Theme.of(context).primaryColor,
      onPressed: () {
        context.read<PersistedInputCubit>().setFavoriteValue(value);
        _removeOverlay();
        _showOverlay();
      },
    );
  }

  Widget separator({
    required BuildContext context,
    required bool isFavorite,
  }) {
    return Container(
      height: 1,
      color: isFavorite
          ? Theme.of(context).primaryColor
          : Theme.of(context).splashColor,
    );
  }

  Widget textField(BuildContext context) {
    return BasfTextField(
      key: _textFieldKey,
      formKey: widget.formKey,
      greyWhenDisabled: widget.greyWhenDisabled,
      focusNode: _focusNode,
      controller: widget.controller,
      initialValue: widget.initialValue,
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
      onChanged: widget.onChanged,
      onTap: () {
        widget.onTap?.call();
        _showOverlay();
      },
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
      canRequestFocus: widget.canRequestFocus,
      clipBehavior: widget.clipBehavior,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
      cursorOpacityAnimates: widget.cursorOpacityAnimates,
      dragStartBehavior: widget.dragStartBehavior,
      magnifierConfiguration: widget.magnifierConfiguration,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      onSubmitted: widget.onSubmitted,
      scribbleEnabled: widget.scribbleEnabled,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      spellCheckConfiguration: widget.spellCheckConfiguration,
      undoController: widget.undoController,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
