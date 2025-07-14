import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This AppBar just allows us to reuse same style in the  app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a custom app bar.
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.previousScreenCall,
    this.backButtonIsVisibleNotifier, // required for back button
    this.bottom,
    this.showBackButton = true,
  });

  /// The title displayed in the app bar.
  final String? title;
  /// A list of Widgets to display in a row after the [title] widget.
  final List<Widget>? actions;
  /// A callback that is called when the back button is pressed.
  final VoidCallback? previousScreenCall;
  /// Back button visibility notifier
  final ValueNotifier<bool>? backButtonIsVisibleNotifier;
  /// This widget appears across the bottom of the app bar.
  final PreferredSizeWidget? bottom;
  /// Whether to show the back button. Defaults to true.
  final bool showBackButton;

  @override
  Size get preferredSize => Size(0,
      bottom == null ? kToolbarHeight : kToolbarHeight + 40);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: titleText(context),
      leading: showBackButton
          ? previousScreenCall != null && backButtonIsVisibleNotifier != null
            ? leadingIcon() : null
          : const SizedBox.shrink(),
      titleTextStyle: theme.textTheme.headlineSmall,
      iconTheme: IconThemeData(color: theme.appBarTheme.foregroundColor),
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      bottom: bottom,
    );
  }

  /// Leading Icon
  Widget leadingIcon() {
    return ValueListenableBuilder(
        valueListenable: backButtonIsVisibleNotifier!,
        builder: (context, isVisible, _) {
          return Visibility(
            visible: isVisible,
            child: _CustomLeadingIcon(previousScreenCall: previousScreenCall),
          );
        }
    );
  }

  /// Title text
  Widget? titleText(BuildContext context) {
    if (title != null) {
      return Text(
        title!,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height < 670 ? 16 : 20,
            fontWeight: FontWeight.w700,
        ),
      );
    }

    return null;
  }
}

class _CustomLeadingIcon extends StatelessWidget {
  const _CustomLeadingIcon({this.previousScreenCall});

  final VoidCallback? previousScreenCall;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => previousScreenCall!.call(),
      icon: Icon(Icons.adaptive.arrow_back),
    );
  }
}
