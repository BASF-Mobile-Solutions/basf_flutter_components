import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template text_field_data}
/// Class representing data for a text field
/// Can be used to make text fields depending on same behavior
/// {@endtemplate}
class TextFieldData {
  /// Class representing data for a text field
  /// Can be used to make text fields depending on same behavior
  TextFieldData({
    required this.labelText,
    required this.controller,
    this.persistenceId,
    this.validator,
    this.autovalidateMode,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  /// Unique identifier for the text field, necessary for [PersistedTextField]
  final String? persistenceId;

  /// Label of the text field
  final String labelText;

  /// Controller for the text field
  final TextEditingController controller;

  /// Validator function for the text field
  final String? Function(String?)? validator;

  /// Autovalidate mode for the text field
  final AutovalidateMode? autovalidateMode;

  /// Keyboard type for the text field
  final TextInputType? keyboardType;

  /// Input formatters for the text field
  final List<TextInputFormatter>? inputFormatters;

  /// Text capitalization for the text field
  /// Default is [TextCapitalization.none]
  final TextCapitalization textCapitalization;
}
