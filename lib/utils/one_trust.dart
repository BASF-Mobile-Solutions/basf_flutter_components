import 'package:basf_flutter_components/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:onetrust_publishers_native_cmp/onetrust_publishers_native_cmp.dart';

/// A class that holds the necessary information for
/// [OneTrust] Sdk to turn on or off each Individual [Sdk]
///
/// Example:
/// ```dart
///      Sdk(
///        categoryId: 'S0002',
///        changeSdkStatus: (status) async {
///          // Turn off SDK's depending on state
///          await FirebaseCrashlytics.instance
///              .setCrashlyticsCollectionEnabled(status);
///          // Delete unuset reports from Crashlytics if it's disabled
///          if (status == false) {
///            // FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled
///            logger.d('Deleted Crashlytics reports');
///            await FirebaseCrashlytics.instance.deleteUnsentReports();
///          }
///          logger.d('Crashlytics status: $status');
///        },
///      );
/// ```
///
/// See also:
///
///  * [initOneTrust]
class Sdk {
  /// Refers to each individual categoryId for the [Sdk] your
  /// app uses
  ///
  /// ```dart
  ///     categoryId: 'S0002',
  /// ```
  String categoryId;

  /// Refers to the function you use to turn on or off each [Sdk]
  /// inside the app
  ///
  /// ```dart
  ///      changeSdkStatus: (status) async {
  ///        // Turn off SDK's depending on state
  ///        await FirebaseCrashlytics.instance
  ///            .setCrashlyticsCollectionEnabled(status);
  ///        // Delete unuset reports from Crashlytics if it's disabled
  ///        if (status == false) {
  ///          // FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled
  ///          logger.d('Deleted Crashlytics reports');
  ///          await FirebaseCrashlytics.instance.deleteUnsentReports();
  ///        }
  ///        logger.d('Crashlytics status: $status');
  ///      },
  /// ```
  Future<void> Function(bool) changeSdkStatus;

  Sdk({
    required this.categoryId,
    required this.changeSdkStatus,
  });
}

/// Initialize [OneTrust] on your app
///
/// You can reach on changes based on the choices the user make
/// turning on or off each Sdk based on its [categoryId]
///
/// The arguments correspond to the properties on [OTPublishersNativeSDK.startSDK].
///
/// If the application has a diferent [storageLocation] remember to change that
/// if not, it defaults to 'cdn.cookielaw.org'
///
/// The [domainIdentifier] refers to the One Trust App Id
///
/// [onInitParams] are not required but it refers for example to the
/// [countryCode] or [regionCode]
///
/// Fill [sdks] wich each [categoryId] and the function wich determines the
/// status of the sdk via [changeSdkStatus]
///
/// Example:
/// ```dart
///  await initOneTrust(
///    domainIdentifier: Environment.otAppId,
///    sdks: [
///      Sdk(
///        categoryId: 'S0002',
///        changeSdkStatus: (status) async {
///          // Turn off SDK's depending on state
///          await FirebaseCrashlytics.instance
///              .setCrashlyticsCollectionEnabled(status);
///          // Delete unuset reports from Crashlytics if it's disabled
///          if (status == false) {
///            // FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled
///            logger.d('Deleted Crashlytics reports');
///            await FirebaseCrashlytics.instance.deleteUnsentReports();
///          }
///          logger.d('Crashlytics status: $status');
///        },
///      ),
///    ],
///    languageCode: 'es',
///    onInitParams: {
///      //Params are not required
///      'countryCode': 'US',
///      'regionCode': 'CA',
///    },
///    storageLocation: 'my.domain.com', // usually 'cdn.cookielaw.org'
///  );
/// ```
///
/// See also:
///
///  * [Sdk]
///  * [OneTrustWidget]
Future<void> initOneTrust({
  String storageLocation = 'cdn.cookielaw.org',
  required String domainIdentifier,
  String languageCode = 'en',
  Map<String, String>? onInitParams,
  required List<Sdk> sdks,
}) async {
  await OTPublishersNativeSDK.startSDK(
    storageLocation,
    domainIdentifier,
    languageCode,
    onInitParams,
  );

  bool shouldShowBanner = await OTPublishersNativeSDK.shouldShowBanner();
  if (shouldShowBanner) {
    OTPublishersNativeSDK.showBannerUI();
  }

  _startListening(sdks);
}

/// Turns On/Off each sdk depending on the [categoryId] and its [consentStatus]
void _startListening(List<Sdk> sdks) {
  OTPublishersNativeSDK.listenForConsentChanges(
    List.generate(sdks.length, (index) => sdks[index].categoryId),
  ).listen(
    (event) async {
      logger.i(
          'OneTrust Consent Changes: New status for ${event["categoryId"]} is ${event["consentStatus"]}');

      // ? Future: Adapt depending on individual sdk not only categoryId
      await sdks
          .firstWhere((element) => element.categoryId == event['categoryId'])
          .changeSdkStatus(event['consentStatus'] == 0 ? false : true);
    },
  );

  OTPublishersNativeSDK.listenForUIInteractions()
      .listen((event) => logger.i('OneTrust UI Interactions:\n\t$event'));

  // ? consentListener.cancel(); //Cancel event stream before opening a new one
}

/// A [enum] that defines both kind of OneTrust pages
///
/// ```dart
/// OneTrustUIWidget.preferenceCenter
/// // or
/// OneTrustUIWidget.banner
/// ```
///
/// Depending on your choice it defines wich kind of OneTrust Page will be shown
///
/// See also:
///
///  * [OneTrustWidget] and its [widgetType] property
enum OneTrustUIWidget { preferenceCenter, banner }

/// A [Widget] that can be placed anywhere on the app and opens up
/// the OneTrust Preference Center
///
/// Example:
/// ```dart
///  const OneTrustWidget(
///    widget: Text('Open preference center'),
///    widgetType: OneTrustUIWidget.preferenceCenter,
///  );
/// ```
///
/// See also:
///
///  * [OneTrustUIWidget]
///  * [initOneTrust]
class OneTrustWidget extends StatelessWidget {
  /// A property wich defines wich type of OneTrust Page will
  /// be shown to the user
  ///
  /// ```dart
  ///  const OneTrustWidget(
  ///    widgetType: OneTrustUIWidget.preferenceCenter,
  ///  );
  ///  // or
  ///  const OneTrustWidget(
  ///    widgetType: OneTrustUIWidget.banner,
  ///  );
  /// ```
  final OneTrustUIWidget widgetType;

  /// A Widget can be passed to show a different Widget under the
  /// TextButton itself, it defaults to
  ///
  /// ```dart
  ///  Icon(Icons.settings_rounded),
  /// ```
  /// But you can define your own child widget too
  /// ```dart
  ///  const OneTrustWidget(
  ///    widget: Text('Open preference center'),
  ///  );
  /// ```
  final Widget? widget;

  const OneTrustWidget({
    Key? key,
    this.widgetType = OneTrustUIWidget.banner,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: widget ?? const Icon(Icons.settings_rounded),
      onPressed: () {
        switch (widgetType) {
          case OneTrustUIWidget.preferenceCenter:
            OTPublishersNativeSDK.showPreferenceCenterUI();
            break;

          case OneTrustUIWidget.banner:
            OTPublishersNativeSDK.showBannerUI();
            break;
        }
      },
    );
  }
}
