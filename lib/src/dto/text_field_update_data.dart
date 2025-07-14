import 'package:flutter/material.dart';

/// TextFieldUpdateData
class TextFieldUpdateData {
  /// Container
  const TextFieldUpdateData({
    required this.controller,
    required this.notifier,
  });

  /// [TextEditingController]
  final TextEditingController controller;

  /// [ValueNotifier] of [bool]
  final ValueNotifier<bool> notifier;
}
