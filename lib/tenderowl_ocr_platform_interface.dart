import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tenderowl_ocr_method_channel.dart';

abstract class TenderowlOcrPlatform extends PlatformInterface {
  /// Constructs a TenderowlOcrPlatform.
  TenderowlOcrPlatform() : super(token: _token);

  static final Object _token = Object();

  static TenderowlOcrPlatform _instance = MethodChannelTenderowlOcr();

  /// The default instance of [TenderowlOcrPlatform] to use.
  ///
  /// Defaults to [MethodChannelTenderowlOcr].
  static TenderowlOcrPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TenderowlOcrPlatform] when
  /// they register themselves.
  static set instance(TenderowlOcrPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
