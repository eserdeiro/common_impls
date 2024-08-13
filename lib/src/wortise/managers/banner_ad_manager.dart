import 'package:flutter/material.dart';
import 'package:wortise/banner_ad.dart';

class BannerAdWidget extends StatefulWidget {
  final String bannerKey;
  const BannerAdWidget({super.key, required this.bannerKey});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  double height = 50;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: BannerAd(
        autoRefreshTime: 30,
        adUnitId: widget.bannerKey,
        listener: (event, _) {
          switch (event) {
            case BannerAdEvent.FAILED_TO_LOAD:
              {
                setState(() => height = 0);
              }
            case BannerAdEvent.LOADED:
              {
                setState(() => height = 50);
              }
            default:
              {}
          }
        },
      ),
    );
  }
}
