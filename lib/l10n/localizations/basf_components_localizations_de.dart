// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'basf_components_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class BasfComponentsLocalizationsDe extends BasfComponentsLocalizations {
  BasfComponentsLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get cameraNotAvailable => 'Kamera ist nicht verfügbar';

  @override
  String get codeScanSuccessPhrase => 'Code erfolgreich gescannt';

  @override
  String get provideCameraPermission => 'Kameraberechtigung erteilen';

  @override
  String get rescan => 'Erneut scannen';

  @override
  String get warning => 'Warnung';

  @override
  String get generalAbort => 'Abbrechen';

  @override
  String get generalConfirm => 'Bestätigen';
}

/// The translations for German (`de_rlp`).
class BasfComponentsLocalizationsDeRlp extends BasfComponentsLocalizationsDe {
  BasfComponentsLocalizationsDeRlp() : super('de_rlp');

  @override
  String get cameraNotAvailable => 'Kamera ist nicht verfügbar';

  @override
  String get codeScanSuccessPhrase => 'Code erfolgreich gescannt';

  @override
  String get provideCameraPermission => 'Kameraberechtigung erteilen';

  @override
  String get rescan => 'Erneut scannen';

  @override
  String get warning => 'Warnung';

  @override
  String get generalAbort => 'Abbrechen';

  @override
  String get generalConfirm => 'Bestätigen';
}
