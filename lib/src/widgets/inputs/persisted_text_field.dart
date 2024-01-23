import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/inputs/logic/persisted_input_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    super.key,
  });

  /// Id for unique bloc cache
  final String uniqueId;

  /// Textfield for customization of parameters
  final TextEditingController controller;

  @override
  State<PersistedTextField> createState() => _PersistedTextFieldState();
}

class _PersistedTextFieldState extends State<PersistedTextField> {

  final GlobalKey _textFieldKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    initHydratedStorage();
    _focusNode.addListener(_handleFocusChange);
    super.initState();
  }

  Future<void> initHydratedStorage() async {
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
  }

  @override
  void dispose() {
    _focusNode..removeListener(_handleFocusChange)..dispose();
    _removeOverlay();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      return;
    }

    final renderBox = _textFieldKey.currentContext!
        .findRenderObject()! as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy + renderBox.size.height,
        width: renderBox.size.width,
        child: overlayBody(_textFieldKey.currentContext!),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _selectItem(String value) {
    widget.controller.text = value;
    _removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersistedInputCubit(id: widget.uniqueId),
      child: BasfTextField(
        key: _textFieldKey,
        focusNode: _focusNode,
        controller: widget.controller,
      ),
    );
  }

  Widget overlayBody(BuildContext context) {
    final cubit = context.read<PersistedInputCubit>();

    return Material(
      color: Colors.white,
      elevation: 4,
      child: Column(
        children: [
          if (cubit.state.favoriteValue != null)
            item(cubit.state.favoriteValue!),
          ...List.generate(cubit.state.lastValues.length,
                (index) => item(cubit.state.lastValues[index]),
          ),
        ],
      ),
    );
  }

  Widget item(String value) {
    return ListTile(
      onTap: () {
        _selectItem(value);
      },
    );
  }
}
