# basf_flutter_components

A BASF Flutter components library.

![](./assets/basf_logo.png)

[![pub package](https://img.shields.io/pub/v/basf_flutter_components.svg?label=basf_flutter_components)](https://pub.dev/packages/basf_flutter_components)
[![Telegram](https://img.shields.io/badge/Email-BASF%20Mobile%20Solutions-blue.svg)](mailto:Mobile-Solutions@basf.com)

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
  ```

- **Theme**
  ```dart
  BasfTheme.blue
  BasfTheme.green
  ```

- **TextStyles**
  ```dart
  BASFTextStyle.
  BasfTheme.headline1
  ```
- **Styles**
  - Dimens: Defines a preset of usefull standard paddings
  ```dart
  Dimens.paddingXSmall;
  Dimens.paddingSmall;
  Dimens.paddingDefault;
  Dimens.paddingSemi;
  Dimens.paddingMediumSmall;
  Dimens.paddingMedium;
  Dimens.paddingMedium20;
  Dimens.paddingMediumLarge;
  Dimens.paddingLarge;
  Dimens.paddingXLarge;
  Dimens.paddingXXLarge;
  Dimens.paddingXXXLarge;
  ```

- **One Trust**
  - Widget...
  ```dart
  code example here
  ```

  - initOneTrust...
  ```dart
  code example here
  ```
