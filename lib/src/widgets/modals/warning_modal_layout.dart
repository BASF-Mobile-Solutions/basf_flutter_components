import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// Warning modal layout
class WarningModalLayout extends StatefulWidget {
  ///
  const WarningModalLayout({
    required this.warningMessage,
    this.additionalInfo,
    this.customButtonLabel,
    this.withRetryButton = false,
    this.isError = true,
    this.errorLocalization = 'Error',
    this.warningLocalization = 'Warning',
    this.showMoreLocalization = 'Show more',
    this.retryLocalization = 'Retry',
    this.closeLocalization = 'Close',
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

  /// Error text
  final String errorLocalization;

  /// Warning text
  final String warningLocalization;

  /// Show more
  final String showMoreLocalization;

  /// Retry
  final String retryLocalization;

  /// Close
  final String closeLocalization;

  @override
  State<WarningModalLayout> createState() => _WarningModalLayoutState();
}

class _WarningModalLayoutState extends State<WarningModalLayout> {
  bool showAdditionalInfo = false;
  bool showLine = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        minimum: const EdgeInsets.only(bottom: Dimens.paddingMedium20),
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
                    title: widget.isError
                        ? widget.errorLocalization
                        : widget.warningLocalization,
                    icon: emoji,
                    showCloseButton: false,
                  ),
                  Text(widget.warningMessage),
                  if (widget.additionalInfo?.isNotEmpty ?? false)
                    showMoreButton(),
                  if (widget.additionalInfo?.isNotEmpty ?? false)
                    additionalInfo(),
                ].joinWithSeparator(VerticalSpacer.medium()),
              ),
            ),
            if (widget.withRetryButton)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.paddingMedium20,
                ),
                child: retryButton(context),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.paddingMedium20,
              ),
              child: closeButton(context),
            ),
          ].joinWithSeparator(VerticalSpacer.medium()),
        ),
      ),
    );
  }

  Widget additionalInfo() {
    return Fade(
      visible: showAdditionalInfo,
      child: Column(
        children:
            widget.additionalInfo
                ?.map(Text.new)
                .toList()
                .joinWithSeparator(paddedDivider()) ??
            [],
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

  Widget showMoreButton() {
    final Widget showMoreButton = BasfTextButton.transparent(
      onPressed: () {
        setState(() => showAdditionalInfo = true);
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() => showLine = true);
        });
      },
      child: Text(widget.showMoreLocalization),
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
    return SizedBox(
      height: 32,
      width: 32,
      child: RiveAnimation.asset(
        artboard: RiveEmoji.surprise.artBoard,
        RiveEmoji.surprise.path,
      ),
    );
  }

  Widget retryButton(BuildContext context) {
    return BasfOutlinedButton(
      text: widget.retryLocalization,
      expanded: true,
      onPressed: () => Navigator.pop(context, true),
    );
  }

  Widget closeButton(BuildContext context) {
    return BasfTextButton.contained(
      text: widget.customButtonLabel ?? widget.closeLocalization,
      expanded: true,
      onPressed: () => Navigator.pop(context, false),
    );
  }
}
