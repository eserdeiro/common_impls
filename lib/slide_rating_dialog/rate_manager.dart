import 'dart:developer';

import 'package:common_impls/common_impls.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:common_impls/slide_rating_dialog/slide_rating_dialog_base.dart';

class RateManager {
  static const String _rateCountKey = 'rate_count';
  static const String _rateDialogShownKey = 'rate_dialog_shown';
  static const String _rateValueKey = 'rate_value';
  static const String _rateSubmittedKey = 'rate_submitted';

  static const int _maxPushCount = 4;
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _rateCount = prefs.getInt(_rateCountKey) ?? 0;
    _rateDialogShown = prefs.getBool(_rateDialogShownKey) ?? false;
    _rateValue = prefs.getInt(_rateValueKey);
    _rateSubmitted = prefs.getBool(_rateSubmittedKey) ?? false;
  }

  static int _rateCount = 0;
  static bool _rateDialogShown = false;
  static int? _rateValue;
  static bool _rateSubmitted = false;

  static bool get rateShown => _rateCount >= _maxPushCount;

  static void incrementRateCount() {
    _rateCount++;
    _saveRateCount();
  }

  static Future<void> _saveRateCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_rateCountKey, _rateCount);
  }

  static void tryToShowRateDialog() {
    if (_rateDialogShown || (_rateValue != null && _rateSubmitted)) {
      return;
    }

    incrementRateCount();
    if (rateShown) {
      _rateCount = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showRateDialog();
      });
    }
  }

  static void _showRateDialog() {
    final globalNavigatorKey = CommonImpls().globalNavigatorKey;
    showDialog(
      context: globalNavigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SlideRatingDialog(
          title: 'Do you like this app?',
          foregroundColor: Colors.white,
          subTitle: 'Help us with 5 stars',
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          buttonTitle: 'Send',
          onRatingChanged: (rating) {
            _rateValue = rating;
            _saveRateValue();
          },
          buttonOnTap: () {
            if (_rateValue == null) {
              Navigator.of(context).pop();
              return;
            } else {
              _rateSubmitted = true;
              _rateDialogShown = true;
              _saveRateSubmitted();
              _saveRateDialogShown();
              Navigator.of(context).pop();
              if (_rateValue! >= 3) {
                goToRate();
              } else {
                log('thanks');
              }
            }
          },
        );
      },
      routeSettings: const RouteSettings(
        name: '/rate-dialog',
      ),
    );
  }

  static Future<void> goToRate() async {
    final inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    } else {
      await inAppReview.openStoreListing();
    }
  }

  static Future<void> _saveRateSubmitted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rateSubmittedKey, _rateSubmitted);
  }

  static Future<void> _saveRateValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_rateValueKey, _rateValue!);
  }

  static Future<void> _saveRateDialogShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rateDialogShownKey, _rateDialogShown);
  }
}
