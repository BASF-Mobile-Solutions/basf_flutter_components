import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

/// Double items row
class DoubleItemsRow extends StatelessWidget {
  ///
  const DoubleItemsRow({
    required this.titleOne,
    required this.valueOne,
    required this.titleTwo,
    required this.valueTwo,
    this.isLinkOne = false,
    this.isLinkTwo = false,
    this.isClickableOne = true,
    this.isClickableTwo = true,
    this.colorOne,
    this.colorTwo,
    super.key,
  });

  /// Title of the first item
  final String titleOne;
  /// Value of the first item
  final String valueOne;
  /// Title of the second item
  final String titleTwo;
  /// Value of the second item
  final String valueTwo;
  /// Color of the first item
  final Color? colorOne;
  /// Color of the second item
  final Color? colorTwo;
  /// If the first item is a link
  final bool isLinkOne;
  /// If the second item is a link
  final bool isLinkTwo;
  /// If the first item is clickable. Clicking on it opens the link in the
  /// browser if it's a link, otherwise it copies the value to the clipboard.
  /// Clicking can be disabled using this parameter.
  final bool isClickableOne;
  /// If the second item is clickable. Clicking on it opens the link in the
  /// browser if it's a link, otherwise it copies the value to the clipboard.
  /// Clicking can be disabled using this parameter.
  final bool isClickableTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleItem(
          title: titleOne,
          value: valueOne,
          color: colorOne,
          isLink: isLinkOne,
          isClickable: isClickableOne,
        ),
        SingleItem(
          title: titleTwo,
          value: valueTwo,
          color: colorTwo,
          isLink: isLinkTwo,
          isClickable: isClickableTwo,
        ),
      ].map((child) => Expanded(child: child)).toList()
          .joinWithSeparator(HorizontalSpacer.normal()),
    );
  }
}
