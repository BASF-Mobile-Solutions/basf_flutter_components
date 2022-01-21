# basf_flutter_components

<p align="center">
  <img src="./assets/basf_logo.png" />
</p>	

<p align="center">
  <a href="https://pub.dev/packages/basf_flutter_components">
     <img alt="pub" src="https://img.shields.io/pub/v/basf_flutter_components.svg?label=basf_flutter_components">
  </a>
  <a href="mailto:Mobile-Solutions@basf.com">
     <img alt="email" src="https://img.shields.io/badge/Email-BASF%20Mobile%20Solutions-blue.svg">
  </a>
</p>

A BASF Flutter components library for iOS and Android

## Installing

Add BASF Flutter Components to your pubspec.yaml file:

```yaml
dependencies:
  basf_flutter_components:
```

Import it the library to your file:

```dart
import 'package:basf_flutter_components/basf_flutter_components.dart';
```

Use your IDE IntelliSense to import any of the [Components](#components) built into the library

---

## Getting Started

### iOS Setup

Specify the platform target in Podfile
```pod
platform :ios, '11.0'
```

### Android Setup

Ensure your `MainActivity`.kt/.java file class extends from `FlutterFragmentActivity`

**Java**
```java
public class MainActivity extends FlutterFragmentActivity {
	// Your code...
}
```

**Kotlin**
```kotlin
class MainActivity : FlutterFragmentActivity() {
	// Your code...
}
```

Remember to add the import at the top of the `MainActivity` file
```kotlin
import io.flutter.embedding.android.FlutterFragmentActivity;
```

---

## Components

- **Widgets**
  - BASFBUTTON...
  ```dart
  code example here
  ```

  - BASFTextButton...
  ```dart
  code example here
  ```

  - BASFTextField...
  ```dart
  code example here
  ```

  - BASFSnackbar...
  ```dart
  code example here
  ```

  ... etc...

  - Spacers
  ````dart
  // Vertical Spacers
  VerticalSpacer.xSmall()
  VerticalSpacer.small()
  VerticalSpacer.normal()
  VerticalSpacer.semi()
  VerticalSpacer.mediumSmall()
  VerticalSpacer.medium()
  VerticalSpacer.medium20()
  VerticalSpacer.mediumLarge()
  VerticalSpacer.large()
  VerticalSpacer.xLarge()
  VerticalSpacer.xxLarge()
  VerticalSpacer.xxxLarge()
  // Horizontal Spacers
  HorizontalSpacer.small()
  HorizontalSpacer.normal()
  HorizontalSpacer.semi()
  HorizontalSpacer.mediumSmall()
  HorizontalSpacer.medium()
  HorizontalSpacer.medium20()
  HorizontalSpacer.mediumLarge()
  HorizontalSpacer.large()
  HorizontalSpacer.xLarge()
  HorizontalSpacer.xxLarge()
  // Horizontal Spacer with text
  HorizontalSpacerWithText(
    text: 'example text',
    color: Colors.green,
  )
  ```

- **Colors**
  ```dart
  BASFColors.blue
  BASFColors.red
  BASFColors.black
  BASFColors.grey
  ```

- **Theme**
  ```dart
  BasfTheme.blue
  BasfTheme.green
  ```

- **TextStyles**
  ```dart
  BASFTextStyle.headline1
  BASFTextStyle.bodyText1
  ```
- **Styles**
  - Dimens

  Defines a preset of usefull standard paddings
  ```dart
  Dimens.paddingXSmall
  Dimens.paddingSmall
  Dimens.paddingDefault
  Dimens.paddingSemi
  Dimens.paddingMediumSmall
  Dimens.paddingMedium
  Dimens.paddingMedium20
  Dimens.paddingMediumLarge
  Dimens.paddingLarge
  Dimens.paddingXLarge
  Dimens.paddingXXLarge
  Dimens.paddingXXXLarge
  ```

- **One Trust**
  - initOneTrust

  Initialize OneTrust on your app
  ```dart
  await initOneTrust(
    domainIdentifier: Environment.otAppId,
    sdks: [
      Sdk(
        categoryId: 'S0002',
        changeSdkStatus: (status) {
          // Turn off SDK's depending on state
          logger.i('Crashlytics status: $status');
          FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(status);
        },
      ),
    ],
    languageCode: 'es',
    onInitParams: {
      //Params are not required
      'countryCode': 'US',
      'regionCode': 'CA',
    },
    storageLocation: 'my.domain.com', // usually 'cdn.cookielaw.org'
  );
  ```

  - OneTrustWidget

  A Widget that can be placed anywhere on the app and opens up the OneTrust Preference Center
  ```dart
  const OneTrustWidget(
    widget: Text('Open preference center'),
    widgetType: OneTrustUIWidget.preferenceCenter,
  );
  ```

- **Logger**

Based on `logger`, ready to use Small, easy to use and extensible logger which prints beautiful logs
  ```dart
  logger.v('Verbose log...');
  logger.d('Debug log');
  logger.i('Info log...');
  logger.w('Warning log');
  logger.e('Error log...');
  logger.wtf('👾 What a terrible failure log');
  ```
- **Extensions**

We also have some extensions
  - Colors
  ```dart
  // Get a Color from Hex value
  HexColor.fromHex('#ffffff');

  // Darken your color
  Color myColor = darken(Colors.red, 0.2);
  // or lighten it
  Color myColor = lighten(Colors.red, 0.2);
  ```

  - Strings
  ```dart
  String myString = 'this is my string'.toCapitalized; // This is my string
  // or
  String myString = 'this is my string'.toTitleCase; // This Is My String
  ```

