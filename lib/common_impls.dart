
import 'common_impls_platform_interface.dart';

class CommonImpls {
  Future<String?> getPlatformVersion() {
    return CommonImplsPlatform.instance.getPlatformVersion();
  }
}
