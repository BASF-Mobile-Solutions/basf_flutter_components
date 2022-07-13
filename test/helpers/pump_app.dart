import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, [ThemeData? theme]) {
    return pumpWidget(
      MaterialApp(home: widget, theme: theme),
    );
  }
}
