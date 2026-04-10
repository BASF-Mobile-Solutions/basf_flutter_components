import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Editable info tile
class EditableInfoTile extends StatelessWidget {
  ///
  const EditableInfoTile({
    required this.child,
    this.title,
    this.onClick,
    this.onDelete,
    this.icon,
    super.key,
  });

  ///
  EditableInfoTile.withInfoItemsRow({
    this.title,
    required List<Widget> items,
    this.onClick,
    this.onDelete,
    this.icon,
    super.key,
  }) : child = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: _getGridRows(items).joinWithSeparator(VerticalSpacer.normal()),
        );

  ///
  EditableInfoTile.withGridView({
    this.title,
    required List<Widget> items,
    this.onClick,
    this.onDelete,
    this.icon,
    super.key,
  }) : child = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: _getGridRows(items).joinWithSeparator(VerticalSpacer.normal()),
        );

  /// Callback to be called when the tile is clicked
  final VoidCallback? onClick;

  /// Callback to be called when the delete button is clicked
  final VoidCallback? onDelete;

  /// Title of the tile
  final String? title;

  /// Optional icon to be displayed on the right side of the tile
  final Widget? icon;

  /// Child widget to be displayed below the title
  final Widget child;

  static List<Widget> _getGridRows(List<Widget> items) {
    return items.slices(2).map((slice) {
      if (slice.length == 1) return slice.first;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: slice.first),
          Expanded(child: slice.last),
        ].joinWithSeparator(HorizontalSpacer.semi()),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final icons = [
      if (onDelete != null) deleteButton(),
      ?icon,
    ];

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [BasfShadows.smallShadow],
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: BasfColors.white,
              foregroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: onClick,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) tileTitle(context),
                  child,
                ].joinWithSeparator(VerticalSpacer.medium()),
              ),
            ),
          ),
        ),
        if (icons.isNotEmpty)
          Positioned(
            top: 4,
            right: 4,
            child: Row(children: icons),
          ),
      ],
    );
  }

  ///
  Widget tileTitle(BuildContext context) {
    return Text(
      title!,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  ///
  Widget deleteButton() {
    return IconButton(
      onPressed: onDelete,
      color: BasfColors.black,
      splashRadius: 22,
      icon: const Icon(Icons.delete),
    );
  }
}
