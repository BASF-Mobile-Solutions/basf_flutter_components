import 'package:basf_flutter_components/src/theme/colors.dart';
import 'package:basf_flutter_components/src/widgets/layout/custom_appbar.dart';
import 'package:flutter/material.dart';

/// Scaffold with custom appbar
class CustomScaffold extends StatelessWidget {
  /// Scaffold with custom appbar
  const CustomScaffold({
    required this.child,
    required this.title,
    this.backCallback,
    this.resizeToAvoidBottomInset = true,
    this.bottomNavigationBar,
    this.actions,
    this.showBackButton = true,
    this.showAppBar = true,
    this.maxWidth = 500,
    super.key,
  });

  /// Scaffold title
  final String title;

  /// Callback to be called when the back button is pressed
  final VoidCallback? backCallback;

  /// Scaffold body
  final Widget child;

  /// Whether the body should resize to avoid bottom insets
  final bool resizeToAvoidBottomInset;

  /// Scaffold bottom navigation bar
  final Widget? bottomNavigationBar;

  /// Scaffold appbar actions
  final List<Widget>? actions;

  /// Whether to show the back button or not
  final bool showBackButton;

  /// Whether to show the appbar or not
  final bool showAppBar;

  /// Optional max width for the scaffold content (app bar, body, bottom bar)
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: BasfColors.backgroundGrey,
      appBar: showAppBar
          ? _wrapAppBar(
              CustomAppBar(
                title: title,
                previousScreenCall: backCallback,
                actions: actions,
                showBackButton: showBackButton,
              ),
            )
          : null,
      body: SafeArea(child: _wrapContent(child)),
      bottomNavigationBar: bottomNavigationBar == null
          ? null
          : _wrapContent(bottomNavigationBar!),
    );
  }

  PreferredSizeWidget _wrapAppBar(PreferredSizeWidget appBar) {
    if (maxWidth == null) return appBar;

    return PreferredSize(
      preferredSize: appBar.preferredSize,
      child: _wrapContent(appBar),
    );
  }

  Widget _wrapContent(Widget content) {
    if (maxWidth == null) return content;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: content,
      ),
    );
  }
}
