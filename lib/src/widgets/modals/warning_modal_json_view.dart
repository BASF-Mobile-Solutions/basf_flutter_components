import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:material_ui/material_ui.dart';

/// A decoded JSON value laid out for people rather than parsers: keys in
/// sentence case next to their values, nested objects as indented sections
/// after the plain fields, lists item by item. Empty values are left out.
class WarningModalJsonView extends StatelessWidget {
  /// Lays out [value], a decoded JSON object or array.
  const WarningModalJsonView({required this.value, super.key});

  /// The decoded JSON — a [Map] or a [List].
  final Object value;

  static const TextStyle _valueStyle = TextStyle(
    fontSize: 14,
    height: 1.4,
    color: BasfColors.copyTextGrey,
  );

  static final TextStyle _keyStyle = TextStyle(
    fontSize: 13,
    height: 1.5,
    color: BasfColors.copyTextGrey.withValues(alpha: 0.6),
  );

  static final Color _guideColor = BasfColors.darkGreen.withValues(alpha: 0.2);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _entries(value),
    );
  }

  List<Widget> _entries(Object? value) {
    if (value is Map) {
      final Iterable<MapEntry> entries = value.entries.where((entry) => !_isEmpty(entry.value));
      final List<MapEntry> fields = [
        for (final entry in entries)
          if (!_isNested(entry.value)) entry,
      ];

      // Plain fields first, in one table so their keys line up; the nested
      // objects follow as sections.
      return [
        if (fields.isNotEmpty) _fields(fields),
        for (final MapEntry(:key, :value) in entries)
          if (_isNested(value)) ...[
            _section('$key'.toSentenceCase()),
            _nested(_entries(value)),
          ],
      ];
    }

    if (value is List) {
      final List<Object?> items = value.where((item) => !_isEmpty(item)).toList();

      return [
        for (final (index, item) in items.indexed) ...[
          if (index > 0) const SizedBox(height: Dimens.paddingDefault),
          if (_isNested(item)) ..._entries(item) else _bullet('$item'),
        ],
      ];
    }

    return [_bullet('$value')];
  }

  /// Keys and values of plain fields; the key column is as wide as its widest
  /// key, but never more than 40 % of the width.
  Widget _fields(List<MapEntry> fields) {
    return Table(
      columnWidths: const {
        0: MinColumnWidth(IntrinsicColumnWidth(), FractionColumnWidth(0.4)),
        1: FlexColumnWidth(),
      },
      children: [
        for (final MapEntry(:key, :value) in fields)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Dimens.paddingMediumSmall, top: 3, bottom: 3),
                child: Text('$key'.toSentenceCase(), style: _keyStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text('$value', style: _valueStyle),
              ),
            ],
          ),
      ],
    );
  }

  Widget _bullet(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text('• $value', style: _valueStyle),
    );
  }

  Widget _section(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 2),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: BasfColors.copyTextGrey,
        ),
      ),
    );
  }

  /// The content of a section, indented behind a faint guide line.
  Widget _nested(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(left: 2, bottom: 2),
      padding: const EdgeInsets.only(left: Dimens.paddingMediumSmall),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: _guideColor, width: 1.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  static bool _isNested(Object? value) => value is Map || value is List;

  /// Nothing worth a line: no value, blank text or only empty values inside.
  static bool _isEmpty(Object? value) {
    if (value == null) return true;
    if (value is String) return value.trim().isEmpty;
    if (value is Map) return value.values.every(_isEmpty);
    if (value is List) return value.every(_isEmpty);

    return false;
  }
}
