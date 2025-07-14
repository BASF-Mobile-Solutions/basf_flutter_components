import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Editable info tile
class EditableInfoTile extends StatelessWidget {
  ///
  const EditableInfoTile({
    required this.title,
    required this.child,
    this.onClick,
    this.onDelete,
    this.icon,
    super.key,
  });

  ///
  EditableInfoTile.withGridView({
    required this.title,
    required List<Widget> items,
    this.onClick,
    this.onDelete,
    this.icon,
    super.key,
  }) : child = Column(
    children: _getGridRows(items),
  );

  /// Callback to be called when the tile is clicked
  final VoidCallback? onClick;
  /// Callback to be called when the delete button is clicked
  final VoidCallback? onDelete;
  /// Title of the tile
  final String title;
  /// Optional icon to be displayed on the right side of the tile
  final Widget? icon;
  /// Child widget to be displayed below the title
  final Widget child;

  static List<Widget> _getGridRows(List<Widget> items) {
    return [
      for (int i = 0; i < items.length; i += 2)
        Row(
          children: [
            Expanded(child: items[i]),
            if (i + 1 < items.length)
              Expanded(child: items[i + 1]),
            if (i + 1 >= items.length)
              const Expanded(child: SizedBox()),
          ],
        ),
    ].joinWithSeparator(VerticalSpacer.semi());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [BasfShadows.smallShadow],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: BasfColors.white,
          foregroundColor: Theme.of(context).primaryColor,
        ),
        onPressed: onClick,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tileTitle(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onDelete != null) deleteButton(),
                    if (icon != null) icon!,
                  ],
                ),
              ],
            ),
            child,
          ].joinWithSeparator(VerticalSpacer.medium()),
        ),
      ),
    );
  }

  ///
  Widget tileTitle(BuildContext context) {
    return Text(title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  ///
  Widget deleteButton() {
    return IconButton(
      onPressed: onDelete,
      color: BasfColors.black,
      splashRadius: 22,
      icon: const Icon(Icons.delete_outlined),
    );
  }
}
