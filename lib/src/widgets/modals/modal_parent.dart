import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Modal parent widget used as a default bottom-sheet shell.
class ModalParent extends StatelessWidget {
  /// Creates a modal parent.
  const ModalParent({
    required this.body,
    required this.title,
    this.titleIcon,
    this.bottomButton,
    this.defaultHorizontalPadding = true,
    this.floatingWidgets,
    this.actions,
    this.showCloseButton = true,
    super.key,
  });

  /// Optional title of the modal.
  final String? title;

  /// Optional title icon.
  final Widget? titleIcon;

  /// Main body content.
  final Widget body;

  /// Optional bottom button/content.
  final Widget? bottomButton;

  /// Optional floating widgets layered above content.
  final List<Widget>? floatingWidgets;

  /// Whether body and footer use the default horizontal padding.
  final bool defaultHorizontalPadding;

  /// Optional custom actions in the header.
  final List<Widget>? actions;

  /// Whether the close button is shown in the header.
  final bool showCloseButton;

  /// Maximum content height ratio of the screen.
  final double maxContentPercentHeight = 0.93;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Padding(
        padding: MediaQuery.viewPaddingOf(context).bottom > 0
            ? MediaQuery.viewInsetsOf(context)
            : MediaQuery.viewInsetsOf(context).copyWith(
                bottom: MediaQuery.viewInsetsOf(context).bottom + Dimens.paddingMedium,
              ),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            maintainBottomViewPadding: true,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * maxContentPercentHeight,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (title != null)
                          ModalHeader(
                            title: title!,
                            icon: titleIcon,
                            actions: actions,
                            showCloseButton: showCloseButton,
                          ),
                        if (defaultHorizontalPadding)
                          Padding(
                            padding: _horizontalPadding,
                            child: _mainSection(),
                          )
                        else
                          _mainSection(),
                      ],
                    ),
                  ),
                  ...?floatingWidgets,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mainSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        body,
        ?bottomButton,
      ].joinWithSeparator(VerticalSpacer.medium20()),
    );
  }

  EdgeInsetsGeometry get _horizontalPadding => EdgeInsets.symmetric(
    horizontal: Paddings.defaultScreenPadding.horizontal / 2,
  );
}

/// Variant of [ModalParent] for scrollable body children.
class ModalParentForScrollableChild extends ModalParent {
  /// Creates a scrollable modal parent.
  const ModalParentForScrollableChild({
    required super.body,
    required super.title,
    super.titleIcon,
    super.bottomButton,
    super.defaultHorizontalPadding = true,
    super.floatingWidgets,
    super.actions,
    super.showCloseButton = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            ModalHeader(
              title: title!,
              icon: titleIcon,
              actions: actions,
              showCloseButton: showCloseButton,
            ),
          Flexible(
            child: defaultHorizontalPadding
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Paddings.defaultScreenPadding.horizontal / 2,
                    ),
                    child: body,
                  )
                : body,
          ),
          if (bottomButton != null)
            defaultHorizontalPadding
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Paddings.defaultScreenPadding.horizontal / 2,
                    ),
                    child: bottomButton!,
                  )
                : bottomButton!,
        ],
      ),
    );
  }
}
