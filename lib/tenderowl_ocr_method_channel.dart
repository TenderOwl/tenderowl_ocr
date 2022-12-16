import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tenderowl_ocr_platform_interface.dart';

/// An implementation of [TenderowlOcrPlatform] that uses method channels.
class MethodChannelTenderowlOcr extends TenderowlOcrPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tenderowl_ocr');

  @override
  Future<List<String>?> extractTextFromImage(String path) async {
    List<Object?>? response = await methodChannel.invokeMethod<List<Object?>>(
      'extractTextFromImage',
      path,
    );

    // Process response because MethodChannel returns only List of Object?
    if (response == null) return [];

    // If list is not empty try to convert it to List<String>
    List<String> result = [];
    for (var item in response) {
      if (item != null) result.add(item.toString());
    }

    return result;
  }
}
