// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'basf_components_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class BasfComponentsLocalizationsZh extends BasfComponentsLocalizations {
  BasfComponentsLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get cameraNotAvailable => '相机不可用';

  @override
  String get codeScanSuccessPhrase => '代码扫描成功';

  @override
  String get provideCameraPermission => '授予相机权限';

  @override
  String get rescan => '重新扫描';

  @override
  String get warning => '警告';

  @override
  String get generalAbort => '中止';

  @override
  String get generalConfirm => '确认';

  @override
  String get scanQRorBarcode => '扫描二维码或条形码';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class BasfComponentsLocalizationsZhHans extends BasfComponentsLocalizationsZh {
  BasfComponentsLocalizationsZhHans() : super('zh_Hans');

  @override
  String get cameraNotAvailable => '相机不可用';

  @override
  String get codeScanSuccessPhrase => '代码扫描成功';

  @override
  String get provideCameraPermission => '授予相机权限';

  @override
  String get rescan => '重新扫描';

  @override
  String get warning => '警告';

  @override
  String get generalAbort => '中止';

  @override
  String get generalConfirm => '确认';

  @override
  String get scanQRorBarcode => '扫描二维码或条形码';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class BasfComponentsLocalizationsZhHant extends BasfComponentsLocalizationsZh {
  BasfComponentsLocalizationsZhHant() : super('zh_Hant');

  @override
  String get cameraNotAvailable => '相機不可用';

  @override
  String get codeScanSuccessPhrase => '代碼掃描成功';

  @override
  String get provideCameraPermission => '授予相機權限';

  @override
  String get rescan => '重新掃描';

  @override
  String get warning => '警告';

  @override
  String get generalAbort => '中止';

  @override
  String get generalConfirm => '確認';

  @override
  String get scanQRorBarcode => '掃描二維碼或條碼';
}
