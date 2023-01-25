import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Theme', () {
    test('Test enum theme', () {
      const Enum e1 = BasfThemeType.yellow;
      const Enum e2 = BasfThemeType.red;

      expect(e1.runtimeType != e2.runtimeType, false);
      expect(Enum.compareByIndex(e1, e2), -1);
      // TODO(Dima): get this enum test working >:(
    });
  });
}
