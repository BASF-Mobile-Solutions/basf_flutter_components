import 'dart:ui';

class BasfOption {
  String text;
  bool isSelected;
  String? subtitle;
  VoidCallback onChanged;

  BasfOption({
    required this.text,
    required this.onChanged,
    this.isSelected = false,
    this.subtitle,
  });
}
