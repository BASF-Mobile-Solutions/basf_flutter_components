import 'package:basf_flutter_components/src/theme/colors.dart' show BasfColors;
import 'package:basf_flutter_components/src/theme/themes.dart' show BasfThemes;
import 'package:flutter/material.dart';

/// Show modal sheet
Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  double ratio = 0.8,
  BoxConstraints? constraints,
  bool isDismissible = true,
  Color backgroundColor = BasfColors.backgroundGrey,
}) {
  return showModalBottomSheet(
    elevation: 0,
    backgroundColor: backgroundColor,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    showDragHandle: isDismissible,
    barrierColor: Colors.black54,
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
