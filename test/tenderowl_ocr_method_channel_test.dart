import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tenderowl_ocr/tenderowl_ocr_method_channel.dart';

void main() {
  MethodChannelTenderowlOcr platform = MethodChannelTenderowlOcr();
  const MethodChannel channel = MethodChannel('tenderowl_ocr');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
