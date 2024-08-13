import 'dart:async';
import 'dart:io';
import 'package:wortise/app_open_ad.dart';

class AppOpenAdManager {
  late AppOpenAd _appOpenAd;
  static AppOpenAdManager? _instance;

  int _refreshCount = 0;
  int _refreshTime = 30;
  Timer? _refreshTimer;

  factory AppOpenAdManager() {
    _instance ??= AppOpenAdManager._internal();
    return _instance!;
  }

  AppOpenAdManager._internal();

  void initializeAd(String key) {
    if (Platform.isAndroid) {
      _appOpenAd = AppOpenAd(
        key,
        listener: (event, _) {
          switch (event) {
            case AppOpenAdEvent.LOADED:
              _cancelRefreshTimer();
              _refreshCount = 0;
              _refreshTime = 30;
              break;
            case AppOpenAdEvent.DISMISSED:
              initializeAd(key);
              break;
            case AppOpenAdEvent.FAILED_TO_LOAD:
              _refreshCount++;
              if (_refreshCount < 3) {
                _startRefreshTimer(key);
              } else {
                _refreshTime *= 3;
                _startRefreshTimer(key);
              }
              break;
            case AppOpenAdEvent.SHOWN:
            default:
              break;
          }
        },
      );

      _appOpenAd.loadAd();
    }
  }

  void _startRefreshTimer(String key) {
    _refreshTimer = Timer(Duration(seconds: _refreshTime), () {
      initializeAd(key);
    });
  }

  void _cancelRefreshTimer() {
    _refreshTimer?.cancel();
  }

  Future<void> showAdIfAvailable() async {
    if (await _appOpenAd.isAvailable && Platform.isAndroid) {
      await _appOpenAd.showAd();
    }
  }
}
