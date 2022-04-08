# Contributing to basf_flutter_components library

- Document new Components (Widgets, Functions, etc...) **with examples** in both `.dart` files and `README.md` **Components** section
- If necessary add the new export to `basf_flutter_components.dart` file
- Fix all linting issues and run `flutter format .`
- Run `dart pub publish --dry-run` to test everything it's ok
- If a new version is going to be published, add it to both `CHANGELOG.md` and `pubspec.yaml`
- Run `flutter clean` in example folder

Use `dart pub publish` when everything is ready for a new version
