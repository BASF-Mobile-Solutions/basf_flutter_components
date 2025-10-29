import 'dart:async';

import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Single item
class SingleItem extends StatefulWidget {
  ///
  const SingleItem({
    required this.title,
    required this.value,
    this.blockCopy = false,
    this.color,
    this.isLink = false,
    this.isClickable = true,
    super.key,
  });

  /// Item title
  final String title;

  /// Item value
  final String value;

  /// Item color
  final Color? color;

  /// Whether or not it will block the copy functionality
  final bool blockCopy;

  /// Whether or not the item is a link
  final bool isLink;

  /// Whether or not the item is clickable
  final bool isClickable;

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  bool copyIconIsVisible = false;
  bool get availableToCopy =>
      !widget.blockCopy &&
      widget.value.trim().isNotEmpty &&
      widget.value != '-';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isClickable
          ? widget.isLink
                ? _launchURL
                : availableToCopy
                ? copyOrderNumber
                : null
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title(context),
            VerticalSpacer.small(),
            Text(
              widget.value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: widget.color,
                fontSize: widget.isLink ? 12 : null,
                decoration: widget.isLink ? TextDecoration.underline : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            widget.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        if (widget.isLink)
          const Padding(
            padding: EdgeInsets.only(
              top: 3.5,
              left: Dimens.paddingDefault,
            ),
            child: Icon(Icons.link, size: 14),
          )
        else if (availableToCopy && widget.isClickable)
          Padding(
            padding: EdgeInsets.only(
              top: copyIconIsVisible ? 3.5 : 5.5,
              left: Dimens.paddingDefault,
            ),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              firstChild: const Icon(Icons.copy, size: 10),
              secondChild: const Icon(Icons.done, size: 14),
              crossFadeState: copyIconIsVisible
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
          ),
      ],
    );
  }

  void copyOrderNumber() {
    unawaited(Clipboard.setData(ClipboardData(text: widget.value)));

    if (!copyIconIsVisible) {
      setState(() {
        copyIconIsVisible = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            copyIconIsVisible = false;
          });
        }
      });
    }
  }

  Future<void> _launchURL() async {
    final uri = Uri.parse(widget.value);
    try {
      await Clipboard.setData(ClipboardData(text: widget.value));
      await launchUrl(uri);
    } on PlatformException catch (_) {}
  }
}
