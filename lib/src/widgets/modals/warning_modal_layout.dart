import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Warning modal layout
class WarningModalLayout extends StatefulWidget {
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

  @override
  State<WarningModalLayout> createState() => _WarningModalLayoutState();
}

class _WarningModalLayoutState extends State<WarningModalLayout> {
  bool showAdditionalInfo = false;
  bool showLine = false;

  @override
  Widget build(BuildContext context) {
    final localizations = BasfComponentsLocalizations.of(context);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        minimum: const EdgeInsets.only(bottom: Dimens.paddingMedium20),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: Paddings.defaultScreenPadding,
                  children: [
                    ModalHeader(
                      title: widget.isError ? localizations.error : localizations.warning,
                      icon: emoji,
                      showCloseButton: false,
                    ),
                    Text(widget.warningMessage),
                    if (widget.additionalInfo?.isNotEmpty ?? false) showMoreButton(localizations),
                    if (widget.additionalInfo?.isNotEmpty ?? false) additionalInfo(),
                  ].joinWithSeparator(VerticalSpacer.medium()),
                ),
              ),
              if (widget.additionalWidget != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium20),
                  child: widget.additionalWidget!,
                ),
              if (widget.withRetryButton)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium20),
                  child: retryButton(context, localizations),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium20),
                child: closeButton(context, localizations),
              ),
            ].joinWithSeparator(VerticalSpacer.medium()),
          ),
        ),
      ),
    );
  }

  Widget additionalInfo() {
    return Fade(
      visible: showAdditionalInfo,
      child: Column(
        children:
            widget.additionalInfo?.map(Text.new).toList().joinWithSeparator(paddedDivider()) ?? [],
      ),
    );
  }

  Widget paddedDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimens.paddingMedium,
      ),
      child: AppDivider.thick(),
    );
  }

  Widget showMoreButton(BasfComponentsLocalizations localizations) {
    final Widget showMoreButton = BasfTextButton.transparent(
      onPressed: () {
        setState(() => showAdditionalInfo = true);
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() => showLine = true);
        });
      },
      child: Text(localizations.showMorePhrase),
    );

    return Fade(
      visible: !showAdditionalInfo || showLine,
      duration: const Duration(milliseconds: 250),
      child: AnimatedScale(
        scale: showAdditionalInfo && !showLine ? 0 : 1,
        duration: const Duration(milliseconds: 200),
        child: showLine ? const AppDivider.thick() : showMoreButton,
      ),
    );
  }

  Widget get emoji {
    return const RiveEmojiIcon(
      emoji: RiveEmoji.surprise,
      size: 32,
    );
  }

  Widget retryButton(
    BuildContext context,
    BasfComponentsLocalizations localizations,
  ) {
    return BasfOutlinedButton(
      text: localizations.retry,
      expanded: true,
      onPressed: () => Navigator.pop(context, true),
    );
  }

  Widget closeButton(
    BuildContext context,
    BasfComponentsLocalizations localizations,
  ) {
    return BasfTextButton.contained(
      text: widget.customButtonLabel ?? localizations.close,
      expanded: true,
      onPressed: () => Navigator.pop(context, false),
    );
  }
}
