import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tenderowl_ocr_platform_interface.dart';

/// An implementation of [TenderowlOcrPlatform] that uses method channels.
class MethodChannelTenderowlOcr extends TenderowlOcrPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tenderowl_ocr');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
