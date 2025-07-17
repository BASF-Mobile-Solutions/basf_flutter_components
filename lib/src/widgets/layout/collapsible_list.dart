import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

///
class CollapsibleList extends StatefulWidget {
  ///
  const CollapsibleList({
    required this.collapsibleValues,
    required this.title,
    this.additionalAction,
    super.key,
  });

  ///
  final String title;

  ///
  final List<Widget> collapsibleValues;

  ///
  final VoidCallback? additionalAction;

  ///
  static List<Widget> innerCollapsibleList(List list, String text) {
    return list.mapIndexed((index, object) {
      // 1) grab the raw toJson() result…
      final raw = object.toJson();

      // 2) ensure it's a Map, casting away the `dynamic`
      if (raw is! Map) {
        throw ArgumentError('Expected toJson() to return a Map, got $raw');
      }
      final json = Map<String, dynamic>.from(raw);

      // 3) now you can safely do .entries.toList()
      final entries = json.entries.toList();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingXSmall),
        child: CollapsibleList(
          title: '$text #${index + 1}',
          collapsibleValues: info(entries).joinWithSeparator(
            const DottedSeparator(padding: EdgeInsets.symmetric(vertical: 8)),
          ),
        ),
      );
    }).toList();
  }

  ///
  static List<DoubleItemsRow> info(List<MapEntry<String, dynamic>> entries) {
    final doubleItemsRows = <DoubleItemsRow>[];

    for (var i = 0; i < entries.length; i += 2) {
      final titleOne = entries[i].key;
      final valueOne = entries[i].value.toString().unwrappedString;

      var titleTwo = '';
      var valueTwo = '';

      if (i + 1 < entries.length) {
        titleTwo = entries[i + 1].key;
        valueTwo = entries[i + 1].value.toString().unwrappedString;
      }

      doubleItemsRows.add(
        DoubleItemsRow(
          titleOne: titleOne,
          valueOne: valueOne,
          titleTwo: titleTwo,
          valueTwo: valueTwo,
        ),
      );
    }

    return doubleItemsRows;
  }

  @override
  State<CollapsibleList> createState() => _CollapsibleListState();
}

class _CollapsibleListState extends State<CollapsibleList> {
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Stack(
            children: [
              button(context),
              icon(context),
            ],
          ),
          children(),
        ],
      ),
    );
  }

  Widget button(BuildContext context) {
    return BasfTextButton.transparent(
      expanded: true,
      text: widget.title,
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.05),
      ),
      onPressed: widget.collapsibleValues.isNotEmpty ? onPressed : null,
    );
  }

  Widget icon(BuildContext context) {
    return Positioned(
      right: 15,
      bottom: 0,
      top: 0,
      child: AnimatedRotation(
        turns: isCollapsed ? 0 : -0.5,
        duration: const Duration(milliseconds: 200),
        child: Icon(
          Icons.arrow_drop_down_circle_outlined,
          size: 17,
          color: widget.collapsibleValues.isNotEmpty
              ? Theme.of(context).primaryColor
              : Theme.of(context).disabledColor,
        ),
      ),
    );
  }

  Widget children() {
    return Fade(
      visible: !isCollapsed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: widget.collapsibleValues,
        ),
      ),
    );
  }

  void onPressed() {
    setState(() {
      isCollapsed = !isCollapsed;
      if (!isCollapsed) {
        widget.additionalAction?.call();
      }
    });
  }
}
