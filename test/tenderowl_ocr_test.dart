import 'package:flutter_test/flutter_test.dart';
import 'package:tenderowl_ocr/tenderowl_ocr.dart';
import 'package:tenderowl_ocr/tenderowl_ocr_platform_interface.dart';
import 'package:tenderowl_ocr/tenderowl_ocr_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTenderowlOcrPlatform
    with MockPlatformInterfaceMixin
    implements TenderowlOcrPlatform {
  @override
  Future<List<String>> extractTextFromImage(String path) =>
      Future.value(["Extracted", "Text"]);
}

void main() {
  final TenderowlOcrPlatform initialPlatform = TenderowlOcrPlatform.instance;

  test('$MethodChannelTenderowlOcr is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTenderowlOcr>());
  });

  test('extractTextFromImage', () async {
    TenderowlOcr tenderowlOcrPlugin = TenderowlOcr();
    MockTenderowlOcrPlatform fakePlatform = MockTenderowlOcrPlatform();
    TenderowlOcrPlatform.instance = fakePlatform;

    expect(await tenderowlOcrPlugin.extractTextFromImage("image.png"),
        ["Extracted", "Text"]);
  });
}
