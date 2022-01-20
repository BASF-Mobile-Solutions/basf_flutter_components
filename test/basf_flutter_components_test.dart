import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';

void main() {
  const MethodChannel channel = MethodChannel('basf_flutter_components');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await BasfFlutterComponents.platformVersion, '42');
  });
}
