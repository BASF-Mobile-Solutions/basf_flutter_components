import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/src/widgets/modals/warning_modal_details.dart';
import 'package:material_ui/material_ui.dart';

/// Warning modal layout
///
/// The title with the surprised emoji, the message below it and, collapsed
/// under the message, the [additionalInfo] — technical texts that can be
/// expanded and copied. Pops `true` when the user chooses to retry.
///
/// ```dart
/// showCustomModalBottomSheet<bool>(
///   context: context,
///   builder: (context) => const WarningModalLayout(
///     warningMessage: 'Purchase order 4711 not found',
///     additionalInfo: ['{"status": 500}'],
///     withRetryButton: true,
///   ),
/// );
/// ```
class WarningModalLayout extends StatelessWidget {
  ///
  const WarningModalLayout({
    required this.warningMessage,
    this.additionalInfo,
    this.customButtonLabel,
    this.withRetryButton = false,
    this.isError = true,
    this.additionalWidget,
    super.key,
  });

  /// Message to show
  final String warningMessage;

  /// Additional information to show after expanding
  final List<String>? additionalInfo;

  /// Custom label for close button
  final String? customButtonLabel;

  /// If modal will show a retry button
  final bool withRetryButton;

  /// If message is an error or a warning
  final bool isError;

  /// Optional custom widget displayed above the action buttons.
  final Widget? additionalWidget;

  static const double _margin = Dimens.paddingMediumLarge;

  /// Softer than the title, still well above the contrast minimum.
  static final Color _messageColor = BasfColors.copyTextGrey.withValues(alpha: 0.85);

  @override
  Widget build(BuildContext context) {
    final localizations = BasfComponentsLocalizations.of(context);
    final List<String> details = additionalInfo ?? const [];

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          minimum: const EdgeInsets.only(bottom: Dimens.paddingMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  // Without the details block the message gets more room before
                  // the buttons, so it does not sit right on top of them.
                  padding: EdgeInsets.fromLTRB(
                    _margin,
                    28,
                    _margin,
                    details.isEmpty ? Dimens.paddingMediumLarge : Dimens.paddingMedium,
                  ),
                  children: [
                    // Read out by screen readers as soon as the modal opens.
                    Semantics(
                      liveRegion: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(localizations),
                          const SizedBox(height: 4),
                          message(),
                        ],
                      ),
                    ),
                    if (details.isNotEmpty) ...[
                      const SizedBox(height: Dimens.paddingMedium),
                      WarningModalDetails(details: details),
                    ],
                  ],
                ),
              ),
              actions(context, localizations),
            ],
          ),
        ),
      ),
    );
  }

  /// Title of the modal followed by the surprised emoji.
  Widget title(BasfComponentsLocalizations localizations) {
    return Row(
      children: [
        Flexible(
          child: Text(
            isError ? localizations.error : localizations.warning,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: BasfColors.copyTextGrey,
            ),
          ),
        ),
        // The animation has its own transparent margin, hence the small gap.
        const SizedBox(width: 2),
        const RiveEmojiIcon(emoji: RiveEmoji.surprise, size: 34),
      ],
    );
  }

  /// The [warningMessage], selectable so it can be copied.
  Widget message() {
    return SelectableText(
      warningMessage,
      style: TextStyle(fontSize: 15, height: 1.4, color: _messageColor),
    );
  }

  /// The [additionalWidget] and the buttons, below the scrollable content.
  Widget actions(BuildContext context, BasfComponentsLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(_margin, Dimens.paddingDefault, _margin, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (additionalWidget != null) ...[
            additionalWidget!,
            const SizedBox(height: Dimens.paddingMediumSmall),
          ],
          if (withRetryButton) ...[
            retryButton(context, localizations),
            const SizedBox(height: 10),
          ],
          closeButton(context, localizations),
        ],
      ),
    );
  }

  /// Button that closes the modal with `true`.
  Widget retryButton(BuildContext context, BasfComponentsLocalizations localizations) {
    return BasfOutlinedButton(
      text: localizations.retry,
      expanded: true,
      onPressed: () => Navigator.pop(context, true),
    );
  }

  /// Button that closes the modal with `false`.
  Widget closeButton(BuildContext context, BasfComponentsLocalizations localizations) {
    return BasfTextButton.contained(
      text: customButtonLabel ?? localizations.close,
      expanded: true,
      onPressed: () => Navigator.pop(context, false),
    );
  }
}
