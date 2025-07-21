import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// info tile
class InfoTileItem extends StatefulWidget {
  /// constructor
  const InfoTileItem({
    required this.textFieldData,
    super.key,
  });

  /// text field data
  final TextFieldData textFieldData;

  @override
  State<InfoTileItem> createState() => _InfoTileItemState();
}

class _InfoTileItemState extends State<InfoTileItem> {
  late final ValueNotifier<String> textNotifier;

  @override
  void initState() {
    super.initState();
    textNotifier = ValueNotifier(widget.textFieldData.controller.text);
    widget.textFieldData.controller.addListener(changeText);
  }

  @override
  void dispose() {
    widget.textFieldData.controller.removeListener(changeText);
    super.dispose();
  }

  void changeText() {
    textNotifier.value = widget.textFieldData.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textFieldData.labelText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        VerticalSpacer.small(),
        textField(),
        // valueText(widget.textFieldData.value),
      ],
    );
  }

  Widget textField() {
    return ValueListenableBuilder<String>(
      valueListenable: textNotifier
        ..value = widget.textFieldData.controller.text,
      builder: (context, value, _) {
        return valueText(value);
      },
    );
  }

  Widget valueText(String text) {
    return Text(
      text.isEmpty || text == 'null' ? '-' : text,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: BasfColors.darkGrey,
      ),
    );
  }
}
