import 'package:flutter/foundation.dart';
import 'package:wortise/google_native_ad.dart';

class NativeAdManager {
  final int maxAds;
  final String adType;
  final List<GoogleNativeAd?> _nativeAds;
  final List<ValueNotifier<bool>> _isAdLoaded;

  NativeAdManager(this.maxAds, this.adType)
      : _nativeAds = List.generate(maxAds, (index) => null),
        _isAdLoaded = List.generate(
          maxAds,
          (index) => ValueNotifier<bool>(false),
        );

  List<ValueNotifier<bool>> get isAdLoaded => _isAdLoaded;

  void loadNativeAds({required String key}) {
    for (var i = 0; i < _nativeAds.length; i++) {
      _nativeAds[i] = GoogleNativeAd(
        key,
        adType,
        (event, args) {
          if (event == GoogleNativeAdEvent.LOADED) {
            _isAdLoaded[i].value = true;
          } else if (event == GoogleNativeAdEvent.FAILED) {
            _nativeAds[i]?.destroy();
            _isAdLoaded[i].value = false;
          }
        },
      );
      _nativeAds[i]!.load();
    }
  }

  void destroyNativeAds() {
    for (final ad in _nativeAds) {
      ad?.destroy();
    }
  }

  GoogleNativeAd? getNativeAd(int index) {
    return _nativeAds[index];
  }
}
