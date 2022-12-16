
import 'tenderowl_ocr_platform_interface.dart';

class TenderowlOcr {
  Future<String?> getPlatformVersion() {
    return TenderowlOcrPlatform.instance.getPlatformVersion();
  }
}
