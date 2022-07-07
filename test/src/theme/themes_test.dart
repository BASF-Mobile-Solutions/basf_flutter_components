import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Theme', () {
    test('Test enum theme', () {
      const Enum e1 = BasfThemeType.yellow, e2 = BasfThemeType.red;
      expect(e1.runtimeType != e2.runtimeType, false);
      expect(Enum.compareByIndex(e1, e2), -1);
      // TODO(carlos): figure out what I'm supposed to do to get rid of
      // ! line 7 untested in themes.dart
    });
  });
}
