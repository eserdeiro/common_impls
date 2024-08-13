import 'package:flutter/material.dart';

class CommonImpls {
  CommonImpls._privateConstructor(); // Private constructor

  static final CommonImpls _instance = CommonImpls._privateConstructor();

  factory CommonImpls() {
    return _instance;
  }
  final GlobalKey<NavigatorState> globalNavigatorKey =
      GlobalKey<NavigatorState>();
}
