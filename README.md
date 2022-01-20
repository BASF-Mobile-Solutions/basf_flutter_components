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
  ```
  code example here
  ```

  - BASFTextButton...
  ```
  code example here
  ```

- **Colors**
  - blue...
  ```
  BASFColors.blue
  ```

- **Theme**
  - BasfTheme.blue
  ```
  BasfTheme.blue
  ```

  - BasfTheme.green
  ```
  BasfTheme.green
  ```

- **TextStyles**
  - BASFTextStyle.
  ```
  BasfTheme.headline1
  ```

- **One Trust**
  - Widget...
  ```
  code example here
  ```

  - initOneTrust...
  ```
  code example here
  ```
