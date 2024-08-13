import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wortise/rewarded_ad.dart';

class RewardedAdClaimManager {
  late RewardedAd _rewardedAd;
  static RewardedAdClaimManager? _instance;

  int _refreshCount = 0;
  int _refreshTime = 15;
  Timer? _refreshTimer;

  // Callback for when the ad is successfully watched
  Function? onAdCompletedCallback;

  // Callback for when the ad fails to load
  Function? onAdLoadFailedCallback;

  // Callback for when the ad fails to load
  Function? onAdDismissedCallback;

  // Callback for when the ad fails to load
  Function? onAdLoadedCallback;

  final ValueNotifier<bool> adLoadedNotifier = ValueNotifier<bool>(false);

  factory RewardedAdClaimManager() {
    _instance ??= RewardedAdClaimManager._internal();
    return _instance!;
  }

  RewardedAdClaimManager._internal();

  void initializeAd({required String key}) {
    if (Platform.isAndroid) {
      _rewardedAd = RewardedAd(
        key,
        (event, _) {
          switch (event) {
            case RewardedAdEvent.LOADED:
              // log('AD rewarded LOADED');
              adLoadedNotifier.value = true;
              onAdLoadedCallback?.call();
              _cancelRefreshTimer();
              _refreshCount = 0;
              _refreshTime = 15;
            case RewardedAdEvent.DISMISSED:
              // log('AD rewarded DISMISSED ');
              adLoadedNotifier.value = false;
              onAdDismissedCallback?.call();
              initializeAd(key: key);
            case RewardedAdEvent.FAILED_TO_LOAD:
              // log('AD rewarded FAILED TO LOAD');
              adLoadedNotifier.value = false;
              onAdLoadFailedCallback?.call();
              _refreshCount++;
              if (_refreshCount < 3) {
                _startRefreshTimer(key);
              } else {
                _refreshTime *= 3;
                _startRefreshTimer(key);
              }
            case RewardedAdEvent.COMPLETED:
              // log('AD rewarded COMPLETED ');
              onAdCompletedCallback?.call();
            case RewardedAdEvent.SHOWN:
            // log('AD rewarded SHOWN ');
            default:
              break;
          }
        },
      );

      _rewardedAd.loadAd();
    }
  }

  void _startRefreshTimer(String key) {
    _refreshTimer = Timer(Duration(seconds: _refreshTime), () {
      initializeAd(key: key);
    });
  }

  void cancelAndRequestAd(String key) {
    _cancelRefreshTimer();
    _refreshCount = 0;
    _refreshTime = 15;
    initializeAd(key: key);
  }

  void _cancelRefreshTimer() {
    _refreshTimer?.cancel();
  }

  Future<void> showAdIfAvailable() async {
    // log('show ad if available fuera');
    if (await _rewardedAd.isAvailable && Platform.isAndroid) {
      // log('show ad if available called');
      await _rewardedAd.showAd();
    }
  }
}
