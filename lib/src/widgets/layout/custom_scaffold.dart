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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: BasfColors.backgroundGrey,
      appBar: showAppBar ? CustomAppBar(
        title: title,
        previousScreenCall: backCallback,
        actions: actions,
        showBackButton: showBackButton,
      ) : null,
      body: SafeArea(child: child),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
