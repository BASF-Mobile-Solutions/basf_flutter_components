# basf_flutter_components

A BASF Flutter components library

![](./assets/basf_logo.png)

[![pub package](https://img.shields.io/pub/v/basf_flutter_components.svg?label=basf_flutter_components)](https://pub.dev/packages/basf_flutter_components)
[![Telegram](https://img.shields.io/badge/Email-BASF%20Mobile%20Solutions-blue.svg)](mailto:Mobile-Solutions@basf.com)

## Installing

Add BASF Flutter Components to your pubspec.yaml file:

```yaml
dependencies:
  basf_flutter_components:
```

Use your IDE IntelliSense to import any of the [Components](#components) built into the library

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

  - Widget...
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
