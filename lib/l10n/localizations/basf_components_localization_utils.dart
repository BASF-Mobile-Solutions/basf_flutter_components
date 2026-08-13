import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:material_ui/material_ui.dart';

///
class BasfComponentsLocalizationUtils {
  ///
  static void setNavigatorKey(GlobalKey<NavigatorState> key) {
    appNavigatorKey = key;
  }

  /// REQUIRED TO USE THE
  static late GlobalKey<NavigatorState> appNavigatorKey;

  ///
  static BasfComponentsLocalizations get localizations =>
      BasfComponentsLocalizations.of(appNavigatorKey.currentContext!);
}
