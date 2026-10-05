// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'basf_components_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class BasfComponentsLocalizationsNl extends BasfComponentsLocalizations {
  BasfComponentsLocalizationsNl([String locale = 'nl']) : super(locale);

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
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get close => 'Close';

  @override
  String get showMorePhrase => 'Show more';

  @override
  String get generalAbort => 'Cancel';

  @override
  String get generalConfirm => 'Confirm';

  @override
  String get scanQRorBarcode => 'Scan QR or Barcode';

  @override
  String get copy => 'Copy';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get generalDetails => 'Details';
}

/// The translations for Dutch Flemish, as used in Belgium (`nl_BE`).
class BasfComponentsLocalizationsNlBe extends BasfComponentsLocalizationsNl {
  BasfComponentsLocalizationsNlBe() : super('nl_BE');

  @override
  String get cameraNotAvailable => 'Camera is niet beschikbaar';

  @override
  String get codeScanSuccessPhrase => 'Code succesvol gescand';

  @override
  String get provideCameraPermission => 'Toegang tot camera toestaan';

  @override
  String get rescan => 'Opnieuw scannen';

  @override
  String get warning => 'Waarschuwing';

  @override
  String get error => 'Fout';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get close => 'Sluiten';

  @override
  String get showMorePhrase => 'Meer tonen';

  @override
  String get generalAbort => 'Annuleren';

  @override
  String get generalConfirm => 'Bevestigen';

  @override
  String get scanQRorBarcode => 'QR-code of barcode scannen';

  @override
  String get copy => 'Kopiëren';

  @override
  String get copiedToClipboard => 'Gekopieerd naar klembord';

  @override
  String get generalDetails => 'Details';
}
