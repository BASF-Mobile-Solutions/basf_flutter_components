# basf_flutter_components

A BASF Flutter components library.

## Getting Started

### iOS Setup

Specify the platform target in Podfile
```pod
platform :ios, '11.0'
```
### Android Setup

Ensure your `MainActivity` class extends from `FlutterFragmentActivity`

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
```
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