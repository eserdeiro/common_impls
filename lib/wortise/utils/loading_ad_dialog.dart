import 'dart:async';
import 'dart:ui';
import 'package:common_impls/common_impls.dart';
import 'package:flutter/material.dart';
import 'package:common_impls/constants/app_sizes.dart';
import 'package:common_impls/widgets/loader_animation.dart';

Future<void> loadingAdDialog({double size = Sizes.p64, String? text}) async {
  final globalNavigatorKey = CommonImpls().globalNavigatorKey;
  Future.delayed(const Duration(seconds: 2), () {
    if (globalNavigatorKey.currentState?.canPop() ?? false) {
      globalNavigatorKey.currentState
          ?.popUntil((route) => route.settings.name != '/loading-dialog');
    }
  });

  await showDialog(
    context: globalNavigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Center(
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text ?? 'Loading ad',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: Sizes.p24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  gapH24,
                  LoaderAnimation(size: size),
                ],
              ),
            ),
          ),
        ],
      );
    },
    routeSettings: const RouteSettings(
      name: '/loading-dialog',
    ),
  );
}
