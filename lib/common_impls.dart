import 'package:flutter/material.dart';
export 'wortise/managers/app_open_ad_manager.dart';
export 'wortise/managers/interstitial_ad_manager.dart';
export 'wortise/managers/banner_ad_manager.dart';
export 'wortise/managers/native_ad_manager.dart';
export 'wortise/managers/native_ad_widget.dart';
export 'wortise/managers/rewarded_ad_claim_manager.dart';
export 'wortise/utils/loading_ad_dialog.dart';
export 'widgets/loader_animation.dart';
export 'widgets/splash_inkweel.dart';
export 'slide_rating_dialog/rate_manager.dart';
export 'slide_rating_dialog/slide_rating_dialog_base.dart';
export 'slide_rating_dialog/utils_rating_dialog.dart';
export 'constants/app_sizes.dart';

class CommonImpls {
  CommonImpls._privateConstructor(); // Private constructor

  static final CommonImpls _instance = CommonImpls._privateConstructor();

  factory CommonImpls() {
    return _instance;
  }
  GlobalKey<NavigatorState> get globalNavigatorKey => _globalNavigatorKey;

  static final GlobalKey<NavigatorState> _globalNavigatorKey =
      GlobalKey<NavigatorState>();
}
