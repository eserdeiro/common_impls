import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'common_impls_platform_interface.dart';

/// An implementation of [CommonImplsPlatform] that uses method channels.
class MethodChannelCommonImpls extends CommonImplsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('common_impls');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
