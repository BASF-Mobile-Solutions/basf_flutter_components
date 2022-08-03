# Contributing to basf_flutter_components library

1. **Document new Components**: Widgets, Functions, etc... **with examples** in both `.dart` files and `README.md`
2. If necessary **add new exports** to `basf_flutter_components.dart` file
3. **Fix all linting issues** and run `flutter format .`
4. **Run `dart pub publish --dry-run`** to test everything it's ok with the version
5. Testing pub.dev score locally, first install **pana**: `flutter pub global activate pana`, and run `flutter pub global run pana ../basf_flutter_components`
6. If a new version is going to be published, **update version numbers** in both `CHANGELOG.md` and `pubspec.yaml`
7. **Test your code** by creating tests and generate a coverage file with [very_good_cli](https://pub.dev/packages/very_good_cli) using: `flutter test --coverage --test-randomize-ordering-seed random` afterwards, u can install [lcov](https://github.com/linux-test-project/lcov) `brew install lcov` and run `genhtml coverage/lcov.info -o coverage/html`to generate a `.html` report and see the actual code coverage, open it with `open coverage/index.html`
You can also install [Coverage Gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters) in VSCode to see real-time coverage in the IDE once the lcov is generated

```bash
# Generate lcov file
flutter test --coverage --test-randomize-ordering-seed random

# Generate html Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html

# Full command
flutter test --coverage --test-randomize-ordering-seed random && genhtml coverage/lcov.info -o coverage/html && open coverage/html/index.html
```

8. **Update `coverage_badge.svg`** file with the current coverage report percentage (there's two fields), update both of them with the same value.

9. **Run `flutter clean`** in example folder

# Publishing

Once merged to master the `publish` pipeline will automatically do `dart pub publish` when everything is ready for a new version
