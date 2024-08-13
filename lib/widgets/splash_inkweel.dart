import 'package:flutter/material.dart';

class SplashInkwell extends StatelessWidget {
  final Function()? onTap;

  const SplashInkwell({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
