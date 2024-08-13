import 'dart:async';
import 'dart:ui';
import 'package:common_impls/src/wortise/utils/global_key.dart';
import 'package:common_impls/src/wortise/utils/loader_animation.dart';
import 'package:flutter/material.dart';

Future<void> loadingAdDialog({double size = 64.0}) async {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Stack(
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
                const Text(
                  'loading ad',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24.0),
                LoaderAnimation(size: size),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  globalNavigatorKey.currentState?.overlay?.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
