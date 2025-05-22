import 'package:basf_flutter_components/src/theme/dimens.dart';
import 'package:basf_flutter_components/src/theme/paddings.dart';
import 'package:basf_flutter_components/src/widgets/modals/modal_header.dart';
import 'package:basf_flutter_components/src/widgets/spacers.dart';
import 'package:flutter/material.dart';

/// Modal body
class ModalBody extends StatelessWidget {
  /// Modal body
  const ModalBody({
    required this.bodyWidgets,
    this.title,
    this.description,
    this.bottomButton,
    this.actions,
    this.titleIcon,
    this.showCloseButton = true,
    this.noSafeArea = false,
    this.bodyPadding,
    super.key,
  });

  ///
  final String? title;

  ///
  final String? description;

  ///
  final List<Widget> bodyWidgets;

  ///
  final List<Widget>? actions;

  ///
  final Widget? bottomButton;

  ///
  final Widget? titleIcon;

  ///
  final bool showCloseButton;

  ///
  final bool noSafeArea;

  ///
  final EdgeInsetsGeometry? bodyPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final focus = FocusScope.of(context);
        if (focus.hasFocus) {
          focus.unfocus();
        }
      },
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SafeArea(
          minimum: noSafeArea
              ? EdgeInsets.zero
              : const EdgeInsets.only(bottom: Dimens.paddingMedium20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Padding(
                  padding: _headerPadding,
                  child: ModalHeader(
                    title: title!,
                    icon: titleIcon,
                    actions: actions,
                    showCloseButton: showCloseButton,
                  ),
                ),
              if (description != null)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                    left: _horizontalPadding.horizontal / 2,
                    right: _horizontalPadding.horizontal / 2,
                  ),
                  child: Text(description!),
                ),
              Flexible(child: body()),
              if (bottomButton != null) VerticalSpacer.medium20(),
              if (bottomButton != null)
                Padding(padding: _horizontalPadding, child: bottomButton),
            ],
          ),
        ),
      ),
    );
  }

  /// body
  Widget body() {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: bodyPadding ?? _horizontalPadding,
      children: bodyWidgets,
    );
  }

  /// Horizontal padding
  EdgeInsetsGeometry get _horizontalPadding => EdgeInsets.symmetric(
    horizontal: Paddings.defaultScreenPadding.horizontal / 2,
  );

  ///
  EdgeInsetsGeometry get _headerPadding {
    return Paddings.defaultScreenPadding.subtract(
      const EdgeInsets.only(
        top: Dimens.paddingMediumSmall,
        right: Dimens.paddingMedium - 1,
      ),
    );
  }
}
