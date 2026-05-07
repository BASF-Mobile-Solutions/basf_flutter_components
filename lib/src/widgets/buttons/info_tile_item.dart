import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    if (widget.textFieldData.persistenceId == 'quantity' &&
        widget.textFieldData.controller.text.isEmpty) {
      widget.textFieldData.controller.text = _formattedZeroQuantity();
    }
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

  String _formattedZeroQuantity() {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    final formattedString = NumberFormat(
      '#,##0.000',
      Intl.canonicalizedLocale(locale.toLanguageTag()),
    ).format(0.0);

    // Strip locale-specific separators that break later parsing in inputs.
    return formattedString.replaceAll(RegExp(r'[\u00A0\u202f\u2019]'), '');
  }

  @override
  Widget build(BuildContext context) {
    return LabeledWidget(
      labelText: widget.textFieldData.labelText,
      child: textField(),
    );
  }

  Widget textField() {
    return ValueListenableBuilder<String>(
      valueListenable: textNotifier..value = widget.textFieldData.controller.text,
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
