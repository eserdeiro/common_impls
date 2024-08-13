import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wortise/ad_widget.dart';
import 'native_ad_manager.dart';

class NativeAdWidget extends StatelessWidget {
  final NativeAdManager adManager;
  final int index;
  final EdgeInsetsGeometry? padding;
  final double height;

  const NativeAdWidget({
    required this.adManager,
    required this.index,
    required this.height,
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? ValueListenableBuilder<bool>(
            valueListenable: adManager.isAdLoaded[index],
            builder: (context, isLoaded, child) {
              if (isLoaded) {
                return Container(
                  height: height,
                  padding: padding,
                  child: AdWidget(ad: adManager.getNativeAd(index)!),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        : const SizedBox.shrink();
  }
}
