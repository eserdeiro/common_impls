import 'dart:async';
import 'dart:ui';

import 'package:common_impls/src/constants/app_sizes.dart';
import 'package:common_impls/src/wortise/utils/loader_animation.dart';
import 'package:flutter/material.dart';

Future<void> loadingAdDialog({double size = 64}) async {
  // Create a GlobalKey to access the context of the dialog
  final dialogKey = GlobalKey<State<StatefulWidget>>();

  // Show the dialog using the GlobalKey
  await showDialog(
    context: dialogKey.currentContext!, // Access the context using the key
    barrierDismissible: false,
    builder: (context) {
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
                  const Text(
                    'loading ad',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
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
  );

  // Use Future.delayed to close the dialog after 2 seconds
  await Future.delayed(const Duration(seconds: 2), () {
    // Check if the dialog is still open
    if (dialogKey.currentState != null) {
      // Close the dialog using Navigator.pop
      Navigator.of(dialogKey.currentContext!).pop();
    }
  });
}
