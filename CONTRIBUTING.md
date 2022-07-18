# Contributing to basf_flutter_components library

- Document new Components (Widgets, Functions, etc...) **with examples** in both `.dart` files and `README.md` **Components** section
- If necessary add the new export to `basf_flutter_components.dart` file
- **Fix all linting issues** and run `flutter format .`
- Run `dart pub publish --dry-run` to test everything it's ok
- Testing pub.dev score locally, first install **pana**: `flutter pub global activate pana`, and run `flutter pub global run pana ../basf_flutter_components`
- If a new version is going to be published, **update version numbers** in both `CHANGELOG.md` and `pubspec.yaml`
- **Test your code** by create tests and generate a coverage file with [very_good_cli](https://pub.dev/packages/very_good_cli) using: `very_good test --coverage` afterwards, u can install `brew install lcov` and run `genhtml coverage/lcov.info -o coverage/html`to generate a `.html` report and see the actual code coverage, open it with `open coverage/index.html`.
You can also install [Coverage Gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters) in VSCode to see real-time coverage in the IDE once the lcov is generated.

```bash
very_good test --coverage && genhtml coverage/lcov.info -o coverage/html && open coverage/html/index.html
```

- Update the `coverage_badge.svg` file with the current coverage report percentage (there's two fields)

- Run `flutter clean` in example folder

# Publishing

Once merged to master the `publish` pipeline will automatically do `dart pub publish` when everything is ready for a new version
