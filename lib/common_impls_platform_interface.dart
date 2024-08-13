import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'common_impls_method_channel.dart';

abstract class CommonImplsPlatform extends PlatformInterface {
  /// Constructs a CommonImplsPlatform.
  CommonImplsPlatform() : super(token: _token);

  static final Object _token = Object();

  static CommonImplsPlatform _instance = MethodChannelCommonImpls();

  /// The default instance of [CommonImplsPlatform] to use.
  ///
  /// Defaults to [MethodChannelCommonImpls].
  static CommonImplsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CommonImplsPlatform] when
  /// they register themselves.
  static set instance(CommonImplsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
