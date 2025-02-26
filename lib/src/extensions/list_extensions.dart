import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// A collection of usefull extensions on [List<Widget>]
extension JoinedWidgets on List<Widget> {
  /// Adds a specific type of [Widget] in between a list of Widgets
  /// This can be usefull to add some height in between Widgets
  /// without the need of writing it multiple times
  ///
  /// Example:
  /// ```dart
  /// [
  ///  const Text('BASF'),
  ///  const Text('MOBILE SOLUTIONS'),
  /// ].joinWithSeparator(const SizedBox(height: 10));
  /// ```
  List<Widget> joinWithSeparator(Widget separator) {
    return length > 1
        ? (take(length - 1)
            .map((widget) => [widget, separator])
            .expand((widget) => widget)
            .toList()
          ..add(last))
        : this;
  }

  /// Adds the same ammount of padding to a list of Widgets
  /// This can be usefull if you need to have some of the widgets of a list
  /// spaced, and some don't
  ///
  /// Example:
  /// ```dart
  /// [
  ///   const Text('BASF'),
  ///   const Text('MOBILE SOLUTIONS'),
  /// ].spaced();
  /// // or
  /// ].spaced(padding: const EdgeInsets.all(10));
  /// ```
  List<Widget> spaced({EdgeInsetsGeometry? padding, bool excludeFlex = true}) {
    final spacedWidgets = <Widget>[];
    for (final w in this) {
      if (excludeFlex && (w is Expanded || w is Spacer || w is Flexible)) {
        spacedWidgets.add(w);
      } else {
        spacedWidgets.add(
          Padding(
            padding:
                padding ??
                const EdgeInsets.fromLTRB(
                  Dimens.paddingMediumLarge,
                  0,
                  Dimens.paddingMediumLarge,
                  0,
                ),
            child: w,
          ),
        );
      }
    }
    return spacedWidgets;
  }
}
