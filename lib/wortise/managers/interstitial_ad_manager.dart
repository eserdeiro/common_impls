import 'dart:async';
import 'dart:io';
import 'package:common_impls/wortise/utils/loading_ad_dialog.dart';
import 'package:wortise/interstitial_ad.dart';

class InterstitialAdManager {
  late InterstitialAd _interstitialAd;
  static InterstitialAdManager? _instance;

  late int _maxAdCallCount;
  late int _adCallCount;
  int _refreshCount = 0;
  int _refreshTime = 30;
  Timer? _refreshTimer;

  factory InterstitialAdManager() {
    _instance ??= InterstitialAdManager._internal();
    return _instance!;
  }

  InterstitialAdManager._internal();

  bool get interstitialShown => _adCallCount >= _maxAdCallCount;

  void initializeAd(String key, int maxAdCallCount) {
    _maxAdCallCount = maxAdCallCount;
    _adCallCount = _maxAdCallCount - 1;

    if (Platform.isAndroid) {
      _interstitialAd = InterstitialAd(key, (event, _) {
        switch (event) {
          case InterstitialAdEvent.LOADED:
            _cancelRefreshTimer();
            _refreshCount = 0;
            _refreshTime = 30;
            break;
          case InterstitialAdEvent.DISMISSED:
            initializeAd(key, maxAdCallCount);
            break;
          case InterstitialAdEvent.FAILED_TO_LOAD:
            _refreshCount++;
            if (_refreshCount < 3) {
              _startRefreshTimer(key, maxAdCallCount);
            } else {
              _refreshTime *= 3;
              _startRefreshTimer(key, maxAdCallCount);
            }
            break;
          default:
            break;
        }
      });

      _interstitialAd.loadAd();
    }
  }

  void _startRefreshTimer(String key, int maxAdCallCount) {
    _refreshTimer = Timer(Duration(seconds: _refreshTime), () {
      initializeAd(key, maxAdCallCount);
    });
  }

  void _cancelRefreshTimer() {
    _refreshTimer?.cancel();
  }

  Future<void> showAdIfAvailable() async {
    _adCallCount++;
    final interstitialShown = InterstitialAdManager().interstitialShown;
    if (!(await _interstitialAd.isAvailable) ||
        !interstitialShown ||
        !Platform.isAndroid) {
      return;
    }

    _adCallCount = 0;
    await loadingAdDialog();
    await _interstitialAd.showAd();
  }
}
