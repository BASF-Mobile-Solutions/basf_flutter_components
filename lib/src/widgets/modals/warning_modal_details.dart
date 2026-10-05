import 'dart:async';

import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/modals/warning_modal_json_view.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

/// Additional information of a [WarningModalLayout] — technical texts such as
/// the raw backend answer — in a soft green block.
///
/// Collapsed by default. JSON is laid out for reading, see
/// [WarningModalJsonView]; the copy button copies the full JSON, pretty
/// printed, so nothing gets lost on the way to support.
class WarningModalDetails extends StatefulWidget {
  /// Creates the collapsible details block for [details].
  const WarningModalDetails({required this.details, super.key});

  /// Texts to show, one paragraph each.
  final List<String> details;

  @override
  State<WarningModalDetails> createState() => _WarningModalDetailsState();
}

class _WarningModalDetailsState extends State<WarningModalDetails> {
  static final Animatable<double> _halfTurn = Tween<double>(begin: 0, end: 0.5);
  static final Color _tint = BasfColors.darkGreen.withValues(alpha: 0.05);
  static final Color _textColor = BasfColors.copyTextGrey.withValues(alpha: 0.85);

  final ExpansibleController _controller = ExpansibleController();
  Timer? _copiedTimer;
  bool _copied = false;

  late final String _copyText = widget.details.map((detail) => detail.toPrettyJson()).join('\n\n');

  late final List<Object?> _json = widget.details.map((detail) => detail.toJsonValue()).toList();

  @override
  void dispose() {
    _controller.dispose();
    _copiedTimer?.cancel();
    super.dispose();
  }

  Future<void> _copy() async {
    try {
      await Clipboard.setData(ClipboardData(text: _copyText));
    } on PlatformException {
      // The browser can refuse clipboard access; there is nothing to confirm.
      return;
    }
    if (!mounted) return;

    _copiedTimer?.cancel();
    setState(() => _copied = true);
    _copiedTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = BasfComponentsLocalizations.of(context);

    return ColoredBox(
      color: _tint,
      child: Expansible(
        controller: _controller,
        headerBuilder: (context, animation) => _header(localizations, animation),
        bodyBuilder: (context, animation) => _body(),
      ),
    );
  }

  Widget _header(BasfComponentsLocalizations localizations, Animation<double> animation) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: _controller.toggle,
        child: Padding(
          padding: const EdgeInsets.only(left: Dimens.paddingMedium, right: Dimens.paddingDefault),
          child: Row(
            children: [
              const Icon(Icons.code_rounded, size: 20, color: BasfColors.darkGreen),
              const SizedBox(width: Dimens.paddingMediumSmall),
              Expanded(
                child: Text(
                  _copied ? localizations.copiedToClipboard : localizations.generalDetails,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _copied ? BasfColors.darkGreen : BasfColors.copyTextGrey,
                  ),
                ),
              ),
              IconButton(
                tooltip: localizations.copy,
                onPressed: _copy,
                icon: Icon(
                  _copied ? Icons.check_rounded : Icons.copy_rounded,
                  size: 18,
                  color: BasfColors.darkGreen,
                ),
              ),
              RotationTransition(
                turns: animation.drive(_halfTurn),
                child: const Icon(Icons.keyboard_arrow_down_rounded, color: BasfColors.darkGreen),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(
          height: 1,
          thickness: 1,
          indent: Dimens.paddingMedium,
          endIndent: Dimens.paddingMedium,
          color: BasfColors.darkGreen.withValues(alpha: 0.12),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.paddingMedium,
            Dimens.paddingMediumSmall,
            Dimens.paddingMedium,
            Dimens.paddingMedium,
          ),
          child: SelectionArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (index, detail) in widget.details.indexed) ...[
                  if (index > 0) const SizedBox(height: Dimens.paddingMedium),
                  _detail(detail, _json[index]),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// JSON laid out for reading; any other text as it is.
  Widget _detail(String detail, Object? json) {
    if (json != null) return WarningModalJsonView(value: json);

    return Text(
      detail,
      style: TextStyle(
        fontFamily: 'Menlo',
        fontFamilyFallback: const ['Courier', 'monospace'],
        fontSize: 12.5,
        height: 1.5,
        color: _textColor,
      ),
    );
  }
}
