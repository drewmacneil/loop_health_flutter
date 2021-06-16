import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loop_health_flutter/loop_health_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('loop_health_flutter');

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
    expect(await LoopHealthFlutter.platformVersion, '42');
  });
}
