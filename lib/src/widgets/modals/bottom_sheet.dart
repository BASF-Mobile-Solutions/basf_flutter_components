import 'package:basf_flutter_components/src/theme/themes.dart' show BasfThemes;
import 'package:flutter/material.dart';

/// Show modal sheet
Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  double ratio = 0.9,
  BoxConstraints? constraints,
  bool isDismissible = true,
  bool showDragHandle = false,
  bool? enableDrag,
  Color? backgroundColor,
  Color? barrierColor,
  double? elevation,
}) {
  return showModalBottomSheet(
    elevation: elevation,
    backgroundColor: backgroundColor,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag ?? isDismissible,
    showDragHandle: showDragHandle,
    barrierColor: barrierColor,
    constraints:
        constraints ??
        BoxConstraints(
          maxWidth: 500,
          maxHeight: MediaQuery.of(context).size.height * ratio,
        ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(BasfThemes.defaultBorderRadius.topLeft.y),
        topRight: Radius.circular(BasfThemes.defaultBorderRadius.topRight.y),
      ),
    ),
    context: context,
    builder: builder,
  );
}
