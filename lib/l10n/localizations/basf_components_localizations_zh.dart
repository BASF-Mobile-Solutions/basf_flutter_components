// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'basf_components_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class BasfComponentsLocalizationsZh extends BasfComponentsLocalizations {
  BasfComponentsLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get cameraNotAvailable => 'Camera is not available';

  @override
  String get codeScanSuccessPhrase => 'Code scanned successfully';

  @override
  String get provideCameraPermission => 'Provide Camera Permission';

  @override
  String get rescan => 'Rescan';

  @override
  String get warning => 'Warning';

  @override
  String get generalAbort => 'Cancel';

  @override
  String get generalConfirm => 'Confirm';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class BasfComponentsLocalizationsZhHans extends BasfComponentsLocalizationsZh {
  BasfComponentsLocalizationsZhHans() : super('zh_Hans');
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class BasfComponentsLocalizationsZhHant extends BasfComponentsLocalizationsZh {
  BasfComponentsLocalizationsZhHant() : super('zh_Hant');
}
