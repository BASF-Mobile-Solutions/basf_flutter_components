# basf_flutter_components

<p align="center">
  <img src="https://raw.githubusercontent.com/BASF-Mobile-Solutions/basf_flutter_components/master/assets/basf_logo.png" />
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
  // TODO
  code example here
  ```

  - BASFTextButton...
  ```dart
  // TODO
  code example here
  ```

  - BASFTextField...
  ```dart
  // TODO
  code example here
  ```

  - BASFSnackbar...
  ```dart
  // TODO
  code example here
  ```

  - Spacers
  ```dart
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
  // TODO
  BASFColors.blue
  BASFColors.red
  BASFColors.black
  BASFColors.grey
  ...
  ```

- **Theme**
  ```dart
  // TODO
  BasfTheme.blue
  BasfTheme.green
  ```

- **TextStyles**
  ```dart
  // TODO
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
  
- **Utils**

A variety of predefines regexp, alias, and extensions are available

