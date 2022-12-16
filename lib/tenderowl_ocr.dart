import 'tenderowl_ocr_platform_interface.dart';

class TenderowlOcr {
  Future<List<String>?> extractTextFromImage(String path) {
    return TenderowlOcrPlatform.instance.extractTextFromImage(path);
  }
}
